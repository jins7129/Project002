<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>
<link rel="icon" href="/resources/images/icon.png" type="image/x-icon">
	<!-- header -->
	<%@ include file="/WEB-INF/views/header.jsp"%>
<style>
.inputBtn{
	display: -moz-box;
	display: -ms-flexbox;
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

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.js"></script>
<script type="text/javascript">
$(function() {
    $('#summernote').summernote({
      height: 500,
      witdh : 200,
      focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
	  placeholder: '내용을 작성해주세요',
      //callback
      callbacks: {
			onImageUpload: function(files, editor, welEditable) {
	            for (var i = files.length - 1; i >= 0; i--) {
	            	sendFile(files[i], this);
	            }
	        }
		}
    });
    
    //upload function
    function sendFile(file, el) {
		var form_data = new FormData();
      	form_data.append('file', file);
      	$.ajax({
        	data: form_data,
        	type: "POST",
        	url: 'insertTest.do',
        	cache: false,
        	contentType: false,
        	enctype: 'multipart/form-data',
        	processData: false,
        	success: function(img_name) {
          		$(el).summernote('editor.insertImage', img_name);
        	}
      	});
    }
  });
</script>
</head>
<body>

	<div align="center">
		<br>
		<h1>Request</h1><br><br>
		<form action="main_updateres.do" method="post">
			<input type="hidden" name="userId" value="${jobInfo.userId }">
			<input type="hidden" name="jobSeq" value="${jobInfo.jobSeq }">
			
			<label>Title : </label> 
				<input type="text" class="inputText" placeholder="please insert title" name="jobTitle" value="${jobInfo.jobTitle }" style="width: 550px"><br><br>
			
			<label>Reward : </label> 
				<input type="number" class="inputText" placeholder="please insert pay" name="jobReward" value="${jobInfo.jobReward }" style="width: 15	0px"><br><br>
			
			<label>Date : </label> 
				<input type="date" class="inputText" name="jobStart" value="${jobInfo.jobStart }" style="border: 1px solid black;	"> ~
				<input type="date" class="inputText" name="jobDone" value="${jobInfo.jobDone }" style="border: 1px solid black;"><br><br>
			
			<label>Location : </label>
			<input type="text" class="inputText" placeholder="please insert address" name="jobAddr" value="${jobInfo.jobAddr }" ><br><br>
			<div style="width:800px; text-align:left;" >
			<textarea id="summernote" name="jobContent" >${jobInfo.jobContent }
			</textarea>
			</div>
			
			<br><br>
			<label>Category</label>
				<select name="jobCategory">
					<optgroup label="대분류">
						<option label="매장관리" value="매장관리" ${jobInfo.jobCategory == '매장관리'? "selected" : "" }/>
						<option label="서빙/주방" value="서빙/주방" ${jobInfo.jobCategory == '서빙/주방'? "selected" : "" }/>
						<option label="서비스/미디어" value="서비스/미디어" ${jobInfo.jobCategory == '서비스/미디어'? "selected" : "" }/>
						<option label="생산/기능/운전/배달" value="생산/기능/운전/배달" ${jobInfo.jobCategory == '생산/기능/운전/배달'? "selected" : "" }/>
						<option label="사무/회계" value="사무/회계" ${jobInfo.jobCategory == '사무/회계'? "selected" : "" }/>
						<option label="상담/영업/리서치" value="상담/영업/리서치" ${jobInfo.jobCategory == '상담/영업/리서치'? "selected" : "" }/>
						<option label="교육" value="교육" ${jobInfo.jobCategory == '교육'? "selected" : "" }/>
						<option label="기타/심부름" value="기타/심부름" ${jobInfo.jobCategory == '기타/심부름'? "selected" : "" }/>
					</optgroup>
				</select><br><br>
			<input type="submit" class="inputBtn" value="수정하기">
			<input type="button" class="inputBtn" value="돌아가기" onclick="history.back();">
		</form>
	</div>
	
		 	<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>