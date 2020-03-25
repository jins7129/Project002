<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 메인 페이지</title>
</head>
<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div align="center" >
		<img src="resources/file/testFile.PNG" />
		<table>
			<tr>
				<td>이름 : </td>
				<td>${loginInfo.userName }</td>
			</tr>
			<tr>
				<td>아이디 : </td>
				<td>${loginInfo.userId }</td>
			</tr>
			<tr>
				<td>전화번호 </td>
				<td>${loginInfo.userPhone }</td>
			</tr>
			<tr>
				<td>주소 </td>
				<td>${loginInfo.userAddr }</td>
			</tr>

		</table>
	</div>
	<hr/>

	<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>