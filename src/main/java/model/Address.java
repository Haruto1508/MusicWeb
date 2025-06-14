/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class Address {
    private int addressId;
    private User user;
    private String street;
    private String ward;
    private String district;
    private String city;
    private String type;
    private boolean isDefault;

    public Address(int addressId, User user, String street, String ward, String district, String city, String type, boolean isDefault) {
        this.addressId = addressId;
        this.user = user;
        this.street = street;
        this.ward = ward;
        this.district = district;
        this.city = city;
        this.type = type;
        this.isDefault = isDefault;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean isIsDefault() {
        return isDefault;
    }

    public void setIsDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }

    @Override
    public String toString() {
        return "Address{" + "addressId=" + addressId + ", user=" + user + ", street=" + street + ", ward=" + ward + ", district=" + district + ", city=" + city + ", type=" + type + ", isDefault=" + isDefault + '}';
    }
    
    
}
