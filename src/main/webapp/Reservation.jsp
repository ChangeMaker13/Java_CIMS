<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "Connection.ConnectionManager" %>
<%@ page import = "java.text.SimpleDateFormat" %>
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
		out.println("<h1>�������� Ȯ��/���� ������</h1>");
		out.println("<h2>��� ���� ���� ����</h2>");
		while(rs.next()) {
			reserved = true;
			String r_number = rs.getString(1);
			java.sql.Date date = rs.getDate(2);
			String hospital = rs.getString(3);
			String vaccine = rs.getString(4);
			
			java.util.Date rDate = new java.util.Date(date.getTime());

			out.println("<h3>Reservation number : " + r_number + "</h3>");
			out.println("<h3>Date : " + new SimpleDateFormat("yyyy-MM-dd").format(rDate) + "</h3>");
			out.println("<h3>Hospital : " + hospital + "</h3>");
			out.println("<h3>Vaccine : " + vaccine + "</h3>");
		}
		
		if(reserved){
		%>
			<button type="button" onclick="location.href='ReservationRemoveDB.jsp'">���� ���</button>
		<%
		}

		conn.close();
		System.out.println("Connection closed");
		
		out.println("<h2>------------------------------------</h2>");
		
		if(!reserved){
			out.println("�����ϱ�");
	%>
			<form action="./ReservationAdd.jsp" method = "post">
				<div>Hospital Name : <input type="text" id="hname" name="hname" size="15"></div>
				<div>Date : <input type = "date" min = "2021-12-01" id = "rdate" name = "rdate"></div>
				<button type = "reset">�ٽ��Է�</button>
				<button type = "submit">�����ϱ�</button>
			</form>
	<%
		}
	%>
</body>
</html>