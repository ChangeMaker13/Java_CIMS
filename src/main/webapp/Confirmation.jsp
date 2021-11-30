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
<style>
td {
	text-align: center;
}
</style>
</head>
<body>
<%
		Connection conn = ConnectionManager.getConn();
		String id = (String)session.getAttribute("id");
		String unumber = "";
		Boolean reserved = false;
		
		//unumber 구하기
		String sql = "SELECT unumber FROM CLIENT WHERE User_id = ?";
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			unumber = rs.getString(1);
		}
		
		ps.close();
		rs.close();
		
		out.println("<h2>확인증 조회</h2>");
		out.println("<h3>백신 접종 확인증 확인</h3>");
		
		sql = "SELECT c.Name, f.Cnumber, f.Inject_cnt, f.Inject_date\n"
				+ "FROM CLIENT c, CONFIRMATION f\n"
				+ "WHERE c.Unumber = f.Unumber\n"
				+ "AND c.Unumber = '" + unumber +"'";
		PreparedStatement stmt = conn.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		rs = stmt.executeQuery(sql);
		
		if(!rs.next()) {
			out.println("<h4>백신 접종 기록이 없습니다.</h4>");
		} 
		else {
			rs.beforeFirst();
			
			out.println("<table border=\"1;\">");
			out.println("<th>이름</th>");
			out.println("<th>확인증 번호</th>");
			out.println("<th>접종 횟수</th>");
			out.println("<th>접종 일자</th>");
			
			while(rs.next()) {
				out.println("<tr>");
				out.println("<td>"+rs.getString(1)+"</td>");
				out.println("<td>"+rs.getString(2)+"</td>");
				out.println("<td>"+rs.getString(3)+"</td>");
				
				java.sql.Date date = rs.getDate(4);
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
<button onClick="history.go(-1);">돌아가기</button>
</body>
</html>