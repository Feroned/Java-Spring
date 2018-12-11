package example.shop.controller;

import example.shop.domain.ProductData;
import example.shop.domain.ProductEntity;
import example.shop.repos.ProductDataRepo;
import example.shop.repos.ProductEntityRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class AddProductController {
    @Autowired
    private ProductEntityRepo productEntityRepo;
    @Autowired
    private ProductDataRepo productDataRepo;

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
            Model model
    ) {
        ProductEntity productEntity = new ProductEntity(name, shortDescription, price);
        productEntityRepo.save(productEntity);
        ProductData prData = new ProductData(productEntity.getId(), description, availability, quantity);
        productDataRepo.save(prData);

        Iterable<ProductEntity> productEntities = productEntityRepo.findAll();
        model.addAttribute("productEntities", productEntities);
        return "products";
    }

}
