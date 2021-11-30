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
		
		//현재 기저질환 정보 가져오기
		String sql = "SELECT Disease, C.Unumber FROM CLIENT C, UNDERLYING_DISEASE U WHERE U.Unumber = C.Unumber AND C.User_id = ? FOR UPDATE WAIT 5";
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);

		ResultSet rs = ps.executeQuery();
		
		//기저질환 정보 표시하기
		out.println("<h1>기저질환 추가/삭제 페이지</h1>");
		out.println("<h2>현재 기저질환 현황</h2>");

		out.println("<ul>");
		while(rs.next()){
			String disease = rs.getString(1);
			String unumber = rs.getString(2);
			String link = "'./DiseaseRemoveDB.jsp?unumber=" + unumber + "&disease=" + disease + "'";
	%>
			<li>
			<%= disease %>
			<button type="button" onclick="location.href=<%= link %> ">삭제</button>
			</li>
	<%
		}
		out.println("</ul>");

		System.out.println("Connection closed");
		conn.close();
	%>
	<h1>-------------------------------------</h1>
	<h2>기저 질환 추가하기</h2>
	<form action="./DiseaseAddDB.jsp" method = "post">
		<div>Disease : <input type="text" id="disease" name="disease" size="15"></div>
		<button type = "reset">Reset</button>
		<button type = "submit">Submit</button>
	</form>
	<input type="button" onclick="location.href='./MainPage.jsp'" value = "메인페이지"/>
</body>
</html>