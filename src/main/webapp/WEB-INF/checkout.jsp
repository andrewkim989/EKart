<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Checkout</title>
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
		#address {
			margin: 25px;
			padding: 15px;
			display: inline-block;
			vertical-align: top;
			border: 1px dotted blue;
			border-radius: 8px;
			width: 550px;
		}
		#card {
			margin: 25px;
			padding: 15px;
			display: inline-block;
			vertical-align: top;
			border: 1px dotted green;
			border-radius: 8px;
			width: 550px;
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
        	<h1>Order Details</h1>
        	
        	<form method = "post" action = "/orderProcess">
	        	<table class = "table table-striped table-secondary">
	        		<tr>
				        <th scope = "col" width="30%">Name</th>
				        <th scope = "col">Image</th>
				        <th scope = "col">Quantity</th>
				        <th scope = "col">Price</th>
				    </tr>
				    <c:forEach var = "p" items = "${user.buyProducts}" varStatus = "resultIndex">
					    <tr>
					    	<td>${p.productName}</td>
					    	<td><img src = "${p.prodImg}"/></td>
					    	<td>${results[resultIndex.index]}</td>
					    	<td>$<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" 
	          				value="${(p.prodPrice - p.prodPrice * (p.prodSave/100)) * results[resultIndex.index]}"/></td>
					    </tr>
				    </c:forEach>
	        	</table>
	        	<h4>Total Price: $<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" 
	          		value="${total}"/></h4>
        	
        		<div id = "address">
        		<h4>Select an address</h4>
        		<c:choose>
        			<c:when test = "${fn:length(user.addresses) gt 0}">
        				<c:forEach items = "${user.addresses}" var = "a">
        					<input type = "radio" name = "address" value = "${a.id}">
			        			<p>${a.street}</p>
			        			<p>${a.city}, ${a.state} ${a.country}</p>
		        			<br/>
		        		</c:forEach>
        			</c:when>
        			<c:otherwise>
        				<h4>You have not set up an address yet. Please go to your profile to set up an address in order
        				to finish the purchasing process.</h4>
        				<a href = "/address/add" type = "button" class = "btn btn-primary">Add new address</a>
        			</c:otherwise>
        		</c:choose>
        	</div>
        	
        	<div id = "card">
        		<h4>Select a card</h4>
        		<c:choose>
        			<c:when test = "${fn:length(user.cards) gt 0}">
        				<c:forEach items = "${user.cards}" var = "c">
        					<input type = "radio" name = "card" value = "${c.id}">
		        			<p>Type: ${c.type}</p>
		        			<p>Number: ${c.number}</p>
		        			<p>Exp. Date: ${c.expDate}</p>
		        			<br/>
		        		</c:forEach>
        			</c:when>
        			<c:otherwise>
        				<h4>You have not set up a credit or debit card information yet. Please got to your profile to set up
        				a card information in order to finish the purchasing process. </h4>
        				<a href = "/card/add" type = "button" class = "btn btn-primary">Add new card</a>
        			</c:otherwise>
        		</c:choose>
        		<br/>
        	</div>
	        	<button type = "submit" class = "btn btn-secondary">Finish Purchasing</button>
	        </form>
        </div>
    </div>
</body>
</html>