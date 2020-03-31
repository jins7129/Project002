<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>
<script type="text/javascript">
	function dayshow(){
		document.getElementById('day').style.display="block";
		document.getElementById('report').style.display="block";
	}
	
	function reportres(seq,id){
		var day = document.getElementById('day').value;
		alert("아이디 : " + id + "날짜 : " + day + "번호 : " + seq)
		location.href = "/report_done.do?day=" + day +"&seq=" + seq + "&id=" + id;
	}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>

	<table>
		<tr>
			<td>신고번호 : ${dto.reportSeq }</td>
		</tr>
		<tr>
			<td>글 번호 : ${dto.jobSeq }</td>
		</tr>
		<tr>
			<td>유저아이디 : ${dto.userId }</td>
		</tr>
		<tr>
			<td>신고작성자 : ${dto.reportWriter }</td>
		</tr>
		<tr>	
			<td>신고날짜 : ${dto.reportDate }</td>
		</tr>
		<tr>	
			<td>내용 : ${dto.reportContent }</td>
		</tr>
		
	</table>
	
	<input type = "button" value = "뒤로가기" onclick = "location.href = '/report_admin.do'"/>
	<input type = "button" value = "접수하기" onclick = "dayshow();"/>
	<br/>
	<input type = "text" id = "day" style = "display: none"/>
	<input type = "button" id = "report" value = "확인" style = "display: none" onclick = "reportres('${dto.jobSeq }','${dto.userId }');"/>

<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>