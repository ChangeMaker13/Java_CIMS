<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>���Ժ� �湮�� �� Ȯ��</h2>
	<h3>���� �̸��� �Է��ϼ���.</h3>
	<form action="./VisitorDB.jsp" method = "post">
		<div>���Ը� : <input type="text" id="shop" name="shop" size="20"></div>
		<button type = "reset">�ٽ��Է�</button>
		<button type = "submit">�˻��ϱ�</button>
	</form>
	<input type="button" onclick="location.href='./MainPage.jsp'" value = "����������"/>
</body>
</html>