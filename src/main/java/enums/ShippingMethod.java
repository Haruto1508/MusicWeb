/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package enums;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public enum ShippingMethod {
     STANDARD(1, "Standard Shipping"),
    EXPRESS(2, "Express"),
    FAST(3, "Fast Delivery");

    private final int shippingCode;
    private final String label;

    ShippingMethod(int shippingCode, String label) {
        this.shippingCode = shippingCode;
        this.label = label;
    }

    public static ShippingMethod fromValue(int code) {
        for (ShippingMethod s : values()) {
            if (s.shippingCode == code) return s;
        }
        return null;
    }

    public String getLabel() {
        return label;
    }
}
