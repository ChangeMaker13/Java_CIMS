<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>COVID19 integrated Management System</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<a class="navbar-brand" href="MainPage.jsp">CIMS</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="./DiseaseAdd.jsp">기저질환</a></li>
				<li><a href="./Reservation.jsp">예약확인</a></li>
				<li><a href="./Confirmation.jsp">확인증</a></li>
				<li><a href="./Visitor.jsp">가게별 방문자</a></li>
				<li><a href="./VisitLog.jsp">방문기록</a></li>
			</ul>
		</div>
	</nav>
	<h2>가게별 방문자 수 확인</h2>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="text-align:center; padding-top: 20px;">
				<form action="./VisitorDB.jsp" method = "post">
					<h4 style="text-align: center;">가게 명을 입력하세요</h4>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="shop name" id="shop" name="shop">
					</div>
						<input type="button" class="btn btn-default" onClick="location.href='MainPage.jsp'" value="돌아가기">
						<input type="reset" class="btn btn-default" value="리셋">
						<input type="submit" class="btn btn-default" value="검색">
				</form>
		</div>
	</div>
</body>
</html>