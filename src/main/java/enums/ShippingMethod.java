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
     STANDARD("Standard Shipping"),
    EXPRESS("Express"),
    FAST("Fast Delivery");

    private final String label;

    ShippingMethod(String label) {
        this.label = label;
    }

    public static ShippingMethod fromLabel(String label) {
        for (ShippingMethod s : values()) {
            if (s.label.equalsIgnoreCase(label)) return s;
        }
        return null;
    }

    public String getLabel() {
        return label;
    }
}
