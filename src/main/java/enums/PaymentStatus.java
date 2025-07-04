/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package enums;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public enum PaymentStatus {
    PAID(1, "Paid"),
    UNPAID(2, "Unpaid"),
    FAILED(3, "Failed");

    private final int code;
    private final String label;

    PaymentStatus(int code, String label) {
        this.code = code;
        this.label = label;
    }

    public static PaymentStatus fromCode(int code) {
        for (PaymentStatus p : values()) {
            if (p.code == code) return p;
        }
        return null;
    }

    public String getLabel() {
        return label;
    }

    public int getCode() {
        return code;
    }
}
