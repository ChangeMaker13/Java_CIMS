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
	<h1>Checking ID/Password...</h1>
	<%
		Connection conn = ConnectionManager.getConn();
		
		//id, password 가져오기
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		//쿼리 구성하기
		String sql = "SELECT * FROM CLIENT WHERE USER_ID = ? AND Passwd = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		ps.setString(2, password);
		
		//쿼리 수행후 결과 확인
		ResultSet rs = ps.executeQuery();
		
		if(!rs.next()) {
			out.print("<h2>존재하지 않는 ID 혹은 password 입니다.</h2>");
			ps.close();
			rs.close();
		
			conn.close();
			System.out.println("Connection closed");
			%>
			<script>
			  setTimeout(function() {
			      document.location = "./LoginPage.jsp";
			  }, 3000);
			</script>
			<%
		}
		else {
			String name = rs.getString(1);
			session.setAttribute("id", id);
			ps.close();
			rs.close();
		
			conn.close();
			System.out.println("Connection closed");
	    	response.sendRedirect("./MainPage.jsp");
		}

	%>
</body>
</html>