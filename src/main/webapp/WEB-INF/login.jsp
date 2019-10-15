<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">  
	<title>Login</title>
	<style>
		#wrapper {
		    background: linear-gradient(to bottom, lightblue, white);
		}
		#main {
			margin-left: 30%;
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
    		margin: 20px;
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
		  		<h1>Login</h1>  
				    <span class="red"><c:out value="${error}"/></span>
				    <form method="POST" action="/login">
		        	<p class="form-group">
			            <label>Email:</label>
			            <input type="email" name="email" class="form-control"/>
		       		 </p>
		       		<p class="form-group">
		            <label for="password">Password:</label>
		            <input type="password" name="password" class="form-control"/>
		        </p>
		        <button type="submit" class="btn btn-primary" class="form-control">login</button>
		    	</form>
		    </div>
		    <div id = "bottom">
		    	<a href = "/">Home Page</a>
		    	<a href = "/register">Don't have an account? Sign up here! </a>
		    </div>
		</div>
	</div>
</body>
</html>