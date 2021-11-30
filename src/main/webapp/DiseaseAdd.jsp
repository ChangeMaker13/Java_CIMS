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
		
		//���� ������ȯ ���� ��������
		String sql = "SELECT Disease, C.Unumber FROM CLIENT C, UNDERLYING_DISEASE U WHERE U.Unumber = C.Unumber AND C.User_id = ?";
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);

		ResultSet rs = ps.executeQuery();
		
		//������ȯ ���� ǥ���ϱ�
		out.println("<h2>������ȯ �߰�/����</h2>");
		out.println("<h3>���� ���</h3>");
		
	%>
		<table class="table">
		<thread>
			<tr>
				<th>���� ��ȣ</th>
				<th>���� ��ȯ</th>
				<th>    </th>
			</tr>
		</thread>
		<tbody>
	<%
		while(rs.next()){
			String disease = rs.getString(1);
			String unumber = rs.getString(2);
			String link = "./DiseaseRemoveDB.jsp?unumber=" + unumber + "&disease=" + disease;
			out.println("<tr>");
			out.println("<td>" + unumber + "</td>");
			out.println("<td>" + disease + "</td>");
			out.println("<td><a href=\"" + link + "\">����</a></td>");
			out.println("</tr>");
		}
	%>
	</tbody>
	</table>
	<%

		System.out.println("Connection closed");
		conn.close();
	%>
	<br>
	<h3>���� ��ȯ �߰��ϱ�</h3>
	
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="text-align:center; padding-top: 20px;">
				<form action="./DiseaseAddDB.jsp" method = "post">
					<div class="form-group"><input type="text" class="form-control" placeholder="���� ��ȯ" id="disease" name="disease" size="15"></div>
					<input type="button" class="btn btn-default" onClick="location.href='MainPage.jsp'" value="���ư���">
					<input type="reset" class="btn btn-default" value="����">
					<input type="submit" class="btn btn-default" value="�߰�">
				</form>
		</div>
	</div>
</body>
</html>