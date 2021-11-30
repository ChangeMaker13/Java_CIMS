<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "Connection.ConnectionManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		Connection conn = ConnectionManager.getConn();
		String id = (String)session.getAttribute("id");
		
		//���� ������ȯ ���� ��������
		String sql = "SELECT Disease, C.Unumber FROM CLIENT C, UNDERLYING_DISEASE U WHERE U.Unumber = C.Unumber AND C.User_id = ? FOR UPDATE WAIT 5";
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);

		ResultSet rs = ps.executeQuery();
		
		//������ȯ ���� ǥ���ϱ�
		out.println("<h1>������ȯ �߰�/���� ������</h1>");
		out.println("<h2>���� ������ȯ ��Ȳ</h2>");

		out.println("<ul>");
		while(rs.next()){
			String disease = rs.getString(1);
			String unumber = rs.getString(2);
			String link = "'./DiseaseRemoveDB.jsp?unumber=" + unumber + "&disease=" + disease + "'";
	%>
			<li>
			<%= disease %>
			<button type="button" onclick="location.href=<%= link %> ">����</button>
			</li>
	<%
		}
		out.println("</ul>");

		System.out.println("Connection closed");
		conn.close();
	%>
	<h1>-------------------------------------</h1>
	<h2>���� ��ȯ �߰��ϱ�</h2>
	<form action="./DiseaseAddDB.jsp" method = "post">
		<div>Disease : <input type="text" id="disease" name="disease" size="15"></div>
		<button type = "reset">Reset</button>
		<button type = "submit">Submit</button>
	</form>
	<input type="button" onclick="location.href='./MainPage.jsp'" value = "����������"/>
</body>
</html>