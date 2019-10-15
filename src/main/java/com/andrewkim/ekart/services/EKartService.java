package com.andrewkim.ekart.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.andrewkim.ekart.models.Address;
import com.andrewkim.ekart.models.Card;
import com.andrewkim.ekart.models.Notification;
import com.andrewkim.ekart.models.Order;
import com.andrewkim.ekart.models.Product;
import com.andrewkim.ekart.models.Rating;
import com.andrewkim.ekart.models.User;
import com.andrewkim.ekart.repositories.AddressRepository;
import com.andrewkim.ekart.repositories.CardRepository;
import com.andrewkim.ekart.repositories.NotificationRepository;
import com.andrewkim.ekart.repositories.OrderRepository;
import com.andrewkim.ekart.repositories.ProductRepository;
import com.andrewkim.ekart.repositories.RatingRepository;
import com.andrewkim.ekart.repositories.UserRepository;

@Service
public class EKartService {
	private final UserRepository userRepository;
	private final ProductRepository productRepository;
	private final RatingRepository ratingRepository;
	private final NotificationRepository notificationRepository;
	private final OrderRepository orderRepository;
	private final AddressRepository addressRepository;
	private final CardRepository cardRepository;
	
	public EKartService(UserRepository userRepository, ProductRepository productRepository,
			RatingRepository ratingRepository, NotificationRepository notificationRepository,
			OrderRepository orderRepository, AddressRepository addressRepository,
			CardRepository cardRepository) {
		this.userRepository = userRepository;
		this.productRepository = productRepository;
		this.ratingRepository = ratingRepository;
		this.notificationRepository = notificationRepository;
		this.orderRepository = orderRepository;
		this.addressRepository = addressRepository;
		this.cardRepository = cardRepository;
	}
	
	public User registerUser(User user){
		String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepository.save(user);
	}
	
	public User findByEmail(String email){
		return userRepository.findByEmail(email);
	}
	
	public User findUserById(Long id){
		Optional<User> u = userRepository.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
	
    public boolean authenticateUser(String email, String password) {
        User user = userRepository.findByEmail(email);
        
        if(user == null) {
            return false;
        }
        else {
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            }
            else {
                return false;
            }
        }
    }

	public User update(User user) {
		return userRepository.save(user);
	}
	
	public User editProfile(User user, String username, String email, String phone) {
		user.setUsername(username);
		user.setEmail(email);
		user.setPhone(phone);
		return userRepository.save(user);
	}
	
    public List <Product> allProducts() {
        return productRepository.findAll();
    }
    
    public Product findProductById(Long id){
		Optional<Product> p = productRepository.findById(id);
    	
    	if(p.isPresent()) {
            return p.get();
    	} else {
    	    return null;
    	}
    }
    
    public List <Product> findProducts (String product) {
		return productRepository.findByProductNameContaining(product);
	}
    
    public List <Rating> allRatings() {
    	return ratingRepository.findAll();
    }
    
    public Rating createRating(User user, Product product, int r, String description) {
    	Rating rating = new Rating();
    	rating.setRating(r);
    	rating.setDescription(description);
    	rating.setProduct(product);
    	rating.setRater(user);
    	return ratingRepository.save(rating);
    }
    
    public List <Notification> allNotifications() {
    	return notificationRepository.findAll();
    }
    
    public Notification findNotificationById(Long id){
		Optional<Notification> n = notificationRepository.findById(id);
    	
    	if(n.isPresent()) {
            return n.get();
    	} else {
    	    return null;
    	}
    }
    
    public Notification orderNotification(User u, Order o) {
    	Notification n = new Notification();
    	n.setHasRead(false);
    	n.setReceiver(u);
    	String note = u.getEmail() + o.getId();
    	n.setText("Order was placed successfully. Your id is: " + note);
    	n.setType("Ordered_" + note);
    	return notificationRepository.save(n);
    }
    
    public Notification cancelNotification(User u, Order o) {
    	Notification n = new Notification();
    	n.setHasRead(false);
    	n.setReceiver(u);
    	String note = u.getEmail() + o.getId();
    	n.setText("Order was cancelled successfully for order id: " + note);
    	n.setType("Cancelled_" + note);
    	return notificationRepository.save(n);
    }
    
    public Notification returnNotification(User u, Order o) {
    	Notification n = new Notification();
    	n.setHasRead(false);
    	n.setReceiver(u);
    	String note = u.getEmail() + o.getId();
    	n.setText("Order was returned successfully for order id: " + note);
    	n.setType("Returned_" + note);
    	return notificationRepository.save(n);
    }
    
    public Notification updateNotification(Notification n) {
    	return notificationRepository.save(n);
    }
    
    public List <Order> allOrders() {
    	return orderRepository.findAll();
    }
    
    public Order createOrder(User u, Address a, Card c, double total) {
    	Order o = new Order();
    	o.setCardType(c.getType());
    	o.setOrderStatus("Open");
    	o.setOrderer(u);
    	o.setOrderAddress(a);
    	o.setPrice(total);
    	
    	if (o.getProdList() == null) {
    		List<Product> list = new ArrayList<Product>();
    		o.setProdList(list);
    	}
    	o.getProdList().addAll(u.getBuyProducts());
    	u.setBuyProducts(null);
    	return orderRepository.save(o);
    }
    
    public Order updateOrder(Order o) {
    	return orderRepository.save(o);
    }
    
    public Order findOrderById(Long id){
		Optional<Order> o = orderRepository.findById(id);
    	
    	if(o.isPresent()) {
            return o.get();
    	} else {
    	    return null;
    	}
    }
    
    public List <Address> allAddresses() {
    	return addressRepository.findAll();
    }
    
    public Address findAddressById(Long id){
		Optional<Address> a = addressRepository.findById(id);
    	
    	if(a.isPresent()) {
            return a.get();
    	} else {
    	    return null;
    	}
    }
    
    public Address createAddress(Address address) {
    	return addressRepository.save(address);
    }
    
    public Address editAddress(Long id, String street, String city, String state, String country) {
    	Address a = findAddressById(id);
    	a.setStreet(street);
    	a.setCity(city);
    	a.setState(state);
    	a.setCountry(country);
    	return addressRepository.save(a);
    }
    
    public void deleteAddress(Long id) {
    	addressRepository.deleteById(id);
    }
    
    public List <Card> allCards() {
    	return cardRepository.findAll();
    }
    
    public Card findCardById(Long id){
		Optional<Card> c = cardRepository.findById(id);
    	
    	if(c.isPresent()) {
            return c.get();
    	} else {
    	    return null;
    	}
    }
    
    public Card createCard(Card card) {
    	return cardRepository.save(card);
    }
    
    public Card editCard(Long id, String type, String number, Date expDate) {
    	Card c = findCardById(id);
    	c.setType(type);
    	c.setNumber(number);
    	c.setExpDate(expDate);
    	return cardRepository.save(c);
    }
    
    public void deleteCard(Long id) {
    	cardRepository.deleteById(id);
    }
}
