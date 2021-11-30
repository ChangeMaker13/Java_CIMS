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
		
		out.println("<h2>���� �湮 ��� Ȯ��</h2>");
		out.println("<h3>�˻� ���</h3>");
		
		sql = "SELECT c.Name, s.Name, v.Visit_time\n"
				+ "FROM VISIT_LOG v, CLIENT c, SHOP s\n"
				+ "WHERE v.Unumber = c.Unumber\n"
				+ "AND v.Snumber = s.Snumber\n"
				+ "AND c.Unumber ='" + unumber +"'";
		
		PreparedStatement stmt = conn.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		rs = stmt.executeQuery(sql);
		
		if(!rs.next()) {
			out.println("<h4>�湮 ����� �����ϴ�.</h4>");
		} 
		else {
			rs.beforeFirst();
			
			out.println("<table border=\"1;\">");
			out.println("<th>�̸�</th>");
			out.println("<th>����</th>");
			out.println("<th>�湮 �ð�</th>");
			
			while(rs.next()) {
				out.println("<tr>");
				out.println("<td>"+rs.getString(1)+"</td>");
				out.println("<td>"+rs.getString(2)+"</td>");
				
				java.sql.Date date = rs.getDate(3);
				java.util.Date rDate = new java.util.Date(date.getTime());
				out.println("<td>"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(rDate)+"</td>");
				out.println("</tr>");
			}
			out.println("</table>");
		}
		

		rs.close();
		conn.close();
		System.out.println("Connection closed");
%>
<button onClick="history.go(-1);">���ư���</button>

</body>
</html>