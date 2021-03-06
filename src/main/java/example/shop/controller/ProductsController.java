package example.shop.controller;

import example.shop.domain.ProductData;
import example.shop.domain.ProductEntity;
import example.shop.domain.ProductMedia;
import example.shop.repos.ProductDataRepo;
import example.shop.repos.ProductEntityRepo;
import example.shop.repos.ProductMediaRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.Map;

@SuppressWarnings("ALL")
@Controller
public class ProductsController {
    private final ProductEntityRepo productEntityRepo;
    private final ProductDataRepo productDataRepo;
    private final ProductMediaRepo productMediaRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    public ProductsController(ProductEntityRepo productEntityRepo, ProductDataRepo productDataRepo, ProductMediaRepo productMediaRepo) {
        this.productEntityRepo = productEntityRepo;
        this.productDataRepo = productDataRepo;
        this.productMediaRepo = productMediaRepo;
    }

    @GetMapping("/products")
    public String productsList(
            Model model,
            @PageableDefault(sort = {"id"}, direction = Sort.Direction.ASC) Pageable pageable
    ) {
        Iterable<ProductMedia> productMedia = productMediaRepo.findAll();
        Page<ProductEntity> productEntities = productEntityRepo.findAll(pageable);
        model.addAttribute("productEntities", productEntities);
        model.addAttribute("productMedia", productMedia);
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

        ProductMedia productMedia;
        String imagePath = "", altCode = "";

        try {
            productMedia = productMediaRepo.findByProductId(product).get(0);
            imagePath = productMedia.getImgPath();
            altCode = productMedia.getAltCode();
        } catch (Exception e) {
            imagePath = "placeholder.png";
        }
        model.addAttribute("productImage", imagePath);
        model.addAttribute("productAltCode", altCode);
        model.addAttribute("productEntity", productEntity);
        model.addAttribute("productData", productData);
        model.addAttribute("show", false);

        return "editProduct";
    }

    @PostMapping("/editProduct/{product}")
    public String saveProduct(
            @RequestParam String name,
            @RequestParam String  priceStr,
            @RequestParam String shortDescription,
            @RequestParam Integer availability,
            @RequestParam String quantityStr,
            @RequestParam String description,
            @PathVariable Integer product,
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
        String imagePath = "placeholder.png", altCode = "";

        ProductEntity productEntity = productEntityRepo.findById(product).get(0);
        ProductData productData = productDataRepo.findByProductId(product).get(0);
        ProductMedia productMedia;

        if (name.equals("")
                || priceStr.equals("")
                || shortDescription.equals("")
                || (!file.getContentType().equals("image/jpeg") && !file.isEmpty())
        ) {
            messageType = 1;
            message = "Please provide correct product data";
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

            productEntity.setName(name);
            productEntity.setPrice(price);
            productEntity.setShortDescription(shortDescription);

            productData.setAvailability(availability);
            productData.setDescription(description);
            productData.setQuantity(quantity);

            productData.setShowerType(showerType);
            productData.setCeiling(ceiling);
            productData.setFunctions(functions);
            productData.setWidth(width);
            productData.setHeight(height);
            productData.setDepth(depth);
            productData.setPallet(pallet);
            productData.setPalletMaterial(palletMaterial);
            productData.setPalletHeight(palletHeight);
            productData.setCurtainMaterial(curtainMaterial);
            productData.setGlassType(glassType);
            productData.setGlassTickness(glassTickness);
            productData.setDoorConstruction(doorConstruction);

            productEntityRepo.save(productEntity);
            productDataRepo.save(productData);

            if (file != null && !file.getOriginalFilename().isEmpty()) {
                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                String filename = "product_"
                        + productEntity.getId()
                        + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
                file.transferTo(new File(uploadPath + "/" + filename));

                try {
                    productMedia = productMediaRepo.findByProductId(product).get(0);
                } catch (Exception e) {
                    productMedia = new ProductMedia(product, "image", name, filename);
                }
                altCode = productMedia.getAltCode();
                imagePath = filename;
                productMedia.setImgPath(filename);
                productMediaRepo.save(productMedia);
            }
        } catch (Exception e) {
            message = "An error has occured while creating the product: " + e.getMessage();
            messageType = 1;
            imagePath = "placeholder.png";

            model.addAttribute("show", needToShow);
            model.addAttribute("messageType", messageType);
            model.addAttribute("message", message);
            model.addAttribute("productEntity", productEntity);
            model.addAttribute("productData", productData);
            model.addAttribute("productImage", imagePath);
            model.addAttribute("productAltCode", altCode);

            return "editProduct";
        }
        message = "Product has been saved.";

        model.addAttribute("show", needToShow);
        model.addAttribute("messageType", messageType);
        model.addAttribute("message", message);
        model.addAttribute("productEntity", productEntity);
        model.addAttribute("productData", productData);
        model.addAttribute("productImage", imagePath);
        model.addAttribute("productAltCode", altCode);
        
        return "editProduct";
    }

    @PostMapping("/deleteProducts")
    public String deleteProducts(@RequestParam Map<String, String> todelete)
    {
        ProductEntity productEntity;
        ProductData productData;
        ProductMedia productMedia;
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
            List<ProductMedia> productMediaList = productMediaRepo.findByProductId(id);

            if (!productMediaList.isEmpty()) {
                productMediaRepo.delete(productMediaList.get(0));
            }
            productEntityRepo.delete(productEntity);
            productDataRepo.delete(productData);
        }
        return "redirect:/products";
    }

    @GetMapping("/admin")
    public String authorizathion(
            @RequestParam(required = false) String error,
            Model model
    ) {
        model.addAttribute("show", true);
        model.addAttribute("messageType", 1);
        model.addAttribute("message", "Wrong password or user name!");

        if (error != null) {
            model.addAttribute("show", true);
            model.addAttribute("messageType", 1);
            model.addAttribute("message", "Wrong password or user name!");
        } else {
            model.addAttribute("show", false);
        }

        return "admin";
    }
}
