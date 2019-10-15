package com.andrewkim.ekart.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.Size;


@Entity
@Table(name="products")
public class Product {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long Id;
	
	@Size(min=3, message="Product name must be greater than 3 characters")
	private String productName;
	
	private double prodPrice;
	
	private double prodSave;
	
	private String prodDesc;
	
	private String prodImg;
	
	@Size(min = 3, message = "Product category must be greater than 3 characters")
	private String prodCategory;
	
	private int prodQtyInStock;
	
	private int prodQtySold;
	
	@Column(updatable=false)
	private Date createdAt;
	
	private Date updatedAt;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
		name = "selectors_products",
		joinColumns = @JoinColumn(name="product_id"),
		inverseJoinColumns = @JoinColumn(name = "user_id")
	)
	private List<User> selectors;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
		name = "users_products",
		joinColumns = @JoinColumn(name="product_id"),
		inverseJoinColumns = @JoinColumn(name = "user_id")
	)
	private List<User> buyers;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
		name = "users_products",
		joinColumns = @JoinColumn(name="product_id"),
		inverseJoinColumns = @JoinColumn(name = "user_id")
	)
	private List<User> wishlisters;
	
	@OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
	private List<Rating> productRatings;
	
	public Product() {

	}
	
	@PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
	
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }

	public Long getId() {
		return Id;
	}

	public void setId(Long id) {
		Id = id;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public double getProdPrice() {
		return prodPrice;
	}

	public void setProdPrice(double prodPrice) {
		this.prodPrice = prodPrice;
	}

	public double getProdSave() {
		return prodSave;
	}

	public void setProdSave(double prodSave) {
		this.prodSave = prodSave;
	}

	public String getProdDesc() {
		return prodDesc;
	}

	public void setProdDesc(String prodDesc) {
		this.prodDesc = prodDesc;
	}

	public String getProdImg() {
		return prodImg;
	}

	public void setProdImg(String prodImg) {
		this.prodImg = prodImg;
	}

	public String getProdCategory() {
		return prodCategory;
	}

	public void setProdCategory(String prodCategory) {
		this.prodCategory = prodCategory;
	}

	public int getProdQtyInStock() {
		return prodQtyInStock;
	}

	public void setProdQtyInStock(int prodQtyInStock) {
		this.prodQtyInStock = prodQtyInStock;
	}

	public int getProdQtySold() {
		return prodQtySold;
	}

	public void setProdQtySold(int prodQtySold) {
		this.prodQtySold = prodQtySold;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public List<User> getSelectors() {
		return selectors;
	}

	public void setSelectors(List<User> selectors) {
		this.selectors = selectors;
	}

	public List<Rating> getProductRatings() {
		return productRatings;
	}

	public void setProductRatings(List<Rating> productRatings) {
		this.productRatings = productRatings;
	}

	public List<User> getBuyers() {
		return buyers;
	}

	public void setBuyers(List<User> buyers) {
		this.buyers = buyers;
	}

	public List<User> getWishlisters() {
		return wishlisters;
	}

	public void setWishlisters(List<User> wishlisters) {
		this.wishlisters = wishlisters;
	}
}
