<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring Boot</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript">

	$(function(){
		$("#loginChk").hide();
	});
	
	function login(){
		var userId=$("#userId").val().trim();
		var userPw=$("#userPw").val().trim();
		
		console.log(userId+"/"+userPw);
		
		var loginVal = {
				"userId":userId,
				"userPw":userPw
		};				// 자바스크립트 객체(오브젝트)
		
		if(userId==null||userId==""||userPw==""||userPw==null){
			alert("아이디 및 패스워드를 확인해주세요");
		} else{
			$.ajax({
				type:"post",
				url: "loginajax.do",
				data: JSON.stringify(loginVal),
				contentType: "application/json",		// unsupport mediaType 오류가 남, 기본이 text/html 타입이기 때문에
				dataType:"json",						// 명시해줘야함
				success: function(msg){
					if(msg.check == true){
						//location.href='list.do';
						alert("성공");
					} else {
						$("#loginChk").show();
						$("#loginChk").html("아이디 혹은 패스워드가 잘못되었습니다.");
					}
				},
				error : function(){
					alert("통신 실패");
				}
			});
			
		}

	}

</script>
</head>
<body>

<h1> Hello, Spring Boot!</h1>

<a href="register.do">레지스터 페이지</a>
<a href="main.do">메인페이지 테스트</a>
<table>	
			<tr>
				<th>아이디</th>
				<td><input type="text" id="userId" /></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" id="userPw"/></td>
			</tr>
			
			<tr>
				<td colspan="2" align="right">
					<input type="button" value="register"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left" id="loginChk"></td>
			</tr>
		</table>

</body>
</html>