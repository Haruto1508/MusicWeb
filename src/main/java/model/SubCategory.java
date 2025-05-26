/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class SubCategory {

    private int subcategoryID;
    private String nameString;
    private String categoryID;

    public SubCategory() {
    }

    public SubCategory(int subcategoryID, String nameString, String categoryID) {
        this.subcategoryID = subcategoryID;
        this.nameString = nameString;
        this.categoryID = categoryID;
    }

    public int getSubcategoryID() {
        return subcategoryID;
    }

    public void setSubcategoryID(int subcategoryID) {
        this.subcategoryID = subcategoryID;
    }

    public String getNameString() {
        return nameString;
    }

    public void setNameString(String nameString) {
        this.nameString = nameString;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    @Override
    public String toString() {
        return "SubCategory{" + "subcategoryID=" + subcategoryID + ", nameString=" + nameString + ", categoryID=" + categoryID + '}';
    }

}
