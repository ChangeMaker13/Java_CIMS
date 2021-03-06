<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "Connection.ConnectionManager" %>
<%@ page import = "Query.ClientQuery" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>This is Disease add page</h1>
	<%
		//변수 세팅하기
		Connection conn = ConnectionManager.getConn();
		conn.setAutoCommit(false);
		
		String id = (String)session.getAttribute("id");
		String disease = request.getParameter("disease");
		String unumber = ClientQuery.getUnumber(conn, id);
		
		//insert 쿼리 수행
		String sql = "INSERT INTO UNDERLYING_DISEASE VALUES(?, ?)";

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, unumber);
		ps.setString(2, disease);
		
		int result = ps.executeUpdate();
		if(result != 0)
			System.out.println("Successfully inserted.");
		else
			System.out.println("error occured when inserting disease data.");
		
		//commit후 close
		conn.commit();
		
		System.out.println("Connection closed");
		conn.close();
		ps.close();

    	response.sendRedirect("./DiseaseAdd.jsp");
	%>
</body>
</html>