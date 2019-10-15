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
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;


@Entity
@Table(name="users")
public class User {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long Id;
	
	@Size(min = 3, message = "Username must be greater than 2 characters")
	private String username;
	
	@Email(message = "Email must be valid")
	private String email;
	
	@Size(min = 10, max = 10, message = "Phone number must be exactly 10 digits long")
	@Pattern(regexp = "[0-9]+", message = "Must contain only numbers")
	private String phone;
	
	@Size(min=5, message="Password must be greater than 4 characters")
	private String password;
	
	@Transient
	private String passwordConfirmation;
	
	@Column(updatable=false)
	private Date createdAt;
	
	private Date updatedAt;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
		name = "selectors_products",
		joinColumns = @JoinColumn(name="user_id"),
		inverseJoinColumns = @JoinColumn(name = "product_id")
		)
	private List<Product> shopProducts;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
		name = "users_products",
		joinColumns = @JoinColumn(name="user_id"),
		inverseJoinColumns = @JoinColumn(name = "product_id")
		)
	private List<Product> buyProducts;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
		name = "wishlisters_products",
		joinColumns = @JoinColumn(name="user_id"),
		inverseJoinColumns = @JoinColumn(name = "product_id")
		)
	private List<Product> wishProducts;
	
	@OneToMany(mappedBy = "rater", fetch = FetchType.LAZY)
	private List<Rating> ratingList;
	
	@OneToMany(mappedBy = "receiver", fetch = FetchType.LAZY)
	private List<Notification> notificationList;
	
	@OneToMany(mappedBy = "orderer", fetch = FetchType.LAZY)
	private List<Order> orderList;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Address> addresses;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Card> cards;
	
	public User() {

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

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordConfirmation() {
		return passwordConfirmation;
	}

	public void setPasswordConfirmation(String passwordConfirmation) {
		this.passwordConfirmation = passwordConfirmation;
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

	public List<Product> getBuyProducts() {
		return buyProducts;
	}

	public void setBuyProducts(List<Product> buyProducts) {
		this.buyProducts = buyProducts;
	}

	public List<Product> getWishProducts() {
		return wishProducts;
	}

	public void setWishProducts(List<Product> wishProducts) {
		this.wishProducts = wishProducts;
	}

	public List<Rating> getRatingList() {
		return ratingList;
	}

	public void setRatingList(List<Rating> ratingList) {
		this.ratingList = ratingList;
	}

	public List<Notification> getNotificationList() {
		return notificationList;
	}

	public void setNotificationList(List<Notification> notificationList) {
		this.notificationList = notificationList;
	}

	public List<Product> getShopProducts() {
		return shopProducts;
	}

	public void setShopProducts(List<Product> shopProducts) {
		this.shopProducts = shopProducts;
	}

	public List<Order> getOrderList() {
		return orderList;
	}

	public void setOrderList(List<Order> orderList) {
		this.orderList = orderList;
	}

	public List<Address> getAddresses() {
		return addresses;
	}

	public void setAddresses(List<Address> addresses) {
		this.addresses = addresses;
	}

	public List<Card> getCards() {
		return cards;
	}

	public void setCards(List<Card> cards) {
		this.cards = cards;
	}
}
