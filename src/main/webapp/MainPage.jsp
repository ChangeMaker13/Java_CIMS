<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>This is main page</h1>
	<h2>Welcome, <%= request.getParameter("name") %></h2>
	
	<h2><a href = "./DiseaseAdd.jsp">기저질환 정보 추가</a></h2>
	<h2><a href = "./DiseaseRemove.jsp">기저질환 정보 삭제</a></h2>
</body>
</html>