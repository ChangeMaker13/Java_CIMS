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
		
		out.println("<h2>Ȯ���� ��ȸ</h2>");
		out.println("<h3>��� ���� Ȯ���� Ȯ��</h3>");
		
		sql = "SELECT c.Name, f.Cnumber, f.Inject_cnt, f.Inject_date\n"
				+ "FROM CLIENT c, CONFIRMATION f\n"
				+ "WHERE c.Unumber = f.Unumber\n"
				+ "AND c.Unumber = '" + unumber +"'";
		PreparedStatement stmt = conn.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		rs = stmt.executeQuery(sql);
		
		if(!rs.next()) {
			out.println("<h4>��� ���� ����� �����ϴ�.</h4>");
		} 
		else {
			rs.beforeFirst();
			
	%>		
			<table class="table">
			<thread>
				<tr>
					<th>�̸�</th>
					<th>Ȯ���� ��ȣ</th>
					<th>���� Ƚ��</th>
					<th>���� ����</th>
				</tr>
			</thread>
			<tbody>
	<%		
			while(rs.next()) {
				out.println("<tr>");
				out.println("<td>"+rs.getString(1)+"</td>");
				out.println("<td>"+rs.getString(2)+"</td>");
				out.println("<td>"+rs.getString(3)+"</td>");
				
				java.sql.Date date = rs.getDate(4);
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
<input type="button" class="btn btn-default" onClick="location.href='MainPage.jsp'" value="���ư���">
</body>
</html>