<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Calendar" %>
<%@ page import = "Connection.ConnectionManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>��� ���� ���� ������</h1>
	<%
		//���� ����
		Connection conn = ConnectionManager.getConn();
		String hname = request.getParameter("hname");
		String date = request.getParameter("rdate");
		
		//���� ���ɽð� ��ȸ
		
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
		out.println("<h2>�ð��� �����ϼ���.</h2>");
		out.println("<h3>���� : " + hname + ", �ð� : " + date + "</h3>");
	%>	
		<form method=post action="ReservationAddDB.jsp">
		<select name="selectTime">
	<%
		for(int i = 0; i < rTime.size(); i++) {
			out.println("<option value=\"" + date + " " + rTime.get(i) + "\">" + rTime.get(i) + "</option>");
		}
		out.println("</select>");
		
		out.println("<input type=\"hidden\" id=\"hname\" name=\"hname\" value=\"" + hname + "\">");
	%>
		<button onClick="history.go(-1);">���ư���</button>
		<button type = "reset">�ٽ��Է�</button>
		<button type = "submit">�����ϱ�</button>
		</form>
	<%	
		rs.close();
		conn.close();
		System.out.println("Connection closed");
	%>
</body>
</html>