<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모아보기</title>
<style type="text/css">
.wrapper {
	align-content : center;
	align-items :center;
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr 1fr 1fr;
	width: 1200px;
}

.wrapper>div {
	border: 1px solid rgb(248, 112, 97);
	margin : 5px;
	box-sizing : border-box;
	width : 200px;
	height : 180px;
	display: -moz-box;
	display: -ms-flexbox;
	justify-content: center;
	align-items: center;
	border-radius: 10px;
	cursor: pointer;
	/* font-family: Montserrat-Bold; */
	font-size: 15px;
	color: black;
	line-height: 1.1;
	text-transform: uppercase;
	letter-spacing: 1px;
	-webkit-transition: all 0.4s;
	-o-transition: all 0.4s;
	-moz-transition: all 0.4s;
	transition: all 0.4s;
	float: none;
}

.wrapper>div:hover {
	background-color: gray;
}
</style>
</head>
<body>
<!-- header -->
	<%@ include file="/WEB-INF/views/header.jsp"%>

	<h1>모아보기</h1>
	<div class="wrapper">
		<c:forEach items="${list}" var="JobDto">
			<div style=" " onclick="location.href='main_jobDetail.do?jobSeq=${JobDto.jobSeq}'">
				<span>${JobDto.jobTitle}</span>
				<span>${JobDto.userId}</span>
				<span>${JobDto.jobDate}</span>
				<span>${JobDto.jobView}</span>
			</div>
		</c:forEach>
	</div>



	<!-- footer -->
 	<div id = "footer"><%@ include file="/WEB-INF/views/footer.jsp" %></div>
</body>
</html>