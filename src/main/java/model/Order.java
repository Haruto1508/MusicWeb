/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class Order {

    private int orderId;
    private User user;
    private LocalDateTime orderDate;
    private String status;  // pending, processing, shipped, delivered, cancelled
    private BigDecimal totalAmount;
    private String shippingAddress;
    private Discount discount; // có thể null
    private BigDecimal discountAmount;

    private List<OrderDetail> orderDetails;

    public Order() {
    }

    public Order(int orderId, User user, LocalDateTime orderDate, String status, BigDecimal totalAmount, String shippingAddress, Discount discount, BigDecimal discountAmount) {
        this.orderId = orderId;
        this.user = user;
        this.orderDate = orderDate;
        this.status = status;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.discount = discount;
        this.discountAmount = discountAmount;
    }
    
    public Order(int orderId) {
        this.orderId = orderId;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public Discount getDiscount() {
        return discount;
    }

    public void setDiscountId(Discount discount) {
        this.discount = discount;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", user=" + user + ", orderDate=" + orderDate + ", status=" + status + ", totalAmount=" + totalAmount + ", shippingAddress=" + shippingAddress + ", discountId=" + discount + ", discountAmount=" + discountAmount + '}';
    }
}
