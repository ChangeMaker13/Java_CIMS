<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "Query.ClientQuery" %>
<%@ page import = "Connection.ConnectionManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		Connection conn = ConnectionManager.getConn();
		String id = (String)session.getAttribute("id");
	%>
	<h1>This is main page</h1>
	<h2>Welcome, <%= ClientQuery.getName(conn, id)%></h2>
	
	<h2><a href = "./DiseaseAdd.jsp">������ȯ ���� �߰�/����</a></h2>
	<h2><a href = "./Reservation.jsp">������� ���೻�� Ȯ��</a></h2>
	<h2><a href = "./Confirmation.jsp">Ȯ���� ��ȸ</a></h2>
	<h2><a href = "./Visitor.jsp">���Ժ� �湮�� Ȯ��</a></h2>
	<h2><a href = "./VisitLog.jsp">���� �湮 ��� Ȯ��</a></h2>
	
	<input type="button" onclick="location.href='./index.jsp'" value = "�α׾ƿ�"/>
</body>
</html>