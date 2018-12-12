package example.shop.controller;

import example.shop.domain.ProductEntity;
import example.shop.repos.ProductDataRepo;
import example.shop.repos.ProductEntityRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.lang.reflect.Array;
import java.util.*;

@Controller
public class HomeController {

    private final ProductEntityRepo productEntityRepo;

    @Autowired
    public HomeController(ProductEntityRepo productEntityRepo) {
        this.productEntityRepo = productEntityRepo;
    }

    @GetMapping("/")
    public String redirectToHome()
    {
        return "redirect:/catalog";
    }

    @GetMapping("/catalog")
    public String home(
            @RequestParam(required = false, defaultValue = "") String nameFilter,
            @RequestParam(required = false, defaultValue = "") String fromFilter,
            @RequestParam(required = false, defaultValue = "") String toFilter,
            @RequestParam(required = false, defaultValue = "") String order,
            @PageableDefault(sort = {"name"}, direction = Sort.Direction.ASC, size = 6) Pageable pageable,
            Model model
    ) {
        Page<ProductEntity> productEntities;
        Integer tempFrom = fromFilter.isEmpty() ? 0 : Integer.parseInt(fromFilter);
        Integer tempTo = toFilter.isEmpty() ? 999999 : Integer.parseInt(toFilter);
        Integer orderVal = 0;

        if (!order.isEmpty() && order.equals("name")) {
            productEntities = productEntityRepo
                    .findByNameContainingAndPriceBetweenOrderByNameAsc(
                            nameFilter,
                            tempFrom,
                            tempTo,
                            pageable
                    );
            orderVal = 1;
        } else if (!order.isEmpty() && order.equals("price")) {
            productEntities = productEntityRepo
                    .findByNameContainingAndPriceBetweenOrderByPriceAsc(
                            nameFilter,
                            tempFrom,
                            tempTo,
                            pageable
                    );
            orderVal = 2;
        } else {
            productEntities = productEntityRepo
                    .findByNameContainingAndPriceBetween(
                            nameFilter,
                            tempFrom,
                            tempTo,
                            pageable
                    );
        }
        model.addAttribute("productEntities", productEntities);
        model.addAttribute("url", "/catalog");
        model.addAttribute("nameFilter", nameFilter);
        model.addAttribute("fromFilter", fromFilter);
        model.addAttribute("toFilter", toFilter);
        model.addAttribute("order", orderVal);

        return "home";
    }
}
