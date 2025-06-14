/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class Cart {

    private int cartID;
    private User user;
    private Product product;
    private int quantity;
    private LocalDateTime addDate;


    public Cart() {}

    public Cart(int cartID, User user, Product product, int quantity, LocalDateTime addDate) {
        this.cartID = cartID;
        this.user = user;
        this.product = product;
        this.quantity = quantity;
        this.addDate = addDate;
    }

    public Cart(User user, Product product, int quantity, LocalDateTime addDate) {
        this.user = user;
        this.product = product;
        this.quantity = quantity;
        this.addDate = addDate;
        this.product = product;
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getAddDate() {
        return addDate;
    }

    public void setAddDate(LocalDateTime addDate) {
        this.addDate = addDate;
    }

    @Override
    public String toString() {
        return "Cart{" + "cartID=" + cartID + ", user=" + user + ", product=" + product + ", quantity=" + quantity + ", addDate=" + addDate + '}';
    }
}
