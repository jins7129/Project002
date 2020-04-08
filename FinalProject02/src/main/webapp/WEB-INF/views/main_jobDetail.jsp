<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>
<%@ include file="/WEB-INF/views/header.jsp"%>
<link rel="icon" href="/resources/images/icon.png" type="image/x-icon">
<script type="text/javascript">

$(function(){
	$(document).on('click','input[name=choice]', function() {
		// $(document).on('click','태그',function(){})
		var choiceId = $("input[name=choiceId]").val();
		applyChoice(choiceId);
		//console.log(writtenEndPageNum);
	});
	
	$(".applyInfo").hover(function(){
		var userInfoTAG = $(this);
		var userId = userInfoTAG.text();
		$.ajax({
			type:"post",
			url:"userDetail.do?userId="+userId,
			dataType:"json",
			success:function(data){
				var userInfo = data.userInfo;
				var userScore = data.userScore;
				//console.log(data);
				userInfoTAG.append("<div class='applyUserInfo'><div class='applyUserInfoChild'><img style='width: 30%; height: 30%;' src='resources/file/profilePhoto/"
								+userInfo.userImgpath+"'><br/>"
								+userInfo.userId+"<br/>이름 : "
								+userInfo.userName+"<br/>평점 : "
								+userScore+"<br/></div><input type='button' name='choice' class='btnDetail' value='CHOICE'/><input type='hidden' name='choiceId' value='"+userInfo.userId+"' /></div>");
			},
			
			error:function(){
				alert("통신 실패");
			}
			
		});
		
	}, 
	function(){
		$(".applyUserInfo").remove();
	});
	
});

function apply(){	// 사용자의 신청
	var loginUserId = $("#loginInfo").val();
	var jobUserId = $("#jobInfoUserId").val();
	var jobSeq = $("#jobInfoJobSeq").val();
	location.href="jobApplyUpdate.do?jobSeq="+jobSeq+"&userId="+loginUserId+"&jobUserId="+jobUserId;
};

function applyCancel(){ // 사용자의 신청 취소
	var loginUserId = $("#loginInfo").val();
	var jobSeq = $("#jobInfoJobSeq").val();
	location.href="jobApplyCancel.do?jobSeq="+jobSeq+"&userId="+loginUserId;
};

function jobDelete(){	// 작성자의 글 삭제
	var loginUserId = $("#loginInfo").val(); // 로그인한 회원 == 글작성자
	var jobSeq = $("#jobInfoJobSeq").val();
	location.href="jobDelete.do?jobSeq="+jobSeq+"&userId="+loginUserId;
}
function jobUpdate(){	// 작성자의 글 수정
	var loginUserId = $("#loginInfo").val(); // 로그인한 회원 == 글작성자
	var jobSeq = $("#jobInfoJobSeq").val();
	location.href="jobUpdate.do?jobSeq="+jobSeq+"&userId="+loginUserId;
}
function applyChoice(choiceId){ // 작성자의 사용자 선택
	var loginUserId = $("#loginInfo").val();
	var jobSeq = $("#jobInfoJobSeq").val();
	//console.log(choiceId);	// 선택한 사용자
	location.href="jobApplyChoice.do?applySeq="+jobSeq+"&applyOwner="+loginUserId+"&applyWoker="+choiceId;
}
function jobGiveReward(){
	var jobReward = $("#jobReward").val();
	var jobSeq = $("#jobInfoJobSeq").val();
	var applyWoker = $("#userId").val();
	var applyOwner = $("#jobInfoUserId").val();
	location.href="jobGiveReward.do?jobSeq="+jobSeq+"&jobReward="+jobReward+"&applyWoker="+applyWoker+"&applyOwner="+applyOwner;
}

</script>
<style type="text/css">
#board{
	background: #32506d;
	width:800px;
	border-radius: 70px;
	padding : 10px;
	margin : 10px;
}
.board{
	background: white;
	width:740px;
	padding : 10px;
	margin : 8px;
}
#boardHeader{
	border-radius: 50px 50px 0px 0px;
	height: 300px;
}
#boardHeaderLine1{	/*not completed, completed*/
	height: 30px;
	color:white;
	padding : 10px;
	font-size: 18px;
	font-weight: bold;
}
#boardHeaderLine2{
	text-align: left;
}

.applyUserInfo{
	/*유저 정보 풍선 css*/
		position: relative;
		top: -30px;
		left: 20px;
		background : #32506d;
		text-align: center;
		width : 380px;
		padding : 5px;
		border-radius: 30px;
}

.applyUserInfoChild{
	background: white;
	width : 350px;
	padding : 15px;
	border-radius: 30px;
}
.btnDetail {
	/*버튼 css*/
	justify-content: center;
	align-items: center;
	padding: 0 20px;
	margin : 5px;
	width: 100px;
	height: 35px;
	border-radius: 10px;
	background: #00BF8F;
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
#deleteBtn{
	background: rgb(248, 112, 97);
}

.btnDetail:hover, #deleteBtn:hover {
	background: black;
}

.img{
	border-radius: 40px;
}
#boardFooter{
	border-radius: 0px 0px 50px 50px;
}
.applyInfo:hover{
	cursor: pointer;
}


</style>
</head>
<body>
<input type="hidden" id="loginInfo" value="${loginInfo.userId}"/>
<input type="hidden" id="jobInfoJobSeq" value="${jobInfo.jobSeq}"/>
<input type="hidden" id="jobInfoUserId" value="${jobInfo.userId}"/>
<input type="hidden" id="jobReward" value="${jobInfo.jobReward }"/>

<div align="center">
<div id="board">
<div id="boardHeader" class="board">
	<div style="float:left; padding:10px;" >글번호 : ${jobInfo.jobSeq }</div>
	<div style="float:right; padding:10px;">조회수 : ${jobInfo.jobView }</div>
	<div style="float:left; padding:10px; clear:both;"  >제목 : ${jobInfo.jobTitle }</div>
	<div style="float:right; padding:10px;">유형 : ${jobInfo.jobCategory }</div><br/>
	<div style="float:left; padding:10px; clear:both;"  >기간 : ${jobInfo.jobStart } ~ ${jobInfo.jobDone }</div>
	<div style="float:right; padding:10px;">작성일 : ${jobInfo.jobDate }</div><br/>
	<div style="float:left; padding:10px; clear:both;"  >작성자 : ${jobInfo.userId }</div>
	<div style="float:right; padding:10px;">보상 : ${jobInfo.jobReward }</div><br/>
	<div style="float:right; padding:10px;">평점 : ${check.userScore }</div>
	<div style="position: relative; top:15px; left:-230px; "  ><img class="img" style="width: 30%; height: 30%;" src="resources/file/profilePhoto/${writerInfo.userImgpath }"/></div>
	
</div>
<c:choose>
	<c:when test="${jobInfo.jobComplete == 'Y' }">
		<div id="boardHeaderLine1" class="board" style="background:#00bf8f;" >COMPLETED</div>
	</c:when>
	<c:when test="${jobInfo.jobComplete == 'D' }">
		<div id="boardHeaderLine1" class="board" style="background:#FF7F50;" >IN PROGRESS</div>
		<div id="boardHeaderLine2" class="board" >
		<div>진행 현황<br/>
			<c:forEach items="${applyInfo }" var="userDto" >
				아이디 : <span class="applyChoiceInfo">${userDto.userId }</span><br/>
			</c:forEach>
		</div>
		</div>
	</c:when>
	<c:otherwise>
		<div id="boardHeaderLine1" class="board" style="background:#F87061;" >NOT COMPLETED</div>
		<div id="boardHeaderLine2" class="board" >
		<div>신청 현황<br/>
			<c:forEach items="${applyInfo }" var="userDto" >
				아이디 : <span class="applyInfo">${userDto.userId }</span><br/>
				<input type="hidden" name="userId" value="${userDto.userId }"/>
			</c:forEach>
		</div>
		</div>
	</c:otherwise>
</c:choose>
<div id="boardBody" class="board" align="justify">
${jobInfo.jobContent }
</div>
<div id="boardFooter" class="board">

<c:choose>
	<c:when test="${check.writer =='true' }"> <!-- 작성자인경우 -->
		<c:choose>
			<c:when test="${jobInfo.jobComplete == 'N'  }">	<!-- 글 상태가 완료가 아닌경우 -->
				<input type="button" class="btnDetail" value="UPDATE" onclick="jobUpdate();" />
				<input type="button" class="btnDetail" id="deleteBtn" value="DELETE" onclick="jobDelete();" />
			</c:when>
			<c:when test="${jobInfo.jobComplete == 'D'  }">	<!-- 글 상태가 진행중인 경우 -->
				<input type="button" class="btnDetail" style="width: 140px;" value="GIVE REWARD" onclick="jobGiveReward();" />
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
		
	</c:when>
	<c:when test="${check.writer =='false' }"> <!-- 작성자가 아닌경우 -->
		<c:choose>
			<c:when test="${check.apply == 'true' }"> <!-- 지원자인 경우 -->
				<c:choose>
					<c:when test="${jobInfo.jobComplete !='D' }"> <!-- 글이 진행중이 아닌 경우 -->
						<input type="button" class="btnDetail" value="CANCEL" onclick="applyCancel();"/>
					</c:when>
					<c:otherwise>
						<input type="button" class="btnDetail" style="width: 140px;" value="YOUR WORK"/>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<input type="button" class="btnDetail" value="APPLY" onclick="apply();" />
			</c:otherwise>
		</c:choose>
	</c:when>
</c:choose>
<input type="button" class="btnDetail" value="BACK" onclick="history.back();" />
</div>
</div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>

</body>
</html>