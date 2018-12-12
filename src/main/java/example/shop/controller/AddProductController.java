package example.shop.controller;

import example.shop.domain.ProductData;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class AddProductController {
    private final ProductEntityRepo productEntityRepo;
    private final ProductDataRepo productDataRepo;

    @Autowired
    public AddProductController(ProductEntityRepo productEntityRepo, ProductDataRepo productDataRepo) {
        this.productEntityRepo = productEntityRepo;
        this.productDataRepo = productDataRepo;
    }

    @GetMapping("/addProduct")
    public String addProduct ()
    {
        return "addproduct";
    }

    @PostMapping
    public String addProduct(
            @RequestParam String name,
            @RequestParam Integer price,
            @RequestParam String shortDescription,
            @RequestParam Integer availability,
            @RequestParam Integer quantity,
            @RequestParam String description,
            @PageableDefault(sort = {"name"}, direction = Sort.Direction.ASC, size = 6) Pageable pageable,
            Model model
    ) {
        ProductEntity productEntity = new ProductEntity(name, shortDescription, price);
        productEntityRepo.save(productEntity);
        ProductData prData = new ProductData(productEntity.getId(), description, availability, quantity);
        productDataRepo.save(prData);

//        Page<ProductEntity> productEntities = productEntityRepo.findAll(pageable);
//        model.addAttribute("productEntities", productEntities);
//        model.addAttribute("url", "/products");
        return "redirect:/products";
    }

}
