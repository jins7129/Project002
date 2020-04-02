<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>
<link rel="icon" href="/resources/images/icon.png" type="image/x-icon">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style type="text/css">
.input {
	border: 1px solid black;
	height: 30px;
	border-radius: 5px 5px 5px 5px;
}

.input:focus {
	border-color: rgb(248, 112, 97);
}

#btnUpdate {
	justify-content: center;
	align-items: center;
	padding: 0 20px;
	margin: 5px;
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
}

#btnUpdate:hover {
	background: black;
}
</style>
<script type="text/javascript">
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
</script>
</head>
<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div align="center">
		<img src="resources/file/profilePhoto/${loginInfo.userId}.png" />
		<form action="">
			<table>
				<tr>
					<td><input type="file" name="userImgpath" title="사진 변경"/></td>
				</tr>
			</table>
		</form>
		<form action="mypage_updateres.do" method="post" >
			<table>
				<tr>
					<td>아이디</td>
					<td align="center">${loginInfo.userId }</td>
				</tr>
				<tr>
					<td>이름</td>
					<td align="center">${loginInfo.userName }</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td align="center"><input type="password" class="input"  name="userPw" value="${loginInfo.userPw }" required="required" /></td>
				</tr>

				<tr>
					<td>전화번호</td>
					<td align="center"><input type="text" class="input"
						name="userPhone" value="${loginInfo.userPhone }" required="required" /></td>
				</tr>
				<tr>
					<td>주소</td>
					<td align="center">
						<!-- 도로명 주소 검색하기 -->
						<div id="register_addrBox">
							<input id="registerAddr" class="input" type="text" value="${loginInfo.userAddr }"
								onclick="openPop_juso();" required="required" name="addr1" style="margin: 2px;" >
							<input id="registerAddr1" class="input" type="text" value=""
								required="required" name="addr2">
						</div>
					</td>
				</tr>
				
				<tr>
					<td colspan="3" align="right"><input id="btnUpdate"
					type="submit" value="수정완료"/><input id="btnUpdate"
					type="button" onclick="history.back();" value="취소"/></td>
					
				</tr>
			</table>
		</form>
	</div>



	<%@ include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>