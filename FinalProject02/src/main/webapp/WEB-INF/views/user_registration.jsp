<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REGISTER</title>
<style>
.img_profile {
   width: 160px;
   height: 170px;
   border-radius: 150px;
   box-shadow: 5px 10px 30px 10px black;
   margin-left: 28%;
}


</style>

<script>
	//ID 유효성 검사
	function idChkConfirm() {
		var chk = document.getElementsByName('id')[0].title
		if (chk == "n") {
			alert("아이디 중복체크를 먼저해주세요");
			document.getElementsByName("id")[0].focus();
		} else {
		}
	}

	function idChked() {
		var doc = document.getElementsByName("id")[0];
		if (doc.value.trim() == "" || doc.value == null
				|| doc.value == "undefined") {
			alert("아이디를 입력해주세요")
		} else {
			open("idchk.do?id=" + doc.value, "", "width=200, height=200")
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
	
	var EmailCode = "";
	
	//이메일 인증 SMTP
	function verifyEmail(){

		$.ajax({
			url : "sendMail.do?to="+$("#Email_id").val(),
			type: "post",
			contentType:"application/json",
			dataType : 'json',
			success : function(data) {
				alert("인증코드가 발급되었습니다.");
				EmailCode = data;
				console.log(EmailCode);
			},
			error : function(err) {
				alert("에러가 발생했습니다.\n브라우저 콘솔의 내용을 확인하세요.");
				console.log(err);
			}
		});
	}
	
	//인증코드 확인 함수
	function emailChk(){
	
		if($("#VerifyNum").val() == ""){
			alert("인증코드를 써주세요.");
		}else if($("#VerifyNum").val() != EmailCode){
			alert("인증코드가 일치하지 않습니다.");
		}else if ($("#VerifyNum").val() == EmailCode){
			alert("인증코드가 일치합니다.");
			$("#verifyBox").prop("checked", true);
		}
	}

	//웹 알림 Function
	function notifyMe() {
		  if (!"Notification" in window) {
		    alert("This browser does not support desktop notification");
		  }
		  else if (Notification.permission === "granted") {
		    var notification = new Notification("Hi there!");
		  }
		  else if (Notification.permission !== 'denied') {
		    Notification.requestPermission(function (permission) {
		      if(!('permission' in Notification)) {
		        Notification.permission = permission;
		      }
		      if (permission === "granted") {
		        var notification = new Notification("Hi there!");
		      }
		    });
		  }
		}
	
</script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<body>
	<h1>REGISTER</h1>
	<hr id="registerLine" />
		
	<!-- 프로필 사진 넣기 -->
	<form action="insert.do" method="post">
	<div>
	profile<br>
	<img id="img_profile" class="img_profile" src="" onError="this.src='/resources/images/imgSample.png'" alt="">
	<br>
		<input type="button" onclick="" value="이미지 삽입하기" >
	</div>
	<hr>
	
		<input type="hidden" id="tg_YN" name="tgYn" value="N">

		<!-- 로그인하기 -->
		<div id="register_IdBox">
			<label id="registerID"> user id : </label> 
				<input type="text" placeholder="please insert your id" name="id" id="Email_id" required="required" title="n" /> 
				<input type="button" value="id-check" onclick="idChked();" id="idChk">
			<hr id="idLine" />
		</div>

		<!-- 패스워드하기 -->
		<div id="register_PwBox">
			<label id="registerPW"> password : </label> 
				<input type="password" placeholder="please insert your password" name="pw" onclick="idChkConfirm();" required="required" />
			<hr id="pwLine" />
		</div>

		<!-- 모바일하기 -->
		<div id="register_mobileBox">
			<label id="registerMobile"> mobile : </label> 
				<input type="text" placeholder="please insert your phone-number" name="phone" onclick="idChkConfirm();" required="required" />
			<hr id="mobileLine" />
		</div>


		<!-- 도로명 주소 검색하기 -->
		<div id="register_addrBox">
			<label>Address : </label> 
				<input id="registerAddr" type="text" value="" onclick="openPop_juso();">
				<input id="registerAddr1" type="text" value=""> 
			<hr id="addrLine">
		</div>

		<!-- 이메일 인증하기 -->
		<div>
		<label>Email Verify</label>
			<input type="button" value="Verify" onclick="verifyEmail();"><br>
			Verify<input type="checkbox" value="Completed" disabled="disabled" id="verifyBox"  >
			인증번호: 
			<input type="text" value="" id="VerifyNum" >	
			<input type="button" value="확인" onclick="emailChk();" id="verifyChk">
			
		</div>

		<!-- register 아래 button -->
		<div id="register_long_btn">
			<input type="submit" value="REGISTER" id="register_longBtn" style="float: left; ;">
			<input type="button" value="CANCEL" onclick="location.href='main.do'" style="float: left;;">
		</div>
	</form>


<!-- 결제페이지 더미코드 -->
<!-- 	
	<hr>
	<h1>결제페이지</h1>
	<label>결제금액을 선택하세요</label>
	<select>
		<option>1000		
		<option>5000		
		<option>10000		
		<option>50000		
	</select>\
	
	<input type="button" value="결제하기"><br>
	
	<label>은행</label>
	<input type="text" value="" placeholder=""><br>
	
	<label>카드번호</label>
	<input type="text" value="" placeholder=""><br>
	
	<label>유효기간</label>
	<input type="text" value="" placeholder=""> <input type="text" value="" placeholder=""><br>

	<label>비밀번호</label>
	<input type="text" value="" placeholder="비밀번호를 입력하세요"><br>
 -->

<!-- 알림테스트 코드 -->
<!-- 
<hr>
	<h2>웰 알림 테스트</h2>
	<input type="button" value="웹 알림 테스트" onclick="notifyMe();">
	 -->

	 <!-- 이메일 인증 테스트  -->
		<!--
 
	<hr>
	<h2>메일 보내기 테스트</h2>
	<form action="sendMail.do" method="post">
		<input type="text" placeholder="이메일을 입력해주세요 " name="to">
		<input type="button" value="보내기" onclick="">
	</form>
		
		<label>인증번호</label>
		<input type="text" value="" id="VerifyNum">
		<input type="hidden" value="난수값" id="VerifyNumChk" >	
	 -->
	
	
	
</body>
</html>