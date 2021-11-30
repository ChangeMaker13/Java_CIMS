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
		
		//���Ը� ��������
		String shop = request.getParameter("shop");
		
		//���� �����ϱ�
		String sql = "SELECT name, current_visitor FROM SHOP WHERE NAME = '" + shop + "'";

		PreparedStatement stmt = conn.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ResultSet rs = stmt.executeQuery(sql);
		
		//���� ���� ǥ��
		out.println("<h2>���Ժ� �湮�� �� Ȯ��</h2>");
		out.println("<h3>�˻� ���</h3>");
		
		if(!rs.next()) {
			out.print("<h4>��ϵ��� ���� ���� Ȥ�� �߸��� �̸��Դϴ�.</h4>");
			
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
					<th>���Ը�</th>
					<th>�湮�� ��</th>
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
<input type="button" class="btn btn-default" onClick="history.go(-1);" value="���ư���">
</body>
</html>