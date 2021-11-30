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
	
	<h2><a href = "./DiseaseAdd.jsp">기저질환 정보 추가/삭제</a></h2>
	<h2><a href = "./Reservation.jsp">백신접종 예약내역 확인</a></h2>
	<h2><a href = "./Confirmation.jsp">확인증 조회</a></h2>
	<h2><a href = "./Visitor.jsp">가게별 방문자 확인</a></h2>
	<h2><a href = "./VisitLog.jsp">가게 방문 기록 확인</a></h2>
	
	<input type="button" onclick="location.href='./index.jsp'" value = "로그아웃"/>
</body>
</html>