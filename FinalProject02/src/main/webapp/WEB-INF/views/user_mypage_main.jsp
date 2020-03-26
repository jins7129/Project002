<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 메인 페이지</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style type="text/css">
#btnUpdate {
	display: -webkit-box;
	display: -webkit-flex;
	display: -moz-box;
	display: -ms-flexbox;
	display: flex;
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
}

#btnUpdate:hover {
	background: black;
}
</style>
<script type="text/javascript">

	$(function(){
		var pageNum = 1;
		$("#writtenBoard").click(function(){
			$.ajax({
				type: "post",
				contentType:"application/json",
				url:"testBoard.do?pageNum="+pageNum,
				//data: ,
				dataType: 'json',
				success:function(data){
					var list = data.list; // 글 목록을 담음
					var pageMaker = data.pageMaker;	// 페이징 정보를 담음
					var writtenBoard = $("#writtenBoard");
					var writtenPaging = $("#writtenBoardPaging");
					writtenBoard.children().remove();	// 게시판 기존 내용 삭제
					console.log(data);	// 들어온 json 값 확인
					alert("통신 성공"+list.jobSeq);
					writtenBoard.append("<tr><th>번호</th><th>제목</th><th>보상</th><th>작성일</th><th>완료여부</th></tr>");
					
					for(var i = 0 ; i < list.length; i++){
						var val = list[i];
						writtenBoard.append("<tr><td>"+val.jobSeq+"</td><td>"+val.jobTitle+"</td><td>"+val.jobReward+"</td><td>"+val.jobDate+"</td></tr>");
					}
					
					writtenPaging.append("<tr><td><a href='#' >"+pageMaker.startPage+"</a></td></tr>");
					
					
				},
				error:function(){
					alert("통신 실패");
				}
				
			});
			
		});
		
	});


</script>


</head>
<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div align="center">
		<img
			src="resources/file/profilePhoto/${loginInfo.userId}.${loginInfo.userImgpath}" />
		<table>
			<tr>
				<td>이름 :</td>
				<td>${loginInfo.userName }</td>
			</tr>
			<tr>
				<td>아이디 :</td>
				<td>${loginInfo.userId }</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td>${loginInfo.userPhone }</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>${loginInfo.userAddr }</td>
			</tr>
			<tr>
				<td colspan="3" align="right"><input id="btnUpdate"
					type="button" value="수정하기"
					onclick="location.href='mypage_update.do'" /></td>
			</tr>

		</table>
	</div>

	<div align="center" >
		<h2>내가 작성한 글</h2>
		<table id="writtenBoard" border="1">

		</table>
		<div id="writtenBoardPaging" ></div>
	</div>

	<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>