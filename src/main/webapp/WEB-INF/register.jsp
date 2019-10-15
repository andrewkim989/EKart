<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Sign Up</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">  
    <style>
    	#wrapper {
		    background: linear-gradient(to bottom, lightblue, white);
		}
		#main {
			margin: auto;
			padding-bottom: 30px;
		}
    	.red {
    		color: red;
    	}
    	h1 {
    		text-align: center;
    		padding-top: 20px;
    	}
    	form {
    		width: 500px;
    		margin: auto;
    		padding-top: 30px;
    	}
    	#bottom {
    		text-align: center;
    	}
    	#bottom a {
    		margin: 10px 40px;
    	}
    </style>
</head>
<body>
	<div id = "wrapper">
		<div id = "main">
			<h1>Sign Up for an Account</h1>
			<form:form method="POST" action="/register" modelAttribute="user">
	   			<p class="form-group">
		            <form:label path="username">Username</form:label>
		            <form:errors path="username" class="red"/>
		            <form:input type="text" path="username" class="form-control"/>
		        </p>
		        <p class="form-group">
		            <form:label path="email">Email Address</form:label>
		            <form:errors path="email" class="red"/>
		            <form:input type="email" path="email" class="form-control"/>
		        </p>
		        <p class="form-group">
		            <form:label path="phone">Phone Number (No dashes or parentheses)</form:label>
		            <form:errors path="phone" class="red"/>
		            <form:input type="text" path="phone" class="form-control"/>
		        </p>
		        <p class="form-group">
		            <form:label path="password">Password (Must be at least 5 characters long)</form:label>
		            <form:errors path="password" class="red"/>
		            <form:password path="password" class="form-control"/>
		        </p>
		        <p class="form-group">
		            <form:label path="passwordConfirmation">Password Confirmation</form:label>
		            <form:errors path="passwordConfirmation" class="red"/>
		            <form:password path="passwordConfirmation" class="form-control"/>
		        </p>
		        <button type="submit" class="btn btn-primary" class="form-control">Register</button>
		    </form:form>
		    <div id = "bottom">
		    	<a href = "/">Home Page</a>
		    	<a href = "/login">Sign In</a>
		    </div>
		</div>
	</div>
</body>
</html>