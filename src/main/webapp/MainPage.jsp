<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "Query.ClientQuery" %>
<%@ page import = "Connection.ConnectionManager" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>COVID19 integrated Management System</title>

</head>
<body>

	<%
		Connection conn = ConnectionManager.getConn();
		String id = (String)session.getAttribute("id");
	%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<a class="navbar-brand" href="MainPage.jsp">COVID19 integrated Management System (CIMS)</a>
		</div>
	</nav>
	<div style="text-align:right;">
		<h5>Welcome, <%=ClientQuery.getName(conn, id)%> <a href="LogOut.jsp">logout</a></h5>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-12">
				<h1>Main Page</h1>
				<ul class="list-group">
					<a href="./DiseaseAdd.jsp" class="list-group-item list-group-item-active">기저질환 정보 추가/삭제</a>
					<a href="./Reservation.jsp" class="list-group-item list-group-item-active">백신접종 예약내역 확인</a>
					<a href="./Confirmation.jsp" class="list-group-item list-group-item-active">확인증 조회</a>
					<a href="./Visitor.jsp" class="list-group-item list-group-item-active">가게별 방문자 확인</a>
					<a href="./VisitLog.jsp" class="list-group-item list-group-item-active">가게 방문 기록 확인</a>
				</ul>
			</div>
		</div>
	</div>
	
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>