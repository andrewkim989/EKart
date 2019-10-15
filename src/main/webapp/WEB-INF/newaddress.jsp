<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Add new address</title>
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
			<h1>Add new address</h1>
			<form:form method="POST" action="/address/create" modelAttribute="address">
	   			<p class="form-group">
		            <form:label path="street">Street Address</form:label>
		            <form:errors path="street" class="red"/>
		            <form:input type="text" path="street" class="form-control"/>
		        </p>
		        <p class="form-group">
		            <form:label path="city">City</form:label>
		            <form:errors path="city" class="red"/>
		            <form:input type="text" path="city" class="form-control"/>
		        </p>
		        <p class="form-group">
		            <form:label path="state">State</form:label>
		            <form:errors path="state" class="red"/>
		            <form:input type="text" path="state" class="form-control"/>
		        </p>
		        <p class="form-group">
		            <form:label path="country">Country</form:label>
		            <form:errors path="country" class="red"/>
		            <form:input type="text" path="country" class="form-control"/>
		        </p>
		        <button type="submit" class="btn btn-success" class="form-control">Create address</button>
		    </form:form>
		    <div id = "bottom">
		    	<a href = "/profile">Back to profile</a>
		    </div>
		</div>
	</div>
</body>
</html>