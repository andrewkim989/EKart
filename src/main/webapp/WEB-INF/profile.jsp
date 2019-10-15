<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>${user.username}'s profile</title>
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
		#main a {
			display: inline-block;
		}
		#info {
			margin-left: 30%;
		}
		#info h1 {
			margin-left: 10%;
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
        	<div id = "info">
        		<h1>User information</h1>
				<h4>Name: ${user.username}</h4>
				<h4>Email: ${user.email}</h4>
				<h4>Phone Number: ${user.phone}</h4>
				<a href = "/profile/show" type = "button" class = "btn btn-light">Edit profile</a>
        	</div>
        	<div id = "address">
        		<h2>Addresses</h2>
        		<c:choose>
        			<c:when test = "${fn:length(user.addresses) gt 0}">
        				<c:forEach items = "${user.addresses}" var = "a">
		        			<p>${a.street}</p>
		        			<p>${a.city}, ${a.state} ${a.country}</p>
		        			<a href = "/address/${a.id}" type = "button" class = "btn btn-light">Edit address</a>
		        			<a href = "/address/${a.id}/delete" type = "button" class = "btn btn-dark">Delete address</a>
		        			<br/>
		        		</c:forEach>
        			</c:when>
        			<c:otherwise>
        				<h4>No addresses found</h4>
        			</c:otherwise>
        		</c:choose>
        		<br/>
        		<a href = "/address/add" type = "button" class = "btn btn-primary">Add new address</a>
        	</div>
        	
        	<div id = "card">
        		<h2>Card Information</h2>
        		<c:choose>
        			<c:when test = "${fn:length(user.cards) gt 0}">
        				<c:forEach items = "${user.cards}" var = "c">
		        			<p>Type: ${c.type}</p>
		        			<p>Number: ${c.number}</p>
		        			<p>Exp. Date: ${c.expDate}</p>
		        			<a href = "/card/${c.id}" type = "button" class = "btn btn-light">Edit card</a>
		        			<a href = "/card/${c.id}/delete" type = "button" class = "btn btn-dark">Delete card</a>
		        			<br/>
		        		</c:forEach>
        			</c:when>
        			<c:otherwise>
        				<h4>No card information available</h4>
        			</c:otherwise>
        		</c:choose>
        		<br/>
        		<a href = "/card/add" type = "button" class = "btn btn-primary">Add new card</a>
        	</div>
        </div>
    </div>
</body>
</html>