/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import enums.ShippingMethod;
import java.time.LocalDate;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class Shipping {
    private int shipping_id;
    private Order order;
    private ShippingMethod shippingMethod;
    private String trackingNumber;
    private LocalDate shppedDate;
    private LocalDate estimatedDelivery;

    public Shipping(int shipping_id, Order order, ShippingMethod shippingMethod, String trackingNumber, LocalDate shppedDate, LocalDate estimatedDelivery) {
        this.shipping_id = shipping_id;
        this.order = order;
        this.shippingMethod = shippingMethod;
        this.trackingNumber = trackingNumber;
        this.shppedDate = shppedDate;
        this.estimatedDelivery = estimatedDelivery;
    }
    
    public Shipping() {}

    public int getShipping_id() {
        return shipping_id;
    }

    public void setShipping_id(int shipping_id) {
        this.shipping_id = shipping_id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public ShippingMethod getShippingMethod() {
        return shippingMethod;
    }

    public void setShippingMethod(ShippingMethod shippingMethod) {
        this.shippingMethod = shippingMethod;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public LocalDate getShppedDate() {
        return shppedDate;
    }

    public void setShppedDate(LocalDate shppedDate) {
        this.shppedDate = shppedDate;
    }

    public LocalDate getEstimatedDelivery() {
        return estimatedDelivery;
    }

    public void setEstimatedDelivery(LocalDate estimatedDelivery) {
        this.estimatedDelivery = estimatedDelivery;
    }

    @Override
    public String toString() {
        return "Shipping{" + "shipping_id=" + shipping_id + ", order=" + order + ", shippingMethod=" + shippingMethod + ", trackingNumber=" + trackingNumber + ", shppedDate=" + shppedDate + ", estimatedDelivery=" + estimatedDelivery + '}';
    }
}
