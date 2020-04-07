<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function oneCheckBox(ck){
		var obj = document.getElementsByName('ch');
		for(var i = 0; i < obj.length; i++){
			if(obj[i] != ck){
				obj[i].checked = false;
			}
		}
	}
	
	function review_writeres(){
		var score = null;
		var review_id = document.getElementById('review_id').value;
		var title = document.getElementsByName('review_title').value;
		var content = document.getElementsByName('review_content').value;
		$('input:checkbox[name="ch"]').each(function(){
			if(this.checked){
				score = this.value
			}
		});
		
		location.href = "/review_writeres.do?review_id="+review_id+"&score="+score+"&title="+title+"&content="+content;
	}
</script>
<style type="text/css">
	.review_form{
		margin: 0px auto;
		margin-top: 50px;
		margin-bottom: 50px;
		width: 30%;
	}
	
	.checkboxform{
		padding-left: 720px;
	}
	
	.buttonform{
		margin: 0px auto;
		width: 30%;
		padding-left: 100px;
	}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>

	<table class = "review_form">
		<tr>
			<td>제목 : </td>
			<td><input type = "text" name = "review_title"/></td>
		</tr>
		<tr>
			<td>내용 : </td>
			<td><textarea rows="30" cols="60" name = "review_content"></textarea></td>
		</tr>
	</table>		

	<table class = "checkboxform">
		<tr>
			<td><input type="checkbox" name="ch" value="5" onclick = "oneCheckBox(this);">★★★★★</td>
			<td><input type="checkbox" name="ch" value="4" onclick = "oneCheckBox(this);">☆★★★★</td>
			<td><input type="checkbox" name="ch" value="3" onclick = "oneCheckBox(this);">☆☆★★★</td>
			<td><input type="checkbox" name="ch" value="2" onclick = "oneCheckBox(this);">☆☆☆★★</td>
			<td><input type="checkbox" name="ch" value="1" onclick = "oneCheckBox(this);">☆☆☆☆★</td>
		</tr>
	</table>
		
	<div class = "buttonform">
		<input type = "button" value = "취소하기" onclick = "location.href = ''"/>
		<input type = "button" value = "리뷰 작성하기" onclick = "review_writeres();"/>
	</div>


<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>