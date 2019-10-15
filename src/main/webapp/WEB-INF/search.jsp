<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Search Results</title>
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
		#main h2 {
			text-align: center;
			margin: 30px;
		}
		.item img {
			height: 200px;
			display: block;
			margin-left: auto;
			margin-right: auto;
		}
		.item {
			margin: 5px;
			border: 1px solid black;
			border-radius: 10px;
			padding: 10px;
			width: 400px;
			display: inline-block;
		}
		.description {
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
			<h3>Search results</h3>
			<c:choose>
				<c:when test = "${fn:length(products) gt 0}">
					<c:forEach items = "${products}" var = "product">
						<c:choose>
							<c:when test = "${product.prodSave > 0}">
								<div class = "item">
									<img src = "${product.prodImg}"><br/>
										<div class = "description">
										<a href = "/product/${product.id}">${product.productName}</a><br/>
										<h4>$<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" 
				            			value="${product.prodPrice - (product.prodSave/100) * product.prodPrice}"/></h4>
				            			<span>Original price: <del>$${product.prodPrice}</del></span><br/>
				            			<span>You save: ${product.prodSave}%</span><br/>
									</div>
						 		</div>
							</c:when>
							<c:when test = "${product.prodSave == 0}">
								<div class = "item">
									<img src = "${product.prodImg}"><br/>
										<div class = "description">
										<a href = "/product/${product.id}">${product.productName}</a><br/>
										<h4>$${product.prodPrice}</h4>
									</div>
						 		</div>
							</c:when>
						</c:choose>
				 	</c:forEach>
				</c:when>
				<c:otherwise>
					<h2>No results found</h2>
				</c:otherwise>
			</c:choose>
        </div>
    </div>
</body>
</html>