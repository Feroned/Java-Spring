package example.shop.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class ProductData {
    @Id
    @GeneratedValue (strategy = GenerationType.AUTO)
    private Integer id;

    private Integer productId;
    private String description;
    private Integer availability;
    private Integer quantity;

    private String showerType;
    private Integer ceiling;

    private String functions;

    private Integer width;
    private Integer height;
    private Integer depth;

    private Integer pallet;
    private String palletMaterial;
    private Integer palletHeight;

    private String curtainMaterial;
    private String glassType;
    private Integer glassTickness;
    private String doorConstruction;


    public ProductData()
    {
    }

    public ProductData(
            Integer productId,
            String description,
            Integer availability,
            Integer quantity,
            String showerType,
            Integer ceiling,
            String functions,
            Integer width,
            Integer height,
            Integer depth,
            Integer pallet,
            String palletMaterial,
            Integer palletHeight,
            String curtainMaterial,
            String glassType,
            Integer glassTickness,
            String doorConstruction
    ) {
        this.productId = productId;
        this.description = description;
        this.availability = availability;
        this.quantity = quantity;
        this.showerType = showerType;
        this.ceiling = ceiling;
        this.functions = functions;
        this.width = width;
        this.height = height;
        this.depth = depth;
        this.pallet = pallet;
        this.palletMaterial = palletMaterial;
        this.palletHeight = palletHeight;
        this.curtainMaterial = curtainMaterial;
        this.glassType = glassType;
        this.glassTickness = glassTickness;
        this.doorConstruction = doorConstruction;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getAvailability() {
        return availability;
    }

    public void setAvailability(Integer availability) {
        this.availability = availability;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getShowerType() {
        return showerType;
    }

    public void setShowerType(String showerType) {
        this.showerType = showerType;
    }

    public Integer getCeiling() {
        return ceiling;
    }

    public void setCeiling(Integer ceiling) {
        this.ceiling = ceiling;
    }

    public String getFunctions() {
        return functions;
    }

    public void setFunctions(String functions) {
        this.functions = functions;
    }

    public Integer getWidth() {
        return width;
    }

    public void setWidth(Integer width) {
        this.width = width;
    }

    public Integer getHeight() {
        return height;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    public Integer getDepth() {
        return depth;
    }

    public void setDepth(Integer depth) {
        this.depth = depth;
    }

    public Integer getPallet() {
        return pallet;
    }

    public void setPallet(Integer pallet) {
        this.pallet = pallet;
    }

    public String getPalletMaterial() {
        return palletMaterial;
    }

    public void setPalletMaterial(String palletMaterial) {
        this.palletMaterial = palletMaterial;
    }

    public Integer getPalletHeight() {
        return palletHeight;
    }

    public void setPalletHeight(Integer palletHeight) {
        this.palletHeight = palletHeight;
    }

    public String getCurtainMaterial() {
        return curtainMaterial;
    }

    public void setCurtainMaterial(String curtainMaterial) {
        this.curtainMaterial = curtainMaterial;
    }

    public String getGlassType() {
        return glassType;
    }

    public void setGlassType(String glassType) {
        this.glassType = glassType;
    }

    public Integer getGlassTickness() {
        return glassTickness;
    }

    public void setGlassTickness(Integer glassTickness) {
        this.glassTickness = glassTickness;
    }

    public String getDoorConstruction() {
        return doorConstruction;
    }

    public void setDoorConstruction(String doorConstruction) {
        this.doorConstruction = doorConstruction;
    }
}
