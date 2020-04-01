<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>

	<!-- header -->
	<%@ include file="/WEB-INF/views/header.jsp"%>
<style>
input[type=button], input[type=submit]{
	display: -moz-box;
	display: -ms-flexbox;
	justify-content: center;
	align-items: center;
	padding: 0 20px;
	width: 100px;
	height: 35px;
	border-radius: 10px;
	background: rgb(248, 112, 97);
	cursor: pointer;
	/* font-family: Montserrat-Bold; */
	font-size: 15px;
	color: #fff;
	line-height: 1.1;
	text-transform: uppercase;
	letter-spacing: 1px;
	-webkit-transition: all 0.4s;
	-o-transition: all 0.4s;
	-moz-transition: all 0.4s;
	transition: all 0.4s;
	float: none;
}

input[type=button]:hover, input[type=submit]:hover{
	background: black;
}

input[type=text], input[type=password]{
	border-radius: 10px;
	border:1px solid black;
	width: 300px;
	height: 40px;
	}
	
	input[type=date]{
	all: unset;
	border-radius: 10px;
	}
</style>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.js"></script>
<script type="text/javascript">
   $(function() {
     $('#summernote').summernote({
       height: 300,
       //lang: 'ko-KR' // 언어 세팅
     });
   });
</script>
</head>
<body>

	<div align="center">
		<br>
		<h1>Request</h1><br><br>
		<form action="insertRes.do" method="post">
			<input type="hidden" name="userId" value="">
			
			<label>제목 : </label> 
				<input type="text" placeholder="please insert title" name="jobTitle" value="" style="width: 550px"><br><br>
			
			<label>보상 : </label> 
				<input type="text" placeholder="please insert pay" name="jobReward" value="" style="width: 15	0px"><br><br>
			
			<label>기간 : </label> 
				<input type="date" name="jobStart" value="" style="border: 1px solid black;	"> ~
				<input type="date" name="jobDone" value="" style="border: 1px solid black;"><br><br>
			
			<label>위치 : </label>
			<input type="text" placeholder="please insert address" name="jobAddr"><br><br>
			
			<label>내용 : </label>
			<textarea id="summernote" name="editordata"></textarea>
			<br><br>
	
			<input type="submit" value="작성하기">
			<input type="button" value="돌아가기" onclick="location.href='main.do';">
		</form>

	</div>
		 	<div id = "footer"><%@ include file="/WEB-INF/views/footer.jsp" %></div>
</body>
</html>