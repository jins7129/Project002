<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>
<link rel="icon" href="/resources/images/icon.png" type="image/x-icon">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style type="text/css">
#btnUpdate {
	/*버튼 css*/
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


.writtenBoardNum, .applyBoardNum, .doingBoardNum, .doneBoardNum, .reviewBoardNum{
	/* 내가 쓴 게시물 페이징 css */
	cursor:pointer;
	background: white;
	color:black;
	font: bold;
	font-size: 12pt;
}

.writtenBoardNum:hover, .applyBoardNum:hover, .doingBoardNum:hover, .doneBoardNum:hover, .reviewBoardNum:hover{
	/* 내가 쓴 게시물 페이징 호버 */
	color:rgb(248, 112, 97);
}

.writtenBoardTitle:hover, .applyBoardTitle:hover, .doingBoardTitle:hover, .doneBoardTitle:hover, .reviewBoardTitle:hover{
	/* 내가 쓴 게시물 제목 호버 */	
	color: rgb(248, 112, 97);
	cursor: pointer;
}

.boardTitle{
	text-decoration: none;
	color : black;
}

.boardTitle:hover{
	color: rgb(248, 112, 97);
}

.boardCss{
	float:none;

}


</style>
<script type="text/javascript">

	var pageNum = 1;	// 받을 페이지 번호(전역변수)
	var writtenEndPageNum;
	var applyEndPageNum;
	var doingEndPageNum;
	var doneBoardPageNum;
	var reviewBoardPageNum;
	
	function checkPageNum(value, endPageNum){
		// pageNum 태그 들의 값 확인
		if(value == '<<'){
			return 1;
		} else if (value == '>>'){
			return endPageNum;
		} else {
			return value;
		}
	}
	
	
	$(function() {
		// 페이지 로드시 바로 불러올 목록
		writtenBoard();	// 내가 쓴 글
		applyBoard();	// 내가 신청한 글
		doingBoard();	// 내가 하는 중인 글
		doneBoard();	// 내가 완료한 글
		reviewBoard();	// 내가 쓴 리뷰
		
		// 동적쿼리로 생성된 태그들의 이벤트 걸어주기 
		$(document).on('click','input[name=writtenBoardPaging]', function() {
					// $(document).on('click','태그',function(){})
					
					//console.log(writtenEndPageNum);
					pageNum = checkPageNum(this.value, writtenEndPageNum);
					writtenBoard();
			});
		
		////////////////////
		$(document).on('click','input[name=applyBoardPaging]', function() {
					pageNum = checkPageNum(this.value, applyEndPageNum);
					applyBoard();
		});
		
		
		////////////////////
		$(document).on('click','input[name=doingBoardPaging]', function() {
					pageNum = checkPageNum(this.value, doingEndPageNum);
					doingBoard();
		});
		////////////////////
		$(document).on('click','input[name=doneBoardPaging]', function() {
					pageNum = checkPageNum(this.value, doneEndPageNum);
					doneBoard();
		});
		
		////////////////////
		$(document).on('click','input[name=reviewBoardPaging]', function() {
					pageNum = checkPageNum(this.value, reviewEndPageNum);
					reviewBoard();
		});
		
	});
	
	function writtenBoard(){
		// 게시글 불러오는 함수
		$.ajax({
			type : "post",
			contentType : "application/json",	// json 형태이기에 꼭 써줘야함
			url : "getWrittenBoard.do?pageNum=" + pageNum,
			dataType : 'json',
			success : function(data) {
				//console.log(data.pageMaker); // 들어온 json 값 확인
				var list = data.list; // 글 목록을 담음
				var pageMaker = data.pageMaker; // 페이징 정보를 담음
				var writtenBoard = $("#writtenBoard");	// 페이지뿌려줄 테이블 태그
				var writtenPaging = $("#writtenBoardPaging");	// 페이징 뿌려줄 테이블 태그
				writtenBoard.children().remove(); // 게시판 기존 내용 삭제
				writtenPaging.children().remove(); // 페이징 삭제
				
				writtenEndPageNum = pageMaker.tempEndPage;
				for (var i = 0; i < list.length; i++) {
					var val = list[i];	// 게시글 뿌리기
					if(val.jobComplete == "Y"){
						val.jobComplete = "완료";
					} else if (val.jobComplete == "N"){
						val.jobComplete = "미완료"
					}
					writtenBoard.append("<div>번호 : "+val.jobSeq+ "<br/><a class='boardTitle' href='main.do' >제목 : "+ val.jobTitle+"</a><br/>보상 : "+val.jobReward+"<br/>작성일 : "+val.jobDate+"<br/>완료여부 : "+val.jobComplete+"</div>");
								
				}
				var pageCount = (pageMaker.endPage - pageMaker.startPage) + 1;	// 페이지 수 띄우기 변수
				
				if(pageMaker.next == true){	// 처음으로 버튼
					writtenPaging.append("<input style='width:30px; float:none;'  type='button' name='applyBoardPaging' class='applyBoardNum' value='<<'> ");
				}
				for (var i = 1; i < pageCount + 1; i++) {	// 일반 페이징 번호 버튼
					writtenPaging.append("<input style='width:30px; float:none;'  type='button' name='writtenBoardPaging' class='writtenBoardNum' value='"+i+"'> ");
				}
				if(pageMaker.prev == true){	// 마지막으로 버튼
					writtenPaging.append("<input style='width:30px; float:none;'  type='button' name='applyBoardPaging' class='applyBoardNum' value='>>'> ");
				}
			},
			error : function() {
				alert("통신 실패");
			}
		});
	}
	
	
	function applyBoard(){
		// 신청한 글 불러오는 함수
		$.ajax({
			type : "post",
			contentType : "application/json",	// json 형태이기에 꼭 써줘야함
			url : "getApplyBoard.do?pageNum=" + pageNum,
			dataType : 'json',
			success : function(data) {
				//console.log(data.pageMaker); // 들어온 json 값 확인
				var list = data.list; // 글 목록을 담음
				var pageMaker = data.pageMaker; // 페이징 정보를 담음
				var applyBoard = $("#applyBoard");	// 페이지뿌려줄 테이블 태그
				var applyPaging = $("#applyBoardPaging");	// 페이징 뿌려줄 테이블 태그
				applyBoard.children().remove(); // 게시판 기존 내용 삭제
				applyPaging.children().remove(); // 페이징 삭제
				
				applyEndPageNum = pageMaker.tempEndPage;
				
				for (var i = 0; i < list.length; i++) {
					var val = list[i];
					applyBoard.append("<div>번호 : "+val.jobSeq+ "<br/><a class='boardTitle' href='main.do' >제목 : "+ val.jobTitle+"</a><br/>보상 : "+val.jobReward+"<br/>작성일 : "+val.jobDate+"</div>");
					
				}
				var pageCount = (pageMaker.endPage - pageMaker.startPage) + 1;
				for (var i = 1; i < pageCount + 1; i++) {
					applyPaging.append("<input style='width:30px; float:none;'  type='button' name='applyBoardPaging' class='applyBoardNum' value='"+i+"'> ");
				}
				
			},
			error : function() {
				alert("통신 실패");
			}
		});
	}
	
	function doingBoard(){
		// 진행중인 아르바이트 글 불러오는 함수
		$.ajax({
			type : "post",
			contentType : "application/json",	// json 형태이기에 꼭 써줘야함
			url : "getDoingBoard.do?pageNum=" + pageNum,
			dataType : 'json',
			success : function(data) {
				console.log(data); // 들어온 json 값 확인
				var list = data.list; // 글 목록을 담음
				var pageMaker = data.pageMaker; // 페이징 정보를 담음
				var doingBoard = $("#doingBoard");	// 페이지뿌려줄 테이블 태그
				var doingPaging = $("#doingBoardPaging");	// 페이징 뿌려줄 테이블 태그
				doingBoard.children().remove(); // 게시판 기존 내용 삭제
				doingPaging.children().remove(); // 페이징 삭제
				
				doingEndPageNum = pageMaker.tempEndPage;
				
				for (var i = 0; i < list.length; i++) {
					var val = list[i];
					doingBoard.append("<div>번호 : "+val.jobSeq+ "<br/><a class='boardTitle' href='main.do' >제목 : "+ val.jobTitle+"</a><br/>보상 : "+val.jobReward+"<br/>작성일 : "+val.jobDate+"</div>");
					
				}
				var pageCount = (pageMaker.endPage - pageMaker.startPage) + 1;
				for (var i = 1; i < pageCount + 1; i++) {
					doingPaging.append("<input style='width:30px; float:none;'  type='button' name='doingBoardPaging' class='doingBoardNum' value='"+i+"'> ");
				}
			},
			error : function() {
				alert("통신 실패");
			}
		});
	}
	
	function doneBoard(){
		$.ajax({
			type : "post",
			contentType : "application/json",	// json 형태이기에 꼭 써줘야함
			url : "getDoneBoard.do?pageNum=" + pageNum,
			dataType : 'json',
			success : function(data) {
				console.log(data); // 들어온 json 값 확인
				var list = data.list; // 글 목록을 담음
				var pageMaker = data.pageMaker; // 페이징 정보를 담음
				var doneBoard = $("#doneBoard");	// 페이지뿌려줄 테이블 태그
				var donePaging = $("#doneBoardPaging");	// 페이징 뿌려줄 테이블 태그
				doneBoard.children().remove(); // 게시판 기존 내용 삭제
				donePaging.children().remove(); // 페이징 삭제
				
				doneEndPageNum = pageMaker.tempEndPage;
				
				for (var i = 0; i < list.length; i++) {
					var val = list[i];
					doneBoard.append("<div>번호 : "+val.jobSeq+ "<br/><a class='boardTitle' href='main.do' >제목 : "+ val.jobTitle+"</a><br/>보상 : "+val.jobReward+"<br/>작성일 : "+val.jobDate+"</div>");
					
				var pageCount = (pageMaker.endPage - pageMaker.startPage) + 1;
				for (var i = 1; i < pageCount + 1; i++) {
					donePaging.append("<input style='width:30px; float:none;'  type='button' name='doneBoardPaging' class='doneBoardNum' value='"+i+"'> ");
				}
				}
			},
			error : function() {
				alert("통신 실패");
			}
		});
	}
	
	function reviewBoard(){
		$.ajax({
			type : "post",
			contentType : "application/json",	// json 형태이기에 꼭 써줘야함
			url : "getReviewBoard.do?pageNum=" + pageNum,
			dataType : 'json',
			success : function(data) {
				console.log(data); // 들어온 json 값 확인
				var list = data.list; // 글 목록을 담음
				var pageMaker = data.pageMaker; // 페이징 정보를 담음
				var reviewBoard = $("#reviewBoard");	// 페이지뿌려줄 테이블 태그
				var reviewPaging = $("#reviewBoardPaging");	// 페이징 뿌려줄 테이블 태그
				reviewBoard.children().remove(); // 게시판 기존 내용 삭제
				reviewPaging.children().remove(); // 페이징 삭제
				
				reviewEndPageNum = pageMaker.tempEndPage;
				
				for (var i = 0; i < list.length; i++) {
					var val = list[i];
					reviewBoard.append("<div>번호 : "+val.jobSeq+ "<br/><a class='boardTitle' href='main.do' >제목 : "+ val.jobTitle+"</a><br/>보상 : "+val.jobReward+"<br/>작성일 : "+val.jobDate+"</div>");
					
				}
				var pageCount = (pageMaker.endPage - pageMaker.startPage) + 1;
				for (var i = 1; i < pageCount + 1; i++) {
					reviewPaging.append("<input style='width:30px; float:none;'  type='button' name='reviewBoardPaging' class='reviewBoardNum' value='"+i+"'> ");
				}
			},
			error : function() {
				alert("통신 실패");
			}
		});
	}
	
</script>
<style type="text/css">
.wrapper > div{
  border: 4px solid skyblue;
  border-radius: 20px 20px 20px 20px;
  margin : 5px;
  padding: 15px;
  font-size: 18px;
}
 
.wrapper {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  width : 800px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div align="center">
		<img style="width: 30%; height: 30%;" src="resources/file/profilePhoto/${loginInfo.userImgpath}" />
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
				<td>빵 개수</td>
				<td>${loginInfo.userCoin }개</td>
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

	<div align="center">
		<h3>내가 작성한 글</h3>
		<div id="writtenBoard" class="wrapper" align="left" >
		</div>
		<div>
			<table>
				<tr>
					<td id="writtenBoardPaging"></td>
				</tr>
			</table>
		</div>
	</div>
	
	<br/><br/>
	
	<div align="center" >
		<h3>내가 신청한 글</h3>
			<div id="applyBoard" class="wrapper" align="left" >
			</div>
			<div>
				<table>
					<tr>
						<td id="applyBoardPaging">
						</td>
					</tr>
				</table>
		</div>
	
	</div>
	<br/><br/>
	<div align="center" >
		<h3>내가 진행중인 글</h3>
			<div id="doingBoard" class="wrapper" align="left" >
			</div>
			<div>
				<table>
					<tr>
						<td id="doingBoardPaging">
						</td>
					</tr>
				</table>
		</div>
	
	</div>
	<br/><br/>
	<div align="center" >
		<h3>내가 완료한 글</h3>
			<div id="doneBoard" class="wrapper" align="left" >
			</div>
			<div>
				<table>
					<tr>
						<td id="doneBoardPaging">
						</td>
					</tr>
				</table>
		</div>
	
	</div>
	<br/><hr/><br/>
	<div align="center" >
		<h3>내가 쓴 리뷰</h3>
			<div id="reviewBoard" class="wrapper" align="left" >
			</div>
		
			<div>
				<table>
					<tr>
						<td id="reviewBoardPaging">
						</td>
					</tr>
				</table>
		</div>
	
	</div>

	<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>