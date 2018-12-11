package example.shop.controller;

import example.shop.domain.ProductEntity;
import example.shop.repos.ProductDataRepo;
import example.shop.repos.ProductEntityRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {
    @Autowired
    private ProductEntityRepo productEntityRepo;
    @Autowired
    private ProductDataRepo productDataRepo;

    @GetMapping("/")
    public String home(Model model)
    {
        Iterable<ProductEntity> productEntities = productEntityRepo.findAll();
        model.addAttribute("productEntities", productEntities);

        return "home";
    }
}
