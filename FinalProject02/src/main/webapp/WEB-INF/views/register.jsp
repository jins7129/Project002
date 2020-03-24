<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REGISTER</title>

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
			open("idchk?id=" + doc.value, "", "width=200, height=200")
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
	
	
	
	//이메일 인증 API
	var emailCode = "";
	function fnEmailValidation() {
		var email = $("#Email_id").val();
		if ($.trim(email).length < 1) {
			return;
		}

		$.ajax({
			url : "emailValidation",
			type : "post",
			dataType : "json",
			data : {
				"email" : $("#Email_id").val()
			},
			success : function(data) {
				console.log(data);
				if (data.resultCode == "1002") {
					return alert("이미 가입되어 있는 이메일 주소입니다.");
				} else if (data.resultCode == "1001") {
					return alert("메일 발송중 에러가 발생했습니다.\n메일을 발송하지 못했습니다.");
				}

				emailCode = data.emailValidationCode;
				alert("메일이 발송 되었습니다.\n메일에 포함된 인증코드를 입력 후 인증 버튼을 눌러주세요.");
			},
			error : function(err) {
				alert("에러가 발생했습니다.\n브라우저 콘솔의 내용을 확인하세요.");
				console.log(err);
			}
		});
	}
</script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<body>
	<h1>register</h1>
	<hr id="registerLine" />
	
	<!-- 프로필 사진 넣기 -->
	profile<br>
	<img alt="error" src=""><br>
		<input type="button" onclick="" value="이미지 삽입하기" >
	<hr>
	
	<form action="insert" method="post" id="frm">
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
				<input id="registerAddr" type="text" value="">
				<input id="registerAddr1" type="text" value=""> 
				<input type="button" value="검색" onclick="openPop_juso();">
			<hr id="addrLine">
		</div>

		<!-- 이메일 인증하기 -->
		<div>
		<label>Email Verify</label>
			<input type="button" value="Verify" onclick="fnEmailValidation();"><br>
			Verify<input type="checkbox" value="Completed" disabled="disabled">
		</div>

		<!-- register 아래 button -->
		<div id="register_long_btn">
			<input type="submit" value="register" id="register_longBtn" style="float: right;">
		</div>
	</form>
	
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

	<label></label>
	<input type="text" value="" placeholder=""><br>
		
	
</body>
</html>