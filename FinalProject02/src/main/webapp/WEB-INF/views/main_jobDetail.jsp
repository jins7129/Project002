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
								+userScore+"<br/></div></div>");
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


function apply(){
	var loginUserId = $("#loginInfo").val();
	var jobUserId = $("#jobInfoUserId").val();
	var jobSeq = $("#jobInfoJobSeq").val();
	location.href="jobApplyUpdate.do?jobSeq="+jobSeq+"&userId="+loginUserId+"&jobUserId="+jobUserId;
};

function applyCancel(){
	var loginUserId = $("#loginInfo").val();
	var jobSeq = $("#jobInfoJobSeq").val();
	location.href="jobApplyCancel.do?jobSeq="+jobSeq+"&userId="+loginUserId;
};

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
	width:700px;
	padding : 10px;
	margin : 8px;
}
#boardHeader{
	border-radius: 50px 50px 0px 0px;
	height: 300px;
}
#boardHeaderLine1{
	height: 30px;
	color:white;
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
		width : 450px;
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

.btnDetail:hover {
	background: black;
}

.img{
	border-radius: 40px;
}	

</style>
</head>
<body>
<input type="hidden" id="loginInfo" value="${loginInfo.userId}"/>
<input type="hidden" id="jobInfoJobSeq" value="${jobInfo.jobSeq}"/>
<input type="hidden" id="jobInfoUserId" value="${jobInfo.userId}"/>

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
	<c:when test="${jobInfo.jobComplete == 'N' }">
		<div id="boardHeaderLine1" class="board" style="background:#F87061;" >NOT COMPLETED</div>
		<div id="boardHeaderLine2" class="board" >
		<div>신청 현황<br/>
			<c:forEach items="${applyInfo }" var="userDto" >
				아이디 : <span class="applyInfo">${userDto.userId }</span><br/>
			</c:forEach>
		</div>
		</div>
	</c:when>
	<c:when test="${jobInfo.jobComplete == 'Y' }">
		<div id="boardHeaderLine1" class="board" style="background:#00bf8f;" >COMPLETED</div>
	</c:when>
</c:choose>
<div id="boardBody" class="board" align="justify" >
${jobInfo.jobContent }
</div>
<div id="boardFooter" class="board">

<c:choose>
	<c:when test="${check.apply == 'true' }">
		<input type="button" class="btnDetail" value="CANCEL" onclick="applyCancel();"/>
	</c:when>
		<c:otherwise>
			<c:if test="${check.writer =='false' }">
				<input type="button" class="btnDetail" value="APPLY" onclick="apply();" />
			</c:if>
		</c:otherwise>
</c:choose>
<input type="button" class="btnDetail" value="BACK" onclick="history.back();" />
</div>
</div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>

</body>
</html>