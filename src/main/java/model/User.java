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
public class User {

    private int userId;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String address;
    private String role; // "customer" hoặc "admin"
    private String account;
    private LocalDateTime createDateTime;
    private String imageUrl;
    private String gender;
    private LocalDate birthdate;

    public User() {
    }

    // constructor to insert user to db
    public User(String fullName, String email, String password, String phone, String address, String role, String account, LocalDateTime createDateTime, String gender, LocalDate birthdate) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.account = account;
        this.createDateTime = createDateTime;
        this.birthdate = birthdate;
        this.gender = gender;
    }

    // constructor to get user from db
    public User(int userId, String fullName, String email, String password, String phone, String address, String role, String account, LocalDateTime createDateTime, String imageUrl, String gender, LocalDate birthdate) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.account = account;
        this.createDateTime = createDateTime;
        this.imageUrl = imageUrl;
        this.birthdate = birthdate;
        this.gender = gender;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getAccount() {
        return account;
    }

    public LocalDateTime getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(LocalDateTime createDateTime) {
        this.createDateTime = createDateTime;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public LocalDate getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(LocalDate birthdate) {
        this.birthdate = birthdate;
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", fullName=" + fullName + ", email=" + email + ", password=" + password + ", phone=" + phone + ", address=" + address + ", role=" + role + ", account=" + account + ", createDateTime=" + createDateTime + ", imageUrl=" + imageUrl + ", gender=" + gender + ", birthdate=" + birthdate + '}';
    }
}
