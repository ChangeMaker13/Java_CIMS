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
	<%
		//변수 세팅하기
		Connection conn = ConnectionManager.getConn();
		conn.setAutoCommit(false);
		
		String id = (String)session.getAttribute("id");
		String unumber = ClientQuery.getUnumber(conn, id);
		
		//delete 쿼리 수행
		String sql = "DELETE FROM RESERVATION WHERE unumber = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, unumber);
		
		int count = ps.executeUpdate();
		if(count == 0) {
			System.out.println("error occured when deleting data");
		}
		else {
			System.out.println("reservation data deleted");
		}

		//commit후 close
		conn.commit();

		conn.close();
		ps.close();
		System.out.println("Connection closed");
	
		response.sendRedirect("./Reservation.jsp");
	%>
</body>
</html>