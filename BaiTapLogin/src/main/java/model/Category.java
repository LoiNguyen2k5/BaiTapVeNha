package model;
import java.io.Serializable;
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int cateId;
    private String cateName;
    private String icon;

    // Constructors
    public Category() {}

    public Category(int cateId, String cateName, String icon) {
        this.cateId = cateId;
        this.cateName = cateName;
        this.icon = icon;
    }

    // Getters and Setters
    public int getCateId() {
        return cateId;
    }
    public void setCateId(int cateId) {
        this.cateId = cateId;
    }
    public String getCateName() {
        return cateName;
    }
    public void setCateName(String cateName) {
        this.cateName = cateName;
    }
    public String getIcon() {
        return icon;
    }
    public void setIcon(String icon) {
        this.icon = icon;
    }
}