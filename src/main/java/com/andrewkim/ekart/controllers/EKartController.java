package com.andrewkim.ekart.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.andrewkim.ekart.services.EKartService;
import com.andrewkim.ekart.validators.AddressValidator;
import com.andrewkim.ekart.validators.CardValidator;
import com.andrewkim.ekart.validators.EKartValidator;
import com.andrewkim.ekart.models.Address;
import com.andrewkim.ekart.models.Card;
import com.andrewkim.ekart.models.Notification;
import com.andrewkim.ekart.models.Order;
import com.andrewkim.ekart.models.Product;
import com.andrewkim.ekart.models.User;

@Controller
public class EKartController {
	private final EKartService eKartService;
	private final EKartValidator eKartValidator;
	private final AddressValidator addressValidator;
	private final CardValidator cardValidator;
	
	public EKartController(EKartService eKartService, EKartValidator eKartValidator, 
			AddressValidator addressValidator, CardValidator cardValidator) {
		this.eKartService = eKartService;
		this.eKartValidator = eKartValidator;
		this.addressValidator = addressValidator;
		this.cardValidator = cardValidator;
	}
	
	//Home page
	@RequestMapping("/")
    public String home(Model model, HttpSession session) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid != null) {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
		}
		List <Product> productAll = eKartService.allProducts();				
		model.addAttribute("productAll", productAll);
        return "home.jsp";
    }
	
	//Login page
	@RequestMapping("/login")
    public String login() {
        return "login.jsp";
    }
	
	//Registration page
	@RequestMapping("/register")
    public String register(@ModelAttribute("user") User user) {
        return "register.jsp";
    }
	
	@PostMapping(value = "/register")
    public String register (@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		eKartValidator.validate(user, result);
		if (result.hasErrors()) {
 	        return "register.jsp";
 	    }
		else {
			eKartService.registerUser(user);
 	    	session.setAttribute("userid", user.getId());
 	    	return "redirect:/";
 	    }
    }
	
	@PostMapping(value = "/login")
    public String login (@RequestParam("email") String email, @RequestParam("password") String password, 
    		HttpSession session, RedirectAttributes r) {
		boolean success = eKartService.authenticateUser(email, password);
    	
    	if (email.length() < 1) {
    		r.addFlashAttribute("error", "Email field cannot be blank.");
    		return "redirect:/login";
    	}
    	else if (password.length() < 1) {
    		r.addFlashAttribute("error", "Please enter your password.");
    		return "redirect:/login";
    	}
    	else if (!success) {
    		r.addFlashAttribute("error", "Email and password do not match.");
    		return "redirect:/login";
    	}
    	else {
    		User user = eKartService.findByEmail(email);
    		Long id = user.getId();
    		session.setAttribute("userid", id);
    		return "redirect:/";
    	}
    }
	
	//Logout
	@RequestMapping ("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	//Show single product
	@RequestMapping("/product/{id}")
    public String showProduct(HttpSession session, @PathVariable("id") Long id, Model model) {   
		Long userid = (Long) session.getAttribute("userid");
		if (userid != null) {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
		}
	    Product product = eKartService.findProductById(id);
	    model.addAttribute("product", product);
	    return "singleproduct.jsp";
    }
	
	//Comment on product
	@PostMapping("/product/{id}")
	public String rateProduct(HttpSession session, RedirectAttributes r, @PathVariable("id") Long id, 
			@RequestParam("rating") String rating, @RequestParam("description") String description) {
		if (description.length() < 1) {
			r.addFlashAttribute("error", "Please type in a comment");
			return "redirect:/product/{id}";
		}
		else {
			Long userid = (Long) session.getAttribute("userid");
			User user = eKartService.findUserById(userid);
		    Product product = eKartService.findProductById(id);
		    int ra = Integer.parseInt(rating);
		    eKartService.createRating(user, product, ra, description);
		    return "redirect:/product/{id}";
		}
    }
	
	//Search for products
	@RequestMapping (value = "/search", method = RequestMethod.POST)
	public String findProduct (HttpSession session, @RequestParam("input") String input) {
		List <Product> products = eKartService.findProducts(input);
		session.setAttribute("products", products);
		return "redirect:/search/" + input;
	}
	
	//Search results
	@RequestMapping("/search/{input}")
	public String listProducts (HttpSession session, @PathVariable("input") String input, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid != null) {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
		}
		return "search.jsp";
	}
	
	//User profile
	@RequestMapping("/profile")
	public String profile (HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
		}
		return "profile.jsp";
	}
	
	//Edit profile
	@RequestMapping("/profile/show")
	public String showProfile (HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
		}
		return "editprofile.jsp";
	}

	@PostMapping("/profile/edit")
	public String editProfile (HttpSession session, @RequestParam(value="username") String username,
			@RequestParam(value="email") String email, @RequestParam(value="phone") String phone,
			RedirectAttributes r) {
		Long userid = (Long) session.getAttribute("userid");
		User user = eKartService.findUserById(userid);
		User another = eKartService.findByEmail(email);

		if (phone.length() != 10) {
			r.addFlashAttribute("error", "Phone number must be 10 digits long");
    		return "redirect:/profile/show";
		}
		else if (username.length() < 1) {
			r.addFlashAttribute("error", "Please enter your username");
    		return "redirect:/profile/show";
		}
		else if (email.length() < 1) {
			r.addFlashAttribute("error", "Please enter your email address");
    		return "redirect:/profile/show";
		}
		else if (another != null && !email.equals(user.getEmail())) {
			r.addFlashAttribute("error", "Email is already used by another user");
    		return "redirect:/profile/show";
		}
		else {
			eKartService.editProfile(user, username, email, phone);
			return "redirect:/profile";
		}
	}
	
	//Add new address
	@RequestMapping("/address/add")
	public String addAddress (HttpSession session, Model model, @ModelAttribute("address") Address address) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
		}
		return "newaddress.jsp";
	}
	
	@PostMapping(value = "/address/create")
    public String createAddress (HttpSession session, @Valid @ModelAttribute("address") Address address, BindingResult result) {
		addressValidator.validate(address, result);
		if (result.hasErrors()) {
 	        return "newaddress.jsp";
 	    }
		else {
			Long userid = (Long) session.getAttribute("userid");
			User user = eKartService.findUserById(userid);
			address.setUser(user);
			eKartService.createAddress(address);
 	    	return "redirect:/profile";
 	    }
    }
	
	//Edit address
	@RequestMapping("/address/{id}")
	public String editAddress (HttpSession session, @PathVariable("id") Long id, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			User user = eKartService.findUserById(userid);
	    	Address address = eKartService.findAddressById(id);
	    	if (!user.getAddresses().contains(address)) {
	    		return "redirect:/profile";
	    	}
	    	else {
	    		model.addAttribute("address", address);
	    	}
		}
		return "editaddress.jsp";
	}
	
	@PostMapping("/address/{id}/edit")
	public String editAddressProcess (@PathVariable("id") Long id, @RequestParam(value="street") String street,
		@RequestParam(value="city") String city, @RequestParam(value="state") String state,
		@RequestParam(value="country") String country) {
		eKartService.editAddress(id, street, city, state, country);
		return "redirect:/profile";
	}
	
	//Delete address
	@RequestMapping("/address/{id}/delete")
	public String deleteAddress(@PathVariable("id") Long id, HttpSession session) {
		Long userid = (Long) session.getAttribute("userid");
		User u = eKartService.findUserById(userid);
		Address a = eKartService.findAddressById(id);
		if (!u.getAddresses().contains(a)) {
			return "redirect:/";
		}
		else {
			eKartService.deleteAddress(id);
		}
		return "redirect:/profile";
	}
	
	//Add new card
	@RequestMapping("/card/add")
	public String addAddress (HttpSession session, Model model, @ModelAttribute("card") Card card) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
	    	Map<String, String> types = new HashMap<String, String>();
	    	types.put("Credit", "Credit");
	    	types.put("Debit", "Debit");
	    	model.addAttribute("types", types);
		}
		return "newcard.jsp";
	}
	
	@PostMapping(value = "/card/create")
    public String createCard (HttpSession session, @Valid @ModelAttribute("card") Card card, BindingResult result) {
		cardValidator.validate(card, result);
		if (result.hasErrors()) {
 	        return "newcard.jsp";
 	    }
		else {
			Long userid = (Long) session.getAttribute("userid");
			User user = eKartService.findUserById(userid);
			card.setUser(user);
			eKartService.createCard(card);
 	    	return "redirect:/profile";
 	    }
    }
	
	//Edit card info
	@RequestMapping("/card/{id}")
	public String editCard (HttpSession session, @PathVariable("id") Long id, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			User user = eKartService.findUserById(userid);
	    	Card card = eKartService.findCardById(id);
	    	if (!user.getCards().contains(card)) {
	    		return "redirect:/profile";
	    	}
	    	else {
	    		model.addAttribute("card", card);
	    	}
		}
		return "editcard.jsp";
	}
	
	@PostMapping("/card/{id}/edit")
	public String editCardProcess (@PathVariable("id") Long id, @RequestParam(value="type") String type,
		@RequestParam(value="number") String number, @RequestParam(value="expDate") @DateTimeFormat(pattern="MMddyyyy") Date expDate) {
		eKartService.editCard(id, type, number, expDate);
		return "redirect:/profile";
	}
	
	//Delete card
	@RequestMapping("/card/{id}/delete")
	public String deleteCard(@PathVariable("id") Long id, HttpSession session) {
		Long userid = (Long) session.getAttribute("userid");
		User u = eKartService.findUserById(userid);
		Card c = eKartService.findCardById(id);
		if (!u.getCards().contains(c)) {
			return "redirect:/";
		}
		else {
			eKartService.deleteCard(id);
		}
		return "redirect:/profile";
	}
	
	//View wishlist
	@RequestMapping("/wishlist")
	public String showWishlist (HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
		}
		return "wishlist.jsp";
	}
	
	//Add to wishlist
	@PostMapping("/wishlist/{id}/add")
	public String addWishlist (@PathVariable("id") Long id, HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		User user = eKartService.findUserById(userid);
		Product p = eKartService.findProductById(id);
		user.getWishProducts().add(p);
		eKartService.update(user);
		return "redirect:/wishlist";
	}
	
	//Remove from wishlist
	@PostMapping("/wishlist/{id}/remove")
	public String removeWishlist (@PathVariable("id") Long id, HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		User user = eKartService.findUserById(userid);
		Product p = eKartService.findProductById(id);
		user.getWishProducts().remove(p);
		eKartService.update(user);
		return "redirect:/wishlist";
	}
	
	//Move from wishlist to cart
	@PostMapping("/wishlist/{id}/moveToCart")
	public String moveFromWish (@PathVariable("id") Long id, HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		User user = eKartService.findUserById(userid);
		Product p = eKartService.findProductById(id);
		user.getWishProducts().remove(p);
		user.getBuyProducts().add(p);
		eKartService.update(user);
		return "redirect:/wishlist";
	}
	
	//View cart
	@RequestMapping("/cart")
	public String showCart (HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
		}
		return "cart.jsp";
	}
	
	//Add to cart
	@PostMapping("/cart/{id}/add")
	public String addCart (@PathVariable("id") Long id, HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		User user = eKartService.findUserById(userid);
		Product p = eKartService.findProductById(id);
		user.getBuyProducts().add(p);
		eKartService.update(user);
		return "redirect:/cart";
	}
	
	//Remove from cart
	@RequestMapping("/cart/{id}/remove")
	public String removeCart (@PathVariable("id") Long id, HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		User user = eKartService.findUserById(userid);
		Product p = eKartService.findProductById(id);
		user.getBuyProducts().remove(p);
		eKartService.update(user);
		return "redirect:/cart";
	}
	
	//Calculate amount
	@PostMapping("/calculateAmount")
	public String calculateAmount (HttpSession session, @RequestParam(value="amount") String amount) {
		Long userid = (Long) session.getAttribute("userid");
		User user = eKartService.findUserById(userid);
		List <Product> pList = user.getBuyProducts();
		
		String[] items = amount.split(",");
		int[] results = new int[items.length];
		for (int i = 0; i < results.length; i++) {
			results[i] = Integer.parseInt(items[i]);
		}
		
		double total = 0.0;
		for (int j = 0; j < pList.size(); j++) {
			Product p = user.getBuyProducts().get(j);
			double price = p.getProdPrice() - p.getProdPrice() * p.getProdSave() / 100;
			total = total + (price * results[j]);
		}
		session.setAttribute("total", total);
		session.setAttribute("results", results);
		return "redirect:/checkout";
	}
	
	//Checkout
	@RequestMapping("/checkout")
	public String checkOut (HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
	    	double total = (double) session.getAttribute("total");
	    	model.addAttribute("total", total);
	    	int[] results = (int[]) session.getAttribute("results");
	    	model.addAttribute("results", results);
		}
		return "checkout.jsp";
	}
	
	//Order process
	@PostMapping("/orderProcess")
	public String orderProcess (HttpSession session, @RequestParam(value="address") String addressid,
			@RequestParam(value="card") String cardid) {
		Long userid = (Long) session.getAttribute("userid");
		User user = eKartService.findUserById(userid);
		Long aid = Long.parseLong(addressid);
		Address address = eKartService.findAddressById(aid);
		Long cid = Long.parseLong(cardid);
		Card card = eKartService.findCardById(cid);
		double total = (double) session.getAttribute("total");
				
		Order o = eKartService.createOrder(user, address, card, total);
		eKartService.orderNotification(user, o);
		session.setAttribute("orderid", o.getId());
		return "redirect:/thankyou";
	}
	
	//Items purchase
	@RequestMapping("/thankyou")
	public String itemPurchased (HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			double total = (double) session.getAttribute("total");
	    	model.addAttribute("total", total);
	    	Long orderid = (Long) session.getAttribute("orderid");
	    	Order o = eKartService.findOrderById(orderid);
	    	String p = o.getProdList().get(0).getProdCategory();
	    	
	    	ArrayList<Product> pList = new ArrayList<Product>();
	    	List<Product> allProducts = eKartService.allProducts();
	    	
	    	for (int i = 0; i < allProducts.size(); i++) {
	    		Product prod = allProducts.get(i);
	    		if (prod.getProdCategory().equals(p)) {
	    			pList.add(prod);
	    		}
	    		
	    		if (pList.size() > 3) {
	    			break;
	    		}
	    	}
	    	model.addAttribute("pList", pList);
		}
		return "thankyou.jsp";
	}
	
	//View orders
	@RequestMapping("/orders")
	public String showOrders (HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
		}
		return "orders.jsp";
	}
	
	//Cancel orders
	@RequestMapping("/orders/{id}/cancel")
	public String cancelOrder (HttpSession session, @PathVariable("id") Long id) {
		Long userid = (Long) session.getAttribute("userid");
		User user = eKartService.findUserById(userid);
		Order order = eKartService.findOrderById(id);
		
		if (userid == null) {
			return "redirect:/login";
		}
		else if (!user.getOrderList().contains(order)) {
			return "redirect:/login";
		}
		else {
			order.setOrderStatus("Cancelled");
			eKartService.updateOrder(order);
			eKartService.cancelNotification(user, order);
			return "redirect:/orders";
		}
	}
	
	//View notifications
	@RequestMapping("/notification")
	public String showNotifications (HttpSession session, Model model) {
		Long userid = (Long) session.getAttribute("userid");
		if (userid == null) {
			return "redirect:/login";
		}
		else {
			User user = eKartService.findUserById(userid);
	    	model.addAttribute("user", user);
		}
		return "notification.jsp";
	}
	
	//Mark notification as read
	@RequestMapping("/notification/{id}/read")
	public String markAsRead (HttpSession session, @PathVariable("id") Long id) {
		Long userid = (Long) session.getAttribute("userid");
		User user = eKartService.findUserById(userid);
		Notification n = eKartService.findNotificationById(id);
		
		if (userid == null) {
			return "redirect:/login";
		}
		else if (!user.getNotificationList().contains(n)) {
			return "redirect:/login";
		}
		else {
			n.setHasRead(true);
			eKartService.updateNotification(n);
			return "redirect:/notification";
		}
	}
}

/* Products
 * 
 * Apple MacBook Air - $1099.99 (laptop; save 8%) 
 * 13-inch Retina display, 1.6GHz dual-core Intel Core i5, 128GB
 * 50 in stock
 * https://m.media-amazon.com/images/I/51p9iVs+bVL._AC_UL436_.jpg
 * 
 * Lenovo 2019 Newest Premium Ideapad 15.6 Inch Laptop - $299.88 (laptop; save 0%) 
 * AMD A6-9225/A9-9425 2.6GHz up to 3.0 Ghz, AMD Radeon R4, 4GB/8GB/16GB RAM, 128GB 256GB 512GB 1TB SSD, 2TB HHD, WiFi, Bluetooth, DVDRW, Windows 10
 * 40 in stock
 * https://m.media-amazon.com/images/I/71W5AiB2BML._AC_UL436_.jpg
 * 
 * 2019 Newest Premium Flagship Pro HP 15.6 Inch HD Notebook Laptop Computer - $319.88 (laptop: save 0%) 
 * AMD A6-9225, 2.6 GHz up to 3 GHz, 4GB/8GB DDR4, 1TB/2TB HDD, 128GB to 1TB SSD, AMD Radeon R4, DVDRW, HDMI, Windows 10
 * 50 in stock
 * https://m.media-amazon.com/images/I/713lC-Msp8L._AC_UL436_.jpg
 * 
 * Samsung Galaxy A10 32GB - $149.99 (phone; save 7%) 
 * SM-A105M/DS 6.2" HD+ Infinity-V LTE Factory Unlocked Smartphone
 * 2 in stock
 * https://m.media-amazon.com/images/I/41FIUOf1BHL._AC_UL436_.jpg
 * 
 * BLU Studio Mega 2018-6.0” HD - $69.99 (phone; save 0%) 
 * Unlocked Smartphone with Dual Main Camera -Black
 * 99 in stock 
 * https://m.media-amazon.com/images/I/71xuQ7PVjaL._AC_UL436_.jpg
 * 
 */

/* Users
 * purplesmart@eq.net
 * twily
 * partypony@eq.net
 * pinkie
 */