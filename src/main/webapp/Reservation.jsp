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
		
		//예약 조회
		sql = "SELECT r.Rnumber, r.Rdate, h.Name, v.Name\n"
		+ "FROM RESERVATION r, HOSPITAL h, CLIENT c, VACCINE v\n"
		+ "WHERE c.Unumber = r.Unumber\n"
		+ "AND r.Hnumber = h.Hnumber\n"
		+ "AND r.Vnumber = v.Vnumber\n"
		+ "AND c.Unumber = '" + unumber +"'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery(sql);
		
		//예약 내역 표시
		out.println("<h2>접종예약 확인/수정 페이지</h2>");
		out.println("<h3>백신 접종 예약 내역</h3>");
		
	%>
		<table class="table">
		<thread>
			<tr>
				<th>예약 번호</th>
				<th>날짜</th>
				<th>병원</th>
				<th>백신</th>
			</tr>
		</thread>
		<tbody>
	<%	
		
		while(rs.next()) {

			reserved = true;
			String r_number = rs.getString(1);
			java.sql.Date date = rs.getDate(2);
			String hospital = rs.getString(3);
			String vaccine = rs.getString(4);
			
			java.util.Date rDate = new java.util.Date(date.getTime());
			
			out.println("<tr>");
			out.println("<td>" + r_number + "</td>");
			out.println("<td>" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(rDate) + "</td>");
			out.println("<td>" + hospital + "</td>");
			out.println("<td>" + vaccine + "</td>");
			out.println("</tr>");
		}
	%>
	</tbody>
	</table>
	<%
		
		if(reserved){
		%>
			<input type="button" class="btn btn-default" onClick="location.href='MainPage.jsp'" value="돌아가기">
			<input type="button" class="btn btn-default" onclick="location.href='ReservationRemoveDB.jsp'" value="예약 취소">
		<%
		}
		
		if(!reserved){
			//접종 횟수 구하기
			int inject_cnt = 0;
			
			sql = "SELECT inject_cnt FROM CONFIRMATION WHERE UNUMBER = ?";
			ps = conn.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			ps.setString(1, unumber); 
			rs = ps.executeQuery();
			
			//접종 횟수 확인하기
			if(!rs.next()) {
				inject_cnt = 1;
			}
			else {
				rs.beforeFirst();

				while(rs.next()) {
					inject_cnt = rs.getInt(1) + 1;
				}
			}
			
			ps.close();
			rs.close();
			
			if(inject_cnt >= 3) {
				out.println("<h5>백신 2회 접종을 모두 진행하였습니다.</h5>");
				out.println("<input type=\"button\" class=\"btn btn-default\" onClick=\"location.href='MainPage.jsp'\" value=\"돌아가기\">");
			}
			else {
	%>
				<div class="container">
				<div class="col-lg-4"></div>
				<div class="col-lg-4">
					<div class="jumbotron" style="text-align:center; padding-top: 20px;">
						<form action="./ReservationAdd.jsp" method = "post">
							<h3 style="text-align: center;">예약 추가</h3>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="Hospital name" id="hname" name="hname" size="15">
							</div>
							<div class="form-group">
								<input type = "date" class="form-control" placeholder="2021-12-01" min = "2021-12-01" id = "rdate" name = "rdate">
							</div>
							<input type="button" class="btn btn-default" onClick="location.href='MainPage.jsp'" value="돌아가기">
							<input type="reset" class="btn btn-default" value="리셋">
							<input type="submit" class="btn btn-default" value="시간선택">
						</form>
				</div>
			</div>
	<%
			}
		}

		conn.close();
		System.out.println("Connection closed");
	%>

</body>
</html>