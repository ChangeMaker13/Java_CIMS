<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>COVID19 integrated Management System</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<a class="navbar-brand">COVID19 integrated Management System</a>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form action="./LoginCheckPage.jsp" method = "post">
					<h3 style="text-align: center;">login page</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="ID" id="id" name="id" size="15">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="Password" id="password" name="password" size="15">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="·Î±×ÀÎ">
				</form>
		</div>
	</div>
	
</body>
</html>