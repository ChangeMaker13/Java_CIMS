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
	
	<h2><a href = "./DiseaseAdd.jsp">������ȯ ���� �߰�/����</a></h2>
	<h2><a href = "./Reservation.jsp">������� ���೻�� Ȯ��</a></h2>
	<h2><a href = "./Visitor.jsp">���Ժ� �湮�� Ȯ��</a></h2>
</body>
</html>