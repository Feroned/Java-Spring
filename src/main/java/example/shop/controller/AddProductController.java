package example.shop.controller;

import example.shop.domain.ProductData;
import example.shop.domain.ProductEntity;
import example.shop.domain.ProductMedia;
import example.shop.repos.ProductDataRepo;
import example.shop.repos.ProductEntityRepo;
import example.shop.repos.ProductMediaRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.criteria.CriteriaBuilder;
import java.io.File;

@SuppressWarnings("ALL")
@Controller
public class AddProductController {
    private final ProductEntityRepo productEntityRepo;
    private final ProductDataRepo productDataRepo;
    private final ProductMediaRepo productMediaRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    public AddProductController(ProductEntityRepo productEntityRepo, ProductDataRepo productDataRepo, ProductMediaRepo productMediaRepo) {
        this.productEntityRepo = productEntityRepo;
        this.productDataRepo = productDataRepo;
        this.productMediaRepo = productMediaRepo;
    }

    @GetMapping("/addProduct")
    public String addProduct (Model model)
    {
        model.addAttribute("show", false);

        return "addproduct";
    }

    @PostMapping("/addProduct")
    public String addProduct(
            @RequestParam(defaultValue = "") String name,
            @RequestParam(defaultValue = "") String priceStr,
            @RequestParam(defaultValue = "") String shortDescription,
            @RequestParam(required = false) Integer availability,
            @RequestParam(defaultValue = "") String quantityStr,
            @RequestParam(defaultValue = "") String description,
            @RequestParam(defaultValue = "") String showerType,
            @RequestParam(defaultValue = "") Integer ceiling,
            @RequestParam(defaultValue = "") String functions,
            @RequestParam(defaultValue = "") String widthStr,
            @RequestParam(defaultValue = "") String heightStr,
            @RequestParam(defaultValue = "") String depthStr,
            @RequestParam(defaultValue = "") Integer pallet,
            @RequestParam(defaultValue = "") String palletMaterial,
            @RequestParam(defaultValue = "") String palletHeightStr,
            @RequestParam(defaultValue = "") String curtainMaterial,
            @RequestParam(defaultValue = "") String glassType,
            @RequestParam(defaultValue = "") String glassTicknessStr,
            @RequestParam(defaultValue = "") String doorConstruction,
            @RequestParam("productImage") MultipartFile file,

            Model model
    ) {
        String message = "";
        Boolean needToShow = true;
        Integer messageType = 0;

        if (name.equals("")
                || priceStr.equals("")
                || shortDescription.equals("")
                || (!file.getContentType().equals("image/jpeg") && !file.isEmpty())
        ) {
            messageType = 1;
            message = "Please provide correct values for product";
            model.addAttribute("show", needToShow);
            model.addAttribute("messageType", messageType);
            model.addAttribute("message", message);

            return "addproduct";
        }
        try {
            Integer price = Integer.parseInt(priceStr);
            Integer quantity = quantityStr.isEmpty() ? 0 : Integer.parseInt(quantityStr);

            Integer width = widthStr.isEmpty() ? 0 : Integer.parseInt(widthStr);
            Integer height = heightStr.isEmpty() ? 0 : Integer.parseInt(heightStr);
            Integer depth = depthStr.isEmpty() ? 0 : Integer.parseInt(depthStr);
            Integer palletHeight = palletHeightStr.isEmpty() ? 0 : Integer.parseInt(palletHeightStr);
            Integer glassTickness = glassTicknessStr.isEmpty() ? 0 : Integer.parseInt(glassTicknessStr);

            ProductEntity productEntity = new ProductEntity(name, shortDescription, price);
            productEntityRepo.save(productEntity);
            ProductData prData = new ProductData(
                    productEntity.getId(),
                    description,
                    availability,
                    quantity,
                    showerType,
                    ceiling,
                    functions,
                    width,
                    height,
                    depth,
                    pallet,
                    palletMaterial,
                    palletHeight,
                    curtainMaterial,
                    glassType,
                    glassTickness,
                    doorConstruction
                );
            productDataRepo.save(prData);

            if (file != null && !file.getOriginalFilename().isEmpty()) {
                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                String filename = "product_"
                        + productEntity.getId()
                        + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
                file.transferTo(new File(uploadPath + "/" + filename));
                ProductMedia productMedia = new ProductMedia(productEntity.getId(), "image", name, filename);
                productMediaRepo.save(productMedia);
            }
            message = "Product has been saved.";
        } catch (Exception e) {
            message = "An error has occured while creating the product: " + e.getMessage();
            messageType = 1;
        }
        model.addAttribute("show", needToShow);
        model.addAttribute("messageType", messageType);
        model.addAttribute("message", message);

        return "addproduct";
    }

}
