<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Cart</title>
	<link rel = "stylesheet" href = "https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
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
		#main h3 {
			color: blue;
			text-align: center;
		}
		table img {
			height: 100px;
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
        	<h1>${user.username}'s cart</h1>
        	
        	<h4>Select the total amount of items that you want to purchase for each of the products before
        	proceeding to the checkout.</h4>
        	
        	<form method = "post" action = "/calculateAmount">
	        	<table class = "table table-striped table-primary">
	        		<tr>
				        <th scope = "col" width="30%">Name</th>
				        <th scope = "col">Image</th>
				        <th scope = "col">Price</th>
				        <th scope = "col">Quantity</th>
				        <th scope = "col">Action</th>
				    </tr>
				    <c:forEach var = "p" items = "${user.buyProducts}">
					    <tr>
					    	<td>${p.productName}</td>
					    	<td><img src = "${p.prodImg}"/></td>
					    	<td>$<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" 
	          				value="${p.prodPrice - p.prodPrice * (p.prodSave/100)}"/></td>
	          				<td>
	          					<select name = "amount">
	          						<c:forEach begin="1" end="${p.prodQtyInStock - p.prodQtySold}" var="i" >
								    	<option value="${i}">${i}</option>
								   	</c:forEach>
	          					</select>
	          				</td>
					    	<td>
					    		<a href = "/cart/${p.id}/remove" class = "btn btn-danger">Remove from cart</a>
					    	</td>
					    </tr>
				    </c:forEach>
	        	</table>
        	
	        	<button type = "submit" class = "btn btn-success">Proceed to checkout</button>
	        </form>
        </div>
    </div>
</body>
</html>