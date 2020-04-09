<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모아보기</title>
<style type="text/css">

.wrapper {
	align-content: center;
	align-items: center;
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
	margin-left: 3%;
}


.boardChild {
	margin : 14px;
	padding : 10px;
	width: 270px;
	height: 220px;
	border-radius: 20px;
	background : #32506d;
	border : 3px solid #32506d;
	
	box-sizing: border-box;
	display: -moz-box;
	display: -ms-flexbox;
	justify-content: center;
	align-items: center;
	cursor: pointer;
	/* font-family: Montserrat-Bold; */
	font-size: 15px;
	color: black;
	line-height: 1.1;
	text-transform: uppercase;
	letter-spacing: 1px;
	-webkit-transition: all 0.4s;
	-o-transition: all 0.4s;
	-moz-transition: all 0.4s;
	transition: all 0.4s;
	float: none;
}

.boardChild:hover {
	color : black;
	background-color: white;
}
/* 나중에 문제 있으면 추가할 것
body {
	background: gray;
	margin: 0;
	padding: 0; */
}

#wrap {
	width: 100%;
	height: 100px;
	background: white;
	
}

#sidebar {
	background: white;
	width: 300px;
	height: 350px;
	top: 300px;
	left: -300px;
	position: fixed;
	border-radius: 10px;
}

#sidebar div {
	border-radius : 10px;
	margin: 0 0 20px;
	list-style: none;
}
#sidebar div:hover {
	background-color: gray;
	font-size: 15px;
	color: black;
	line-height: 1.1;
	text-transform: uppercase;
	letter-spacing: 1px;
	-webkit-transition: all 0.4s;
	-o-transition: all 0.4s;
	-moz-transition: all 0.4s;
	transition: all 0.4s;

}

#sidebar>button {
	background: rgb(248, 112, 97);
	position: absolute;
	top: 250px;
	left: 300px;
	width: 52px;
	height: 52px;
	border: none;
	color: white;
	border-radius: 10px;
}
#sidebar>button:hover{
	cursor: pointer;
	background: #00bf8f;
}

.sideMenu{
margin-bottom: 10px;}

.boardHeader{
	margin-left : 5px;
	margin-bottom : 7px;
	width: 14px;
	height: 14px;
	border-radius: 8px;
}
.boardTitle{
	background : white;
	border-radius : 10px 10px 0px 0px;
	padding: 3px;
	margin : 5px;
	height: 16px;
}

.boardContent{
	background: white;
	border-radius : 0px 0px 10px 10px;
	padding: 3px;
	margin : 5px;
	height: 130px;
}
</style>
</head>
<body>
<!-- header -->
	<%@ include file="/WEB-INF/views/header.jsp"%>
	
	<!-- 사이드바 JS -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">
	$(function(){
		var duration = 300;

		var $side = $('#sidebar');
		var $sidebt = $side.find('button').on('click', function(){
			$side.toggleClass('open');

			if($side.hasClass('open')) {
				$side.stop(true).animate({left:'0px'}, duration);
				$sidebt.find('span').text('CLOSE');
			}else{
				$side.stop(true).animate({left:'-300px'}, duration);
				$sidebt.find('span').text('OPEN');
			};
		});
	});
</script>
	
	<!-- 드래그앤드랍 JS -->
	<script type="text/javascript">
	function dragEnter(ev) {
		ev.preventDefault();

	}

	function drag(ev) {
		ev.dataTransfer.setData("info", ev.target.id);
		
	}

	function drop(ev) {
		var arr = ev.dataTransfer.getData("info").split(" ");
		ev.preventDefault();
		
		var jobSeq = arr[0];
		var jobUserId = arr[1];
		var userId = arr[2];
		$.ajax({

		    url: "jobApplyUpdate.do?jobSeq="+jobSeq+"&userId="+userId+"&jobUserId="+jobUserId,

		    success: function(data){
		    	alert("장바구니에 담겼습니다.");
		    },

		    error: function (request, status, error){        
		    	alert("오류가 발생했습니다. 다시 시도해주세요.");
		    }
		  });
	}
	</script>
	<br/><br/>
	<div class="wrapper" align="left">
		<c:forEach items="${list}" var="JobDto">
			<div id="board" >
			<div class="dragInner boardChild" id="${JobDto.jobSeq} ${JobDto.userId} ${loginInfo.userId}" onclick="location.href='main_jobDetail.do?jobSeq=${JobDto.jobSeq}'" draggable="true" ondragstart="drag(event)">
				<div class="boardHeader" style="${JobDto.jobComplete == 'Y' ? 'background:#00bf8f;': JobDto.jobComplete == 'D' ? 'background:#FF7F50;' : 'background:#dd4b39;'}" ></div>
				<div class="boardTitle">제목 : ${JobDto.jobTitle}</div>
				<div class="boardContent">
				글번호 : ${JobDto.jobSeq}<br/>
				조회수 : ${JobDto.jobView}<br/>
				작성자 : ${JobDto.userId}<br/>
				작성날짜 : ${JobDto.jobDate}</div>
			</div>
			</div>
		</c:forEach>
	</div>
	
	<!-- 사이드바 기능 -->
	<div id="wrap">
		<aside id="sidebar">
			<br><br>
				<div class="sideMenu" ondrop="drop(event)" ondragover="dragEnter(event)" align="center"><img src="/resources/images/icon_bag.svg" width="150" height="100" onclick="location.href='mypage_main.do'" ></div><br><br>
				<div class="sideMenu" align="center"><img src="/resources/images/icon_search_image.svg" width="150" height="100" onclick="location.href='editor.do;'"></div>
			<button><span class="btn_t">OPEN</span></button>
		</aside>
	</div>

	<!-- footer -->
 	<div id = "footer"><%@ include file="/WEB-INF/views/footer.jsp" %></div>
</body>
</html>