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

<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="1086121226988-79i2g3qsvsr85hmu6kh2i5jkelnofqrm.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<link href="https://fonts.googleapis.com/css?family=Fira+Sans:300&display=swap" rel="stylesheet">
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
						//window.location.reload();
						history.go(0);			// 페이지 새로고침 
						back();
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
	
	// 카카오 로그인
	function kakaoLogin() {
        Kakao.init('cf755a94afb6a149564276600dcd27ed');
        
         // 카카오 로그인 버튼을 생성합니다.
         Kakao.Auth.loginForm({
         	success: function(authObj) {
            	Kakao.API.request({
                	url: '/v2/user/me',
                    success: function(res) {
                    	console.log(res);
                                
                        var userID = res.id;      //유저의 카카오톡 고유 id
                        var userEmail = res.kakao_account.email;   //유저의 이메일
                        
                        document.getElementById('userId').value = userEmail;
                        document.getElementById('userPw').value = userID;
                        
                        login();	// 이메일 아이디 중복검사 ajax
                                
                        Kakao.Auth.logout();
                                
                        },
                        fail: function(error) {
                        alert(JSON.stringify(error));
                        }
                    });
                          
                    },
                    fail: function(err) {
                    	alert(JSON.stringify(err));
                    }
		});
	}
	
	function onSignIn(googleUser) {
		// 정보
		var profile = googleUser.getBasicProfile();
		// 이메일
		document.getElementById('userId').value = profile.getEmail();
		// 아이디 코드
		document.getElementById('userPw').value = profile.getId();

		// 비동기로 이메일과 아이디코드를 확인하고 정보 넘기기
	 	login();
		
		// ??
		var id_token = googleUser.getAuthResponse().id_token;

		// 로그아웃
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.disconnect();
	}
</script>
<style type="text/css">
.back{
	display: -moz-box;
	display: -ms-flexbox;
	justify-content: center;
	align-items: center;
	padding: 0 20px;
	margin: 10px;
	width: 80px;
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

.back:hover{
	background: black;
}
#kakao:hover{
	cursor: pointer;
}
</style>
</head>
<body>


	<!-- login * join을 ajax로 불러오는 부분 -->
	<div class="limiter" style="background-color: #F7F7F7;">
		<div>
			<input type="button" onclick="back();" id="back" class="back" value="Back" />
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
						<a data-theme="dark" data-onsuccess="onSignIn" class="login100-form-social-item flex-c-m bg1 m-r-5 g-signin2">
							<img id="google" src="<c:url value = '/resources/Login/images/icons/1200px-Google__G__Logo.svg.png'/>" />
						</a> <a onclick="kakaoLogin();" class="login100-form-social-item flex-c-m bg2 m-r-5">
							<img id="kakao" src="<c:url value = '/resources/Login/images/icons/kakaolink_btn_medium.png'/>" />
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>