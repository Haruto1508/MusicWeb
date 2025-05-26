/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class Cart {

    private int cartID;
    private int userID;
    private int productID;
    private int quantity;
    private LocalDateTime addDate;

    public Cart() {
    }

    public Cart(int cartID, int userID, int productID, int quantity, LocalDateTime addDate) {
        this.cartID = cartID;
        this.userID = userID;
        this.productID = productID;
        this.quantity = quantity;
        this.addDate = addDate;
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
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
        return "Cart{" + "cartID=" + cartID + ", userID=" + userID + ", productID=" + productID + ", quantity=" + quantity + ", addDate=" + addDate + '}';
    }

}
