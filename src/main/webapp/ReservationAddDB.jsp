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
		conn.setAutoCommit(false);
		
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
		

		String hname = request.getParameter("hname");
		String date = request.getParameter("selectTime");

		String hnumber = "";
		String vnumber = "";
		String rnumber = "";
		int inject_cnt = 2;
		
		//hnumber 구하기
		sql = "SELECT Hnumber FROM HOSPITAL WHERE Name = ?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, hname);
		
		rs = ps.executeQuery();
		while(rs.next()){
			hnumber = rs.getString(1);
		}
		
		ps.close();
		rs.close();
		
		//가장 유통기한이 임박한 백신 조회
		sql = "SELECT V.VNUMBER FROM VACCINE V "
					+ "WHERE V.Hnumber = ? "
					+ "AND V.Expiration_date <= ALL(SELECT Expiration_date FROM VACCINE NV "
					+ "                            WHERE NV.Hnumber = ? "
					+ "                            AND NOT EXISTS (SELECT * FROM RESERVATION NR WHERE NR.Vnumber = NV.Vnumber)) "
					+ "AND NOT EXISTS (SELECT * FROM RESERVATION R WHERE R.Vnumber = V.Vnumber)";
		ps = conn.prepareStatement(sql);
		ps.setString(1, hnumber); 
		ps.setString(2, hnumber); 
		rs = ps.executeQuery();
		
		while(rs.next()) {
			vnumber = rs.getString(1);
		}
		
		//Rnumber 생성하기
		int y = Integer.parseInt(date.substring(2, 4));
		int m = Integer.parseInt(date.substring(5, 7));
		int d = Integer.parseInt(date.substring(8, 10));
		
		rnumber += String.format("%d%d%d", y,m,d);
		rnumber += vnumber.substring(1);
		
		//insert
		sql = "INSERT INTO RESERVATION VALUES(TO_DATE(?, 'yyyy-mm-dd hh24:mi:ss'),?,?,?,?,?)";
		ps = conn.prepareStatement(sql);
		ps.setString(1, date);
		ps.setString(2, hnumber);
		ps.setString(3, rnumber);
		ps.setInt(4, inject_cnt);
		ps.setString(5, unumber);
		ps.setString(6, vnumber);
		
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
		
		response.sendRedirect("./Reservation.jsp");
	%>
</body>
</html>