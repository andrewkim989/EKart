<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Orders</title>
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
        	<h1>${user.username}'s orders</h1>
        	
        	<table class = "table table-striped table-primary">
        		<tr>
			        <th scope = "col">Order ID</th>
			        <th scope = "col">Order date</th>
			        <th scope = "col">Order status</th>
			        <th scope = "col">Price</th>
			        <th scope = "col">Address</th>
			        <th scope = "col">Card type</th>
			        <th scope = "col">Products Bought</th>
			        <th scope = "col">Action</th>
			    </tr>
			    <c:forEach var = "o" items = "${user.orderList}">
				    <tr>
				    	<td>${user.email}${o.id}</td>
				    	<td>${o.createdAt}</td>
				    	<td>${o.orderStatus}</td>
				    	<td>$<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" 
          				value="${o.price}"/></td>
          				<td>${o.orderAddress.street}<br/>
          				${o.orderAddress.city}, ${o.orderAddress.state} ${o.orderAddress.country}
          				</td>
          				<td>${o.cardType}</td>
          				<td>
          					<c:forEach var = "p" items = "${o.prodList}">
          						-${p.productName}<br/>
          					</c:forEach>
          				</td>
				    	<td>
				    		<c:choose>
				    			<c:when test = "${o.orderStatus.equals('Open')}">
				    				<a href = "/orders/${o.id}/cancel" class = "btn btn-danger">Cancel order</a>
				    			</c:when>
				    		</c:choose>
				    	</td>
				    </tr>
			    </c:forEach>
        	</table>
        </div>
    </div>
</body>
</html>