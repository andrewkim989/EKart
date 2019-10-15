<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Edit Address</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">  
    <style>
    	#wrapper {
		    background: linear-gradient(to bottom, lightblue, white);
		}
		#main {
			margin: auto;
			width: 600px;
			padding-bottom: 30px;
		}
    	.red {
    		color: red;
    	}
    	h1 {
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
			<div class="col-5">   
		  		<h1>Edit Address</h1>
				<span class="red"><c:out value="${error}"/></span>
				 <form method="POST" action="/address/${address.id}/edit">
		        	<p class="form-group">
			            <label>Street Address</label>
			            <input type="text" name="street" class="form-control" value = "${address.street}"/>
		       		</p>
		       		<p class="form-group">
			            <label>City</label>
			            <input type="text" name="city" class="form-control" value = "${address.city}"/>
		       		</p>
		       		<p class="form-group">
			            <label>State</label>
			            <input type="text" name="state" class="form-control" value = "${address.state}"/>
		       		</p>
		       		<p class="form-group">
			            <label>Country</label>
			            <input type="text" name="country" class="form-control" value = "${address.country}"/>
		       		</p>
		        	<button type="submit" class="btn btn-success" class="form-control">Modify Address</button>
		    	</form>
		    </div>
		    <div id = "bottom">
		    	<a href = "/profile">Back to profile</a>
		    </div>
		</div>
	</div>
</body>
</html>