<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>
<style type="text/css">
#test{
	border-radius: 5px 5px 5px 5px;
	background: #F87061;
	width: 200px;
	height : 30px;
	color: white;
	cursor: pointer;
}

</style>
</head>
<body>

<h1> kakaoPay test </h1>
 <%@ include file="/WEB-INF/views/header.jsp"%>

<div align="center" style="margin:50px;" >
<form action="/main_pay_first.do" method="post">
	<p><input type="checkbox" name="bread" style="width:50px;" >bread 10개</p>
	<p><input type="checkbox" name="bread" style="width:50px;" >bread 20개</p>
	<p><input type="checkbox" name="bread" style="width:50px;" >bread 30개</p>
	<p><input type="checkbox" name="bread" style="width:50px;" >bread 40개</p>
	<p><input type="checkbox" name="bread" style="width:50px;" >bread 50개</p>
	
	<br/>
    <input type="submit" value="카카오페이 결제하기" id="test"/>
</form>
</div>
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>