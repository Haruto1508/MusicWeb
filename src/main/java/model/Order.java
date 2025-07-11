/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import enums.OrderStatus;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class Order {

    private int orderId;
    private User user;
    private LocalDateTime orderDate;
    private OrderStatus status;  // pending, processing, shipped, delivered, cancelled
    private BigDecimal totalAmount;
    private Discount discount; // có thể null
    private BigDecimal discountAmount;
    private Address address;

    private OrderDetail orderDetail;

    public Order() {
    }

    public Order(int orderId, User user, LocalDateTime orderDate, OrderStatus status, BigDecimal totalAmount, Discount discount, BigDecimal discountAmount, Address address) {
        this.orderId = orderId;
        this.user = user;
        this.orderDate = orderDate;
        this.status = status;
        this.totalAmount = totalAmount;
        this.discount = discount;
        this.discountAmount = discountAmount;
        this.address = address;
    }

    public Order(int orderId) {
        this.orderId = orderId;
    }

    public OrderDetail getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(OrderDetail orderDetail) {
        this.orderDetail = orderDetail;
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
    
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Discount getDiscount() {
        return discount;
    }

    public void setDiscount(Discount discount) {
        this.discount = discount;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }
    
    // Thêm phương thức chuyển đổi LocalDateTime sang Date
    public Date getOrderDateAsDate() {
        return orderDate != null ? Date.from(orderDate.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", user=" + user + ", orderDate=" + orderDate + ", status=" + status + ", totalAmount=" + totalAmount + ", discount=" + discount + ", discountAmount=" + discountAmount + ", address=" + address + ", orderDetail=" + orderDetail + '}';
    }
    
}
