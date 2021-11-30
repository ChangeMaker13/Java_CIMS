<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
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
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<a class="navbar-brand" href="MainPage.jsp">CIMS</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="./DiseaseAdd.jsp">기저질환</a></li>
				<li><a href="./Reservation.jsp">예약확인</a></li>
				<li><a href="./Confirmation.jsp">확인증</a></li>
				<li><a href="./Visitor.jsp">가게별 방문자</a></li>
				<li><a href="./VisitLog.jsp">방문기록</a></li>
			</ul>
		</div>
	</nav>
<%
		Connection conn = ConnectionManager.getConn();
		
		//가게명 가져오기
		String shop = request.getParameter("shop");
		
		//쿼리 구성하기
		String sql = "SELECT name, current_visitor FROM SHOP WHERE NAME = '" + shop + "'";

		PreparedStatement stmt = conn.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ResultSet rs = stmt.executeQuery(sql);
		
		//예약 내역 표시
		out.println("<h2>가게별 방문자 수 확인</h2>");
		out.println("<h3>검색 결과</h3>");
		
		if(!rs.next()) {
			out.print("<h4>등록되지 않은 가게 혹은 잘못된 이름입니다.</h4>");
			
			rs.close();
			conn.close();
			System.out.println("Connection closed");
		}
		else {
			rs.beforeFirst();
		%>
			<table class="table">
			<thread>
				<tr>
					<th>가게명</th>
					<th>방문자 수</th>
				</tr>
			</thread>
		<tbody>
		<%
			
			while(rs.next()) {
				out.println("<tr>");
				out.println("<td>"+rs.getString(1)+"</td>");
				out.println("<td>"+rs.getInt(2)+"</td>");
				out.println("</tr>");
			}
			out.println("</tbody>");
			out.println("</table>");

			rs.close();
			conn.close();
			System.out.println("Connection closed");
		}
%>
<input type="button" class="btn btn-default" onClick="history.go(-1);" value="돌아가기">
</body>
</html>