<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "Connection.ConnectionManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>��� ���� ���� ������</h1>
	<%
		//���� ����
		Connection conn = ConnectionManager.getConn();
		String hospital_name = request.getParameter("hname");
		String date = request.getParameter("rdate");
		
		//���� ���ɽð� ��ȸ
		
		
		conn.close();
		System.out.println("Connection closed");
	%>
</body>
</html>