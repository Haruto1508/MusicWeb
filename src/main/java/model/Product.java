/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class Product {

    private int productId;
    private String name;
    private String description;
    private BigDecimal price;
    private int stockQuantity;
    private Category category;
    private String imageUrl;
    private LocalDateTime createDateTime;

    public Product() {
    }

    public Product(int productId, String name, String description, BigDecimal price, int stockQuantity, Category category, String imageUrl, LocalDateTime createDateTime) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.category = category;
        this.imageUrl = imageUrl;
        this.createDateTime = createDateTime;
    }

    public int getProductID() {
        return productId;
    }

    public void setProductID(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategoryId(Category categoryId) {
        this.category = categoryId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public LocalDateTime getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(LocalDateTime createDateTime) {
        this.createDateTime = createDateTime;
    }

    @Override
    public String toString() {
        return "Product{" + "product=" + productId + ", name=" + name + ", description=" + description + ", price=" + price + ", stockQuantity=" + stockQuantity + ", categoryId=" + category + ", imageUrl=" + imageUrl + ", createDateTime=" + createDateTime + '}';
    }
}
