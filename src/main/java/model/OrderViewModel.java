/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import enums.OrderStatus;
import enums.PaymentMethod;
import enums.PaymentStatus;
import enums.ShippingMethod;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class OrderViewModel {
    private int orderId;
    private Timestamp orderDate;
    private OrderStatus status;

    private BigDecimal totalAmount;
    private BigDecimal discountAmount;
    private BigDecimal finalAmount;

    private String receiverName;
    private String orderPhone;
    private String fullAddress;

    private PaymentMethod paymentMethod;
    private PaymentStatus paymentStatus;

    private String shippingMethod;
    private String trackingNumber;
    private Timestamp estimatedDelivery;

    private List<OrderDetail> orderDetails;

    public OrderViewModel () {}

    public OrderViewModel(int orderId, Timestamp orderDate, OrderStatus status, BigDecimal totalAmount, BigDecimal discountAmount, BigDecimal finalAmount, String receiverName, String orderPhone, String fullAddress, PaymentMethod paymentMethod, PaymentStatus paymentStatus, String shippingMethod, String trackingNumber, Timestamp estimatedDelivery, List<OrderDetail> orderDetails) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.status = status;
        this.totalAmount = totalAmount;
        this.discountAmount = discountAmount;
        this.finalAmount = finalAmount;
        this.receiverName = receiverName;
        this.orderPhone = orderPhone;
        this.fullAddress = fullAddress;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.shippingMethod = shippingMethod;
        this.trackingNumber = trackingNumber;
        this.estimatedDelivery = estimatedDelivery;
        this.orderDetails = orderDetails;
    }
    
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getFinalAmount() {
        return finalAmount;
    }

    public void setFinalAmount(BigDecimal finalAmount) {
        this.finalAmount = finalAmount;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getOrderPhone() {
        return orderPhone;
    }

    public void setOrderPhone(String orderPhone) {
        this.orderPhone = orderPhone;
    }

    public String getFullAddress() {
        return fullAddress;
    }

    public void setFullAddress(String fullAddress) {
        this.fullAddress = fullAddress;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public PaymentStatus getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(PaymentStatus paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getShippingMethod() {
        return shippingMethod;
    }

    public void setShippingMethod(String shippingMethod) {
        this.shippingMethod = shippingMethod;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }  

    public Timestamp getEstimatedDelivery() {
        return estimatedDelivery;
    }

    public void setEstimatedDelivery(Timestamp estimatedDelivery) {
        this.estimatedDelivery = estimatedDelivery;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    @Override
    public String toString() {
        return "OrderViewModel{" + "orderId=" + orderId + ", orderDate=" + orderDate + ", status=" + status + ", totalAmount=" + totalAmount + ", discountAmount=" + discountAmount + ", finalAmount=" + finalAmount + ", receiverName=" + receiverName + ", orderPhone=" + orderPhone + ", fullAddress=" + fullAddress + ", paymentMethod=" + paymentMethod + ", paymentStatus=" + paymentStatus + ", shippingMethod=" + shippingMethod + ", trackingNumber=" + trackingNumber + ", estimatedDelivery=" + estimatedDelivery + ", orderDetails=" + orderDetails + '}';
    }
}
