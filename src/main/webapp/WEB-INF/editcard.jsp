<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Edit Card Information</title>
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
				 <form method="POST" action="/card/${card.id}/edit">
		        	<p class="form-group">
			            <label>Type</label>
			            <select name = "type" class="form-control">
							  <option value="Credit">Credit</option>
							  <option value="Debit">Debit</option>
						</select>
		       		</p>
		       		<p class="form-group">
			            <label>Card Number</label>
			            <input type="text" name="number" class="form-control" value = "${card.number}"/>
		       		</p>
		       		<p class="form-group">
			            <label>Expiration Date</label>
			            <input type="date" name="expDate" class="form-control" value = "${card.expDate}"/>
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