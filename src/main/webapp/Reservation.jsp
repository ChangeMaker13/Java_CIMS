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
				<li><a href="./DiseaseAdd.jsp">������ȯ</a></li>
				<li><a href="./Reservation.jsp">����Ȯ��</a></li>
				<li><a href="./Confirmation.jsp">Ȯ����</a></li>
				<li><a href="./Visitor.jsp">���Ժ� �湮��</a></li>
				<li><a href="./VisitLog.jsp">�湮���</a></li>
			</ul>
		</div>
	</nav>
	<%
		Connection conn = ConnectionManager.getConn();
		String id = (String)session.getAttribute("id");
		String unumber = "";
		Boolean reserved = false;
		
		//unumber ���ϱ�
		String sql = "SELECT unumber FROM CLIENT WHERE User_id = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			unumber = rs.getString(1);
		}
		
		ps.close();
		rs.close();
		
		//���� ��ȸ
		sql = "SELECT r.Rnumber, r.Rdate, h.Name, v.Name\n"
		+ "FROM RESERVATION r, HOSPITAL h, CLIENT c, VACCINE v\n"
		+ "WHERE c.Unumber = r.Unumber\n"
		+ "AND r.Hnumber = h.Hnumber\n"
		+ "AND r.Vnumber = v.Vnumber\n"
		+ "AND c.Unumber = '" + unumber +"'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery(sql);
		
		//���� ���� ǥ��
		out.println("<h2>�������� Ȯ��/���� ������</h2>");
		out.println("<h3>��� ���� ���� ����</h3>");
		
	%>
		<table class="table">
		<thread>
			<tr>
				<th>���� ��ȣ</th>
				<th>��¥</th>
				<th>����</th>
				<th>���</th>
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
			<input type="button" class="btn btn-default" onClick="location.href='MainPage.jsp'" value="���ư���">
			<input type="button" class="btn btn-default" onclick="location.href='ReservationRemoveDB.jsp'" value="���� ���">
		<%
		}
		
		if(!reserved){
			//���� Ƚ�� ���ϱ�
			int inject_cnt = 0;
			
			sql = "SELECT inject_cnt FROM CONFIRMATION WHERE UNUMBER = ?";
			ps = conn.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			ps.setString(1, unumber); 
			rs = ps.executeQuery();
			
			//���� Ƚ�� Ȯ���ϱ�
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
				out.println("<h5>��� 2ȸ ������ ��� �����Ͽ����ϴ�.</h5>");
				out.println("<input type=\"button\" class=\"btn btn-default\" onClick=\"location.href='MainPage.jsp'\" value=\"���ư���\">");
			}
			else {
	%>
				<div class="container">
				<div class="col-lg-4"></div>
				<div class="col-lg-4">
					<div class="jumbotron" style="text-align:center; padding-top: 20px;">
						<form action="./ReservationAdd.jsp" method = "post">
							<h3 style="text-align: center;">���� �߰�</h3>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="Hospital name" id="hname" name="hname" size="15">
							</div>
							<div class="form-group">
								<input type = "date" class="form-control" placeholder="2021-12-01" min = "2021-12-01" id = "rdate" name = "rdate">
							</div>
							<input type="button" class="btn btn-default" onClick="location.href='MainPage.jsp'" value="���ư���">
							<input type="reset" class="btn btn-default" value="����">
							<input type="submit" class="btn btn-default" value="�ð�����">
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