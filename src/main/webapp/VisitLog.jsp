<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "Connection.ConnectionManager" %>
<%@ page import = "java.text.SimpleDateFormat" %>
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
		String id = (String)session.getAttribute("id");
		String unumber = "";
		Boolean reserved = false;
		
		//unumber 구하기
		String sql = "SELECT unumber FROM CLIENT WHERE User_id = ?";
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			unumber = rs.getString(1);
		}
		
		ps.close();
		rs.close();
		
		out.println("<h2>가게 방문 기록 확인</h2>");
		out.println("<h3>검색 결과</h3>");
		
		sql = "SELECT c.Name, s.Name, v.Visit_time\n"
				+ "FROM VISIT_LOG v, CLIENT c, SHOP s\n"
				+ "WHERE v.Unumber = c.Unumber\n"
				+ "AND v.Snumber = s.Snumber\n"
				+ "AND c.Unumber ='" + unumber +"'";
		
		PreparedStatement stmt = conn.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		rs = stmt.executeQuery(sql);
		
		if(!rs.next()) {
			out.println("<h4>방문 기록이 없습니다.</h4>");
		} 
		else {
			rs.beforeFirst();
		%>
			<table class="table">
			<thread>
				<tr>
					<th>이름</th>
					<th>가게</th>
					<th>방문 시간</th>
				</tr>
			</thread>
		<tbody>
		<%
			
			while(rs.next()) {
				out.println("<tr>");
				out.println("<td>"+rs.getString(1)+"</td>");
				out.println("<td>"+rs.getString(2)+"</td>");
				
				java.sql.Date date = rs.getDate(3);
				java.util.Date rDate = new java.util.Date(date.getTime());
				out.println("<td>"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(rDate)+"</td>");
				out.println("</tr>");
			}
			out.println("</tbody>");
			out.println("</table>");
		}
		

		rs.close();
		conn.close();
		System.out.println("Connection closed");
%>
<input type="button" class="btn btn-default" onClick="location.href='MainPage.jsp'" value="돌아가기">
</body>
</html>