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
	
	<h2><a href = "./DiseaseAdd.jsp">기저질환 정보 추가/삭제</a></h2>
	<h2><a href = "./Reservation.jsp">백신접종 예약내역 확인</a></h2>
	<h2><a href = "./Visitor.jsp">가게별 방문자 확인</a></h2>
</body>
</html>