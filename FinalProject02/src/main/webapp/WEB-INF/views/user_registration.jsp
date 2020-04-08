<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REGISTER</title>
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="1086121226988-79i2g3qsvsr85hmu6kh2i5jkelnofqrm.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="icon" href="resources/images/icon.png" type="image/x-icon">
<style>
.img_profile {
   width: 160px;
   height: 170px;
   border-radius: 150px;
   box-shadow: 5px 10px 30px 10px black;
   margin-left: 28%;
}

.inputBtn{
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

.inputBtn:hover{
	background: black;
}

.inputText{
	border-radius: 10px;
	border:1px solid black;
	width: 300px;
	height: 40px;
	}
</style>
<script type="text/javascript">

$(function() {
    $("#imgFile").change(function() {
    	alert($("#imgFile").val());
       if ($(this).val() == null || $(this).val().length == 0) {
          readURL(false, this);
       } else {
          readURL(true, this);
       }
    });
 });

function readURL(flag, input) {
    if (flag) {
       if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function(e) {
             $('#img_profile').attr('src', e.target.result);
          }
          reader.readAsDataURL(input.files[0]);
       }
    } 
 }

	//ID 유효성 검사
	function idChkConfirm() {
		if (idkChk == "N") {
			alert("아이디 중복체크를 먼저해주세요");
			$("#Email_id").focus();
		}
	}

	//ID 중복 검사
	var idkChk = "N"; //REGISTER에서 검사할 항목
	function idChked() {
		var doc = $("input[name=userId]").val();
		if (doc.trim() == "" || doc == null || doc == "undefined") {
			alert("아이디를 입력해주세요");
		} else {
			$.ajax({
				url : "idchk.do?id=" + $("#input[name=userId]").val(),
				type : "post",
				success : function(data) {
					if (data == true) {
						alert("이 아이디는 중복입니다.");
						idkChk = "N";
					} else {
						var res = confirm("이 아이디를 사용하실수 있습니다.");
						if (res == true) {
							$("#input[name=userId]").prop("disabled", true);
						}
						idkChk = "Y";
					}
				},
				error : function(err) {
					alert("기능 오류가 발생했습니다. 브라우저 콘솔을 확인해 주세요")
				}
			});
		}
	}

	//도로명주소 팝업 함수
	function openPop_juso() {
		var pop = window.open("jusoPopup.do", "juso",
				"width=570,height=420, scrollbars=yes, resizable=yes");
	}

	//도로명주소 팝업에서 서브밋했을 시 들어와야되는 함수
	function jusoCallBack(roadAddrPart1, addrDetail, zipNo) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		$("#registerAddr").val(roadAddrPart1);
		$("#registerAddr1").val(addrDetail + " " + zipNo);
	}

	//이메일 인증 SMTP
	var EmailCode = "";
	function verifyEmail() {
		$("#verifyBtn").prop("disabled", true);
		$.ajax({
			url : "sendMail.do?to=" + $("input[name=userId]").val(),
			type : "post",
			contentType : "application/json",
			dataType : 'json',
			success : function(data) {
				alert("인증코드가 발급되었습니다.");
				EmailCode = data;
				console.log(EmailCode);
				$("#verifyBtn").prop("disabled", false);
			},
			error : function(err) {
				alert("에러가 발생했습니다.\n브라우저 콘솔의 내용을 확인하세요.");
				console.log(err);
				$("#verifyBtn").prop("disabled", false);
			}
		});

	}

	//인증코드 확인 함수
	var emailChk1 = "N";
	function emailChk() {
		if ($("#VerifyNum").val() == "" || $("#VerifyNum").val() == null) {
			alert("인증코드를 써주세요.");
		} else if ($("#VerifyNum").val() != EmailCode) {
			alert("인증코드가 일치하지 않습니다.");
		} else if ($("#VerifyNum").val() == EmailCode) {
			alert("인증코드가 일치합니다.");
			emailChk1 = "Y";
		}
	}

	//웹 알림 Function
	function notifyMe() {
		if (!"Notification" in window) {
			alert("This browser does not support desktop notification");
		} else if (Notification.permission === "granted") {
			var notification = new Notification("Hi there!");
		} else if (Notification.permission !== 'denied') {
			Notification.requestPermission(function(permission) {
				if (!('permission' in Notification)) {
					Notification.permission = permission;
				}
				if (permission === "granted") {
					var notification = new Notification("Hi there!");
				}
			});
		}
	}

	//레지스터 유효성검사
	function register() {
		if (idkChk == "N" || emailChk1 == "N") {
			alert("아이디 중복 체크 및 이메일 인증을 해주세요");
			console.log(idkChk + emailChk1);
		} else {

			$("#insertForm").submit();
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
                        console.log(res.id);   
                        var userID = res.id;      //유저의 카카오톡 고유 id
                        var userEmail = res.kakao_account.email;   //유저의 이메일
                        document.getElementById('Email_id').value = userEmail;
                        document.getElementById('pw').value = userID;
                        
                        idChked('Y');	// 이메일 아이디 중복검사 ajax
                                
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
		document.getElementById('Email_id').value = profile.getEmail();
		// 아이디 코드
		document.getElementById('pw').value = profile.getId();

		// 비동기로 이메일과 아이디코드를 확인하고 정보 넘기기
		idChked('Y');
	 	
		// ??
		var id_token = googleUser.getAuthResponse().id_token;

		// 로그아웃
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.disconnect();
		
	}
	
</script>
</head>


<body>
	<!-- header -->
	<%@ include file="/WEB-INF/views/header.jsp"%>
	
	
	<input type = "button" value = "카카오 로그인" onclick = "kakaoLogin();"/>
	<div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark" id="google"></div>
	<div align="center">
		<br>
		<h1>REGISTER</h1>
		<br> <br>

		<form action="insert.do" method="post" id="insertForm">

			<!--  
	profile<br>
	<img id="img_profile" class="img_profile" src="" onError="this.src='/resources/images/imgSample.png'" alt="" name="userImgpath">
	<br>
		<input type="file" id="imgFile" >
	<hr>
	
		<input type="hidden" id="tg_YN" name="tgYn" value="N">
-->
			<!-- 로그인하기 -->
			<label id="registerID"> user id : </label> 
				<input type="text" class="inputText" id="Email_id" placeholder="please insert your id" required="required" name="userId" /> 
				<input type="button" class="inputBtn"  value="id-check" onclick="idChked();" id="idChk"> <br> <br>

			<!-- 패스워드하기 -->
			<label id="registerPW"> password : </label> 
				<input type="password" placeholder="please insert your password" id="pw" class="inputText" name="pw" onclick="idChkConfirm();" required="required" /> <br> <br>

			<!-- 이름 하기 -->
			<label id="registerName">name : </label> 
				<input type="text" class="inputText" placeholder="please insert your name" name="name" required="required" onclick="idChkConfirm();"> <br> <br>
			<!-- 모바일하기 -->
			<label id="registerMobile"> mobile : </label> 
				<input type="text" placeholder="please insert your phone-number" name="phone" class="inputText" onclick="idChkConfirm();" required="required" /> <br> <br>

			<!-- 도로명 주소 검색하기 -->
			<label>Address : </label> 
				<input id="registerAddr" type="text" class="inputText" value="" onclick="openPop_juso();" required="required" name="addr1" placeholder="Click to here"> 
				<input id="registerAddr1" class="inputText" type="text" value="" required="required" name="addr2" placeholder="please more details"> <br> <br>

			<!-- 이메일 인증하기 -->
			<label>Email Verify</label> 
				<input type="button" value="Verify" class="inputBtn" onclick="verifyEmail();" id="verifyBtn"><br> <br>
			인증번호: 
				<input type="text" value="" class="inputText" id="VerifyNum"> 
				<input type="button" class="inputBtn" value="확인" onclick="emailChk();" id="verifyChk">
				<br> <br>
			<!-- register 아래 button -->
				<input type="button" value="REGISTER" id="register_longBtn" class="inputBtn" onclick="register();">
				 &nbsp; 
				<input type="button" class="inputBtn" value="CANCEL" onclick="location.href='main.do'">
		</form>
	</div>
	<!-- footer -->
 	<div id = "footer"><%@ include file="/WEB-INF/views/footer.jsp" %></div>
<!-- 알림테스트 코드 -->
<!-- 
<hr>
	<h2>웰 알림 테스트</h2>
	<input type="button" value="웹 알림 테스트" onclick="notifyMe();">
	 -->
</body>
</html>