<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>가게별 방문자 수 확인</h2>
	<h3>가게 이름을 입력하세요.</h3>
	<form action="./VisitorDB.jsp" method = "post">
		<div>가게명 : <input type="text" id="shop" name="shop" size="20"></div>
		<button type = "reset">다시입력</button>
		<button type = "submit">검색하기</button>
	</form>
	<input type="button" onclick="location.href='./MainPage.jsp'" value = "메인페이지"/>
</body>
</html>