<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "Connection.ConnectionManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
td {
	text-align: center;
}
</style>
</head>
<body>
<%
		Connection conn = ConnectionManager.getConn();
		
		//���Ը� ��������
		String shop = request.getParameter("shop");
		
		//���� �����ϱ�
		String sql = "SELECT S.NAME AS SHOP_NAME, COUNT(*) AS VISITOR\n"
					+ "FROM SHOP S, CLIENT C, VISIT_LOG V\n"
					+ "WHERE V.SNUMBER = S.SNUMBER AND V.UNUMBER = C.UNUMBER\n"
					+ "AND S.NAME = '" + shop + "'\n"
					+ "GROUP BY S.NAME";

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
			
			out.println("<table border=\"1;\">");
			out.println("<th>���Ը�</th>");
			out.println("<th>�湮�� ��</th>");
			
			while(rs.next()) {
				out.println("<tr>");
				out.println("<td>"+rs.getString(1)+"</td>");
				out.println("<td>"+rs.getInt(2)+"</td>");
				out.println("</tr>");
			}

			out.println("</table>");

			rs.close();
			conn.close();
			System.out.println("Connection closed");
		}
%>
<button onClick="history.go(-1);">���ư���</button>
<button onclick="location.href='MainPage.jsp'">���θ޴�</button >
</body>
</html>