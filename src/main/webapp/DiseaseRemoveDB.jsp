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
		//변수 선언
		Connection conn = ConnectionManager.getConn();
		conn.setAutoCommit(false);
		
		String unumber = request.getParameter("unumber");
		String disease = request.getParameter("disease");
		
		//DELETE 쿼리 수행
		String sql = "DELETE FROM UNDERLYING_DISEASE\n"
				+ "WHERE Unumber = ? AND Disease = ?";

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, unumber);
		ps.setString(2, disease);
		
		int result = ps.executeUpdate();
		if(result != 0)
			System.out.println("Successfully deleted.");
		else
			System.out.println("error occured when deleting disease data.");
		
		conn.commit();
		
		System.out.println("Connection closed");
		conn.close();
		ps.close();
		
    	response.sendRedirect("./DiseaseAdd.jsp");
	%>
</body>
</html>