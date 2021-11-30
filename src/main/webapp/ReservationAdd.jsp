<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "Connection.ConnectionManager" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Calendar" %>
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
	<h2>접종예약 페이지</h2>
	<%
		//변수 선언
		Connection conn = ConnectionManager.getConn();
		String hname = request.getParameter("hname");
		String date = request.getParameter("rdate");
		
		//예약 가능시간 조회
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		java.util.Date d = sdf.parse(date);
		 
		c.setTime(d);
		c.add(Calendar.DATE,1);
		String date1 = sdf.format(c.getTime());
		
		ArrayList<String> rTime = new ArrayList<>();
			
		rTime.add("09:00");
		rTime.add("10:00");
		rTime.add("11:00");
		rTime.add("12:00");
		rTime.add("13:00");
		rTime.add("14:00");
		rTime.add("15:00");
		rTime.add("16:00");
		rTime.add("17:00");
		
		String sql = "SELECT r.Rdate\n"
				+ "FROM RESERVATION r, HOSPITAL h\n"
				+ "WHERE r.Hnumber = h.Hnumber\n"
				+ "AND h.Name = '" + hname + "'\n"
				+ "AND r.Rdate > '" + date + "'\n"
				+ "AND r.Rdate < '" + date1 + "'";
		PreparedStatement stmt = conn.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ResultSet rs = stmt.executeQuery(sql);
		
		if(!rs.next()) {
		} 
		else {
			rs.beforeFirst();
			while(rs.next()) {
				java.sql.Date date2 = rs.getDate(1);
				java.util.Date rDate = new java.util.Date(date2.getTime());
				
				String atime = new SimpleDateFormat("HH:mm").format(rDate);
				rTime.remove(atime);
			}
			
		}
		out.println("<h3>시간을 선택하세요.</h3>");
	%>
		<table class="table">
		<thread>
			<tr>
				<th>병원</th>
				<th>시간</th>
			</tr>
		</thread>
		<tbody>
	<%	
			out.println("<tr>");
			out.println("<td>" + hname + "</td>");
			out.println("<td>" + date + "</td>");
			out.println("</tr>");
	%>
		</tbody>
		</table>
		
		<div class="container">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="text-align:center; padding-top: 20px;">
					<form action="./ReservationAddDB.jsp" method = "post">
						<h4 style="text-align: center;">시간 선택</h4>
						<div class="form-group">
							<select name="selectTime" class="form-control" >
	<%
							for(int i = 0; i < rTime.size(); i++) {
								out.println("<option value=\"" + date + " " + rTime.get(i) + "\">" + rTime.get(i) + "</option>");
							}
	%>
							</select>
	<%						
							out.println("<input type=\"hidden\" id=\"hname\" name=\"hname\" value=\"" + hname + "\">");
	 %>
						</div>
						<input class="btn btn-default" onClick="history.go(-1);" value="돌아가기">
						<input type="reset" class="btn btn-default" value="리셋">
						<input type="submit" class="btn btn-default" value="추가">
					</form>
			</div>
		</div>
	<%
		rs.close();
		conn.close();
		System.out.println("Connection closed");
	%>
</body>
</html>