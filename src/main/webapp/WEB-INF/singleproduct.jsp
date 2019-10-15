<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>${product.productName}</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">  
	<style>
		#wrapper {
		    background: linear-gradient(to bottom, lightblue, white);
		}
		#top {
		    background-color: rgb(121, 121, 255);
		    color: darkblue;
		    padding: 10px;
		    padding-left: 30px;
		    font-size: 24px;
		}
		#top h2 {
			display: inline-block;
		}
		#search {
			display: inline-block;
			margin-left: 200px;
		}
		#toptwo, #topthree {
			background-color: darkblue;
		}
		#toptwo a {
		    color: white;
		    display: inline-block;
		    margin: 5px 120px;
		}
		#topthree a {
		    color: white;
		    display: inline-block;
		    margin: 5px 50px;
		}
		#main {
			padding: 30px;
		}
		#main img {
			display: inline-block;
			vertical-align: top;
		}
		#total {
			color: green;
		}
		#description {
			display: inline-block;
			margin-left: 100px;
			width: 700px;
		}
		#greyline {
			height: 1px;
			background-color: grey;
			margin: 20px 0px;
		}
		.singlerating {
			margin: 10px;
			padding-left: 10px;
			border: 1px solid green;
			border-radius: 8px;
		}
		.red {
			color: red;
		}
		#ratingform form {
			margin-left: 30%;
		}
		#ratingform h4 {
			text-align: center;
		}
	</style>
</head>
<body>
	<div id = "wrapper">
		<div id = "top">
            <h2>EKart</h2>
            
            <div id = "search">
				<form action = "/search" method = "post">
					Search: 
					<input type = "text" name = "input" size = "50">
					<input type = "submit" value = "Search">
				</form>
			</div>
			
            <c:choose>
           		<c:when test = "${userid == null}">
	           		<div id = "toptwo">
	            		<a href = "/">Home</a>
			        	<a href = "/login">Login</a>
			        	<a href = "/register">Signup</a>
		        	</div>
           		</c:when>
           		<c:otherwise>
           			<div id = "topthree">
           				<a href = "/">Home</a>
           				<a href = "/profile">Profile</a>
			        	<a href = "/cart">Cart</a>
			        	<a href = "/wishlist">Wish List</a>
			        	<a href = "/orders">Orders</a>
			        	<a href = "/notification">Notification</a>
			        	<a href = "/logout">Logout</a>
           			</div>
           		</c:otherwise>
           	</c:choose>
        </div>
        
        <div id = "main">
        	<img src = "${product.prodImg}">
        	<div id = "description">
        		<h3>Product: ${product.productName}</h3>
				
		        <h4>$<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" 
          			value="${product.prodPrice - (product.prodSave/100) * product.prodPrice}"/></h4>
          			<span>Original price: <del>$${product.prodPrice}</del></span><br/>
          			<span>You save: ${product.prodSave}%</span><br/>
          			<p><b>Description: </b>${product.prodDesc}</p>
          			<p><b>Items left in stock: </b>${product.prodQtyInStock - product.prodQtySold}</p>
          		<c:choose>
          			<c:when test = "${user != null}">
          			<c:choose>
          				<c:when test = "${!user.buyProducts.contains(product)}">
	          				<form method = "post" action = "/cart/${product.id}/add">
					        	<button type = "submit" class = "form-control btn btn-primary">Add to cart</button>
					        </form><br/>
	          			</c:when>
	          			<c:when test = "${user.buyProducts.contains(product)}">
	          				<form method = "post" action = "/cart/${product.id}/remove">
					        	<button type = "submit" class = "form-control btn btn-secondary">Remove from cart</button>
					        </form><br/>
	          			</c:when>
          			</c:choose>
          			</c:when>
          		</c:choose>
          		
          		<c:choose>
          			<c:when test = "${user != null}">
          			<c:choose>
          				<c:when test = "${!user.wishProducts.contains(product)}">
	          				<form method = "post" action = "/wishlist/${product.id}/add">
					        	<button type = "submit" class = "form-control btn btn-light">Add to wish list</button>
					        </form><br/>
	          			</c:when>
	          			<c:when test = "${user.wishProducts.contains(product)}">
	          				<form method = "post" action = "/wishlist/${product.id}/remove">
					        	<button type = "submit" class = "form-control btn btn-warning">Remove from wish list</button>
					        </form><br/>
	          			</c:when>
          			</c:choose>
          			</c:when>
          		</c:choose>
        	</div>
        	
        	<div id = "greyline"></div>
        	
        	<div id = "ratings">
        	    <c:choose>
        			<c:when test = "${fn:length(product.productRatings) gt 0}">
        			<c:set var="total" value="${0}"/>
		        		<c:forEach var="r" items="${product.productRatings}">
						    <c:set var="total" value="${total + r.rating}" />
						</c:forEach>
						<c:set var = "total" value = "${total / fn:length(product.productRatings)}"/>
		        		<h4>Overall Rating: <span id = "total">${total}</span></h4>
        				<c:forEach items = "${product.productRatings}" var = "r">
        					<div class = "singlerating">
        						<h5>${r.rater.username}:</h5>
        						<p><b>Rating:</b> ${r.rating}/5</p>
		        			
			        			<b>Comment: </b>
			        			<p>${r.description}</p>
        					</div>
		        		</c:forEach>
        			</c:when>
        			<c:otherwise>
	        			<h3>No ratings have been submitted yet for this product</h3>
	        		</c:otherwise>
        		</c:choose>
        	</div>
        	<div id = "greyline"></div>
        	
        	<c:choose>
        		<c:when test = "${userid != null}">
        			<div id = "ratingform">
		        		<h4>Rate this product</h4>
			        	<form method = "post" action = "/product/${product.id}">
			        		<span class="red"><c:out value="${error}"/></span><br/>
			        		Rating:
			        		<select name = "rating">
							  	<option value="5">5</option>
							  	<option value="4">4</option>
							  	<option value="3">3</option>
							 	<option value="2">2</option>
							  	<option value="1">1</option>
							</select><br/><br/>
							
							Comment: <br/>
							<textarea name = "description" rows="4" cols="50"> Leave a comment here </textarea><br/><br/>
							
							<button type="submit" class="btn btn-success" class="form-control">Submit a rating</button>
			        	</form>
		        	</div>
		        </c:when>
        	</c:choose>
        </div>
	</div>
</body>
</html>