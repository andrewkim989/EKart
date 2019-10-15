<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Add new card</title>
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
			<h1>Add new card</h1>
			<form:form method="POST" action="/card/create" modelAttribute="card">
	   			<p class="form-group">
		            <form:label path="type">Card type</form:label>
		            <form:errors path="type" class="red"/>
		            <form:select path = "type" items = "${types}" class="form-control">
		            	<form:options value = "credit"/>
		            	<form:options value = "debit"/>
		            </form:select>
		        </p>
		        <p class="form-group">
		            <form:label path="number">Card Number</form:label>
		            <form:errors path="number" class="red"/>
		            <form:input type="text" path="number" class="form-control"/>
		        </p>
		        <p class="form-group">
		            <form:label path="expDate">Expiration Date</form:label>
		            <form:errors path="expDate" class="red"/>
		            <form:input type="date" path="expDate" class="form-control"/>
		        </p>
		        <button type="submit" class="btn btn-success" class="form-control">Create card</button>
		    </form:form>
		    <div id = "bottom">
		    	<a href = "/profile">Back to profile</a>
		    </div>
		</div>
	</div>
</body>
</html>