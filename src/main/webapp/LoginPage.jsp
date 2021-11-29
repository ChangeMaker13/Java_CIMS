<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>COVID19 integrated Management System</h1>
	<h2>-------------------Welcome--------------------</h2>
	<h2>Login page</h2>
	<form action="./LoginCheckPage.jsp" method = "post">
		<div>ID : <input type="text" id="id" name="id" size="15"></div>
		<div>Password : <input type="text" id="password" name="password" size="15"></div>
		<button type = "reset">Reset</button>
		<button type = "submit">Submit</button>
	</form>
</body>
</html>