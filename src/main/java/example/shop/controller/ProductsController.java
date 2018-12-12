package example.shop.controller;

import com.sun.org.apache.xpath.internal.operations.Mod;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class ProductsController {
    private final ProductEntityRepo productEntityRepo;
    private final ProductDataRepo productDataRepo;

    @Autowired
    public ProductsController(ProductEntityRepo productEntityRepo, ProductDataRepo productDataRepo) {
        this.productEntityRepo = productEntityRepo;
        this.productDataRepo = productDataRepo;
    }

    @GetMapping("/products")
    public String productsList(
            Model model,
            @PageableDefault(sort = {"id"}, direction = Sort.Direction.ASC) Pageable pageable
    ) {
        Page<ProductEntity> productEntities = productEntityRepo.findAll(pageable);
        model.addAttribute("productEntities", productEntities);
        model.addAttribute("url", "/products");

        return "products";
    }

    @GetMapping("/editProduct/{product}")
    public String editProduct(
            @PathVariable Integer product,
            Model model
    ) {
        ProductData productData;
        productData = productDataRepo.findByProductId(product).get(0);

        ProductEntity productEntity;
        productEntity = productEntityRepo.findById(product).get(0);

        model.addAttribute("productEntity", productEntity);
        model.addAttribute("productData", productData);
        return "editProduct";
    }

    @PostMapping("/editProduct")
    public String saveProduct(
            @RequestParam String name,
            @RequestParam Integer price,
            @RequestParam String shortDescription,
            @RequestParam Integer availability,
            @RequestParam Integer quantity,
            @RequestParam String description,
            @RequestParam Integer id
    )
    {
        ProductEntity productEntity;
        productEntity = productEntityRepo.findById(id).get(0);

        ProductData productData;
        productData = productDataRepo.findByProductId(id).get(0);

        productEntity.setName(name);
        productEntity.setPrice(price);
        productEntity.setShortDescription(shortDescription);

        productData.setAvailability(availability);
        productData.setDescription(description);
        productData.setQuantity(quantity);

        productEntityRepo.save(productEntity);
        productDataRepo.save(productData);

        return "redirect:/products";
    }

    @PostMapping("/deleteProducts")
    public String deleteProducts(@RequestParam Map<String, String> todelete)
    {
        ProductEntity productEntity;
        ProductData productData;
        Integer id;

        for (Map.Entry<String, String> entry : todelete.entrySet()) {
            String val = entry.getValue();
            String k = entry.getKey().substring(3);

            try {
                id = Integer.parseInt(val);
            } catch (Exception e) {
                continue;
            }
            productEntity = productEntityRepo.findById(id).get(0);
            productData = productDataRepo.findByProductId(id).get(0);

            productEntityRepo.delete(productEntity);
            productDataRepo.delete(productData);
        }
        return "redirect:/products";
    }

    @GetMapping("/admin")
    public String authorizathion(Map<String, Object> model)
    {
        return "admin";
    }
}
