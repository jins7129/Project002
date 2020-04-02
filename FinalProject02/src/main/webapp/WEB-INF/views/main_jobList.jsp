<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모아보기</title>
<style type="text/css">
.wrapper {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  width : 600px;
}

</style>
</head>
<body>
<!-- header -->
	<%@ include file="/WEB-INF/views/header.jsp"%>

	<h1>모아보기</h1>
	<div class="wrapper">
		<c:forEach items="${list}" var="JobDto">
			<div style=" border: 3px solid orange; border-radius: 20px 20px 20px 20px; margin : 5px;" onclick="location.href='main_jobDetail.do?jobSeq=${JobDto.jobSeq}'">
				<span>${JobDto.jobSeq}</span>
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