package example.shop.controller;

import example.shop.domain.ProductData;
import example.shop.domain.ProductEntity;
import example.shop.domain.ProductMedia;
import example.shop.repos.ProductDataRepo;
import example.shop.repos.ProductEntityRepo;
import example.shop.repos.ProductMediaRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/view")
public class ProductViewController {
    private final ProductEntityRepo productEntityRepo;
    private final ProductDataRepo productDataRepo;
    private final ProductMediaRepo productMediaRepo;

    @Autowired
    public ProductViewController(ProductEntityRepo productEntityRepo, ProductDataRepo productDataRepo, ProductMediaRepo productMediaRepo) {
        this.productEntityRepo = productEntityRepo;
        this.productDataRepo = productDataRepo;
        this.productMediaRepo = productMediaRepo;
    }

    @GetMapping("{product}")
    public String viewProduct(@PathVariable Integer product, Model model)
    {
        ProductData productData;
        productData = productDataRepo.findByProductId(product).get(0);

        ProductEntity productEntity;
        productEntity = productEntityRepo.findById(product).get(0);
        String[] fun = productData.getFunctions().split("\r\n");
        String finalFunctions = "";

        for (int i = 0 ; i < fun.length; i++) {
            finalFunctions += fun[i];
            if (i+1 != fun.length) {
                finalFunctions += ", ";
            }
        }
        productData.setFunctions(finalFunctions);
        ProductMedia productMedia;
        String imagePath = "", altCode = "";
        try {
            productMedia = productMediaRepo.findByProductId(product).get(0);
            imagePath = productMedia.getImgPath();
            altCode = productMedia.getAltCode();
        } catch (Exception e) {
            imagePath = "placeholder.png";
        }
        Map<String, String> prevAndNext = this.getPrevAndNdext(product);
        model.addAttribute("productEntity", productEntity);
        model.addAttribute("productData", productData);
        model.addAttribute("productImage", imagePath);
        model.addAttribute("productAltCode", altCode);
        model.addAttribute("links", prevAndNext);

        return "viewProduct";
    }

    private Map<String, String> getPrevAndNdext(Integer id)
    {
        Map<String, String> result = new HashMap<>();
        boolean found = false;
        String prevId = "", nextId = "";
        Iterable<ProductEntity> productEntities = productEntityRepo.findAll();

        for (ProductEntity productEntity: productEntities) {
            if (found) {
                nextId = productEntity.getId().toString();
                break;
            }

            if (productEntity.getId().equals(id)) {
                found = true;
            } else {
                prevId = productEntity.getId().toString();
            }
        }
        prevId = !prevId.isEmpty() ? prevId : this.getLastProductId();
        nextId = !nextId.isEmpty() ? nextId : this.getFirstProductId();
        result.put("prevProduct", prevId);
        result.put("nextProduct", nextId);

        return result;
    }

    private String getFirstProductId()
    {
        String first = "";
        Iterable<ProductEntity> productEntities = productEntityRepo.findAll();
        for (ProductEntity productEntity: productEntities) {
            first = productEntity.getId().toString();
            break;
        }

        return first;
    }

    private String getLastProductId()
    {
        String last = "";
        Iterable<ProductEntity> productEntities = productEntityRepo.findAll();

        for (ProductEntity productEntity: productEntities) {
            last = productEntity.getId().toString();
        }

        return last;
    }
}
