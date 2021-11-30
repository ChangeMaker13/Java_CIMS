<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "Connection.ConnectionManager" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>COVID19 integrated Management System</title>
</head>
<body>
<%
		Connection conn = ConnectionManager.getConn();
		
		//가게명 가져오기
		String shop = request.getParameter("shop");
		
		//쿼리 구성하기
		String sql = "SELECT S.NAME AS SHOP_NAME, COUNT(*) AS VISITOR\n"
					+ "FROM SHOP S, CLIENT C, VISIT_LOG V\n"
					+ "WHERE V.SNUMBER = S.SNUMBER AND V.UNUMBER = C.UNUMBER\n"
					+ "AND S.NAME = '" + shop + "'\n"
					+ "GROUP BY S.NAME";

		PreparedStatement stmt = conn.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ResultSet rs = stmt.executeQuery(sql);
		
		//예약 내역 표시
		out.println("<h2>가게별 방문자 수 확인</h2>");
		out.println("<h3>검색 결과</h3>");
		
		if(!rs.next()) {
			out.print("<h4>등록되지 않은 가게 혹은 잘못된 이름입니다.</h4>");
			
			rs.close();
			conn.close();
			System.out.println("Connection closed");
		}
		else {
			rs.beforeFirst();
		%>
			<table class="table">
			<thread>
				<tr>
					<th>가게명</th>
					<th>방문자 수</th>
				</tr>
			</thread>
		<tbody>
		<%
			
			while(rs.next()) {
				out.println("<tr>");
				out.println("<td>"+rs.getString(1)+"</td>");
				out.println("<td>"+rs.getInt(2)+"</td>");
				out.println("</tr>");
			}
			out.println("</tbody>");
			out.println("</table>");

			rs.close();
			conn.close();
			System.out.println("Connection closed");
		}
%>
<input type="button" class="btn btn-default" onClick="history.go(-1);" value="돌아가기">
</body>
</html>