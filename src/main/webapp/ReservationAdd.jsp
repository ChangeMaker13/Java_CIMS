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
	<h1>백신 접종 예약 페이지</h1>
	<%
		//변수 선언
		Connection conn = ConnectionManager.getConn();
		String hospital_name = request.getParameter("hname");
		String date = request.getParameter("rdate");
		
		//예약 가능시간 조회
		
		
		conn.close();
		System.out.println("Connection closed");
	%>
</body>
</html>