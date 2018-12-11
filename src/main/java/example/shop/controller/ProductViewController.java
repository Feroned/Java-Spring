package example.shop.controller;

import example.shop.domain.ProductData;
import example.shop.domain.ProductEntity;
import example.shop.repos.ProductDataRepo;
import example.shop.repos.ProductEntityRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/view")
public class ProductViewController {
    @Autowired
    private ProductEntityRepo productEntityRepo;
    @Autowired
    private ProductDataRepo productDataRepo;

    @GetMapping("{product}")
    public String viewProduct(@PathVariable Integer product, Model model)
    {
        ProductData productData;
        productData = productDataRepo.findByProductId(product).get(0);

        ProductEntity productEntity;
        productEntity = productEntityRepo.findById(product).get(0);

        model.addAttribute("productEntity", productEntity);
        model.addAttribute("productData", productData);

        return "viewProduct";
    }
}
