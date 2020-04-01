<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>

<link rel="icon" href="#">
<link
	href="https://fonts.googleapis.com/css?family=Fira+Sans:300&display=swap"
	rel="stylesheet">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="icon" type="image/png"
	href="<c:url value = '/resources/Login/images/icons/favicon.ico'/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value = '/resources/Login/vendor/bootstrap/css/bootstrap.min.css'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value = '/resources/Login/fonts/font-awesome-4.7.0/css/font-awesome.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value = '/resources/Login/fonts/Linearicons-Free-v1.0.0/icon-font.min.css'/>"> --%>
<link rel="stylesheet" type="text/css"
	href="<c:url value = '/resources/Login/vendor/animate/animate.css'/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value = '/resources/Login/vendor/css-hamburgers/hamburgers.min.css'/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value = '/resources/Login/vendor/animsition/css/animsition.min.css'/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value = '/resources/Login/vendor/select2/select2.min.css'/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value = '/resources/Login/vendor/daterangepicker/daterangepicker.css'/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value = '/resources/Login/css/util.css'/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value = '/resources/Login/css/main.css'/>">

<script
	src="<c:url value = '/resources/Login/vendor/animsition/js/animsition.min.js'/>"></script>
<script
	src="<c:url value = '/resources/Login/vendor/bootstrap/js/popper.js'/>"></script>
<script
	src="<c:url value = '/resources/Login/vendor/bootstrap/js/bootstrap.min.js'/>"></script>
<script
	src="<c:url value = '/resources/Login/vendor/select2/select2.min.js'/>"></script>
<script
	src="<c:url value = '/resources/Login/vendor/daterangepicker/moment.min.js'/>"></script>
<script
	src="<c:url value = '/resources/Login/vendor/daterangepicker/daterangepicker.js'/>"></script>
<script
	src="<c:url value = '/resources/Login/vendor/countdowntime/countdowntime.js'/>"></script>
<script src="<c:url value = '/resources/Login/js/main.js'/>"></script>
<script type="text/javascript">
	$(function() {
		$("#loginChk").hide();
	});

	function login() {
		var userId = $("#userId").val().trim();
		var userPw = $("#userPw").val().trim();

		console.log(userId + "/" + userPw);

		var loginVal = {
			"userId" : userId,
			"userPw" : userPw
		}; // 자바스크립트 객체(오브젝트)

		if (userId == null || userId == "" || userPw == "" || userPw == null) {
			alert("아이디 및 패스워드를 확인해주세요");
		} else {
			$.ajax({
				type : "post",
				url : "loginajax.do",
				data : JSON.stringify(loginVal),
				contentType : "application/json", // unsupport mediaType 오류가 남, 기본이 text/html 타입이기 때문에
				dataType : "json", // 명시해줘야함
				success : function(msg) {
					if (msg.check == true) {
						location.href = 'main.do';
					} else {
						$("#loginChk").show();
					}
				},
				error : function() {
					alert("통신 실패");
				}
			});

		}

	}
</script>
</head>
<body>


	<!-- login * join을 ajax로 불러오는 부분 -->
	<div class="limiter" style="background-color: #F7F7F7;">
		<div>
			<input type="button" onclick="back();" id="back"
				style="background-color: #F7F7F7;" value="Back" />
		</div>
		<div class="container-login100">
			<div class="wrap-login100">
				<form class="login100-form validate-form" method="post"
					action="main.do">
					<span class="login100-form-title p-b-43"> Login </span>


					<div class="wrap-input100 validate-input"
						data-validate="Valid email is required: ex@abc.xyz">
						<input class="input100" id="userId" type="text" name="userId">
						<span class="focus-input100"></span> <span class="label-input100">User
							ID</span>
					</div>


					<div class="wrap-input100 validate-input"
						data-validate="Password is required">
						<input class="input100" id="userPw" type="password" name="userPw">
						<span class="focus-input100"></span> <span class="label-input100">Password</span>
					</div>

					<div class="flex-sb-m w-full p-t-3 p-b-32">
						<!-- <div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox"
								name="remember-me"> <label class="label-checkbox100"
								for="ckb1"> Remember me </label>
						</div> -->

						<div id="loginChk">
							<div id="loginChk">아이디 혹은 비밀번호가 잘못되었습니다.</div>
							<hr/>
							<a href="#">비밀번호 찾기</a>
						</div>
					</div>


					<div class="container-login100-form-btn">
						<input type="button" value="Login" class="login100-form-btn"
							onclick="login();" />
					</div>

					<div class="text-center p-t-46 p-b-20">
						<span class="txt2"> or sign up using </span>
					</div>

					<div class="login100-form-social flex-c-m">
						<a href="#" class="login100-form-social-item flex-c-m bg1 m-r-5">
							<!-- <i class="fa fa-facebook-f" aria-hidden="true"></i> --> <img
							id="google"
							src="<c:url value = '/resources/Login/images/icons/1200px-Google__G__Logo.svg.png'/>" />
						</a> <a href="#" class="login100-form-social-item flex-c-m bg2 m-r-5">
							<!-- <i class="fa fa-google" aria-hidden="true"></i> --> <img
							id="kakao"
							src="<c:url value = '/resources/Login/images/icons/kakaolink_btn_medium.png'/>" />
						</a>
					</div>
				</form>

				<!-- <div class="login100-more"></div> -->
				<%-- 				<div class="login100-more"
					style="background-image: url('<c:url value = '/resources/Login/images/kevin-bhagat-zNRITe8NPqY-unsplash.jpg'/>');"></div> --%>
			</div>
		</div>
	</div>

</body>
</html>