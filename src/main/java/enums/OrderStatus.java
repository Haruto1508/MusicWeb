/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package enums;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public enum OrderStatus {
    PENDING(1, "Pending"),
    SHIPPED(2, "Shipped"),
    DELIVERED(3, "Delivered"),
    CANCELLED(4, "Cancelled");

    private final int value;
    private final String label;

    OrderStatus(int value, String label) {
        this.value = value;
        this.label = label;
    }

    public int getValue() { return value; }
    public String getLabel() { return label; }

    public static OrderStatus fromInt(int value) {
        for (OrderStatus s : values()) {
            if (s.value == value) return s;
        }
        return null;
    }
}
