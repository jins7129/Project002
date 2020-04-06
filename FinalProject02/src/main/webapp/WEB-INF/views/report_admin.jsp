<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>
<style type="text/css">
.report_table, .report_table th, .report_table td{
	border: 0;
}

.report_table{
	margin: 0px auto;
	margin-bottom: 200px;
	width: 70%;
	border-bottom: 1px solid #999;
	color: #666;
	font-size: 20px;
	table-layout: fixed;
}

.report_table th{
	padding: 5px 0 6px;
	border-top: solid 1px #999;
	border-bottom: solid 1px #b2b2b2;
	background-color: #f1f1f4;
	color: #333;
	font-weight: bold;
	line-height: 40px;
	vertical-align: top;
}

.report_table td{
	padding: 8px 0 9px;
	border-bottom: solid 1px #d2d2d2;
	text-align: center;
	line-height: 25px;
}

.report_table .date, .report_table .hit{
	font-family: Tahoma;
	font-size: 20px;
	line-height: normal;
}

.report_table .title{
	text-align: left;
	padding-left: 15px;
	font-size: 20px;
	text-align: center;
}

.search_menu{
	margin: 0px auto;
	margin-top: 100px;
	margin-bottom: 10px;
	width: 70%;
}
</style>
<link rel="icon" href="/resources/images/icon.png" type="image/x-icon">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	function search(){
		var obj = document.getElementById('type');
		var search_type = obj.options[obj.selectedIndex].value;
		var search_content = document.getElementById('search_text').value;
		
		location.href = "/report_search_admin.do?type=" + search_type + "&search_content=" + search_content;
	}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>

<div class = "search_menu">
<select id = "type">
	<option></option>
	<option value = "reportWriter">신고한 아이디</option>
	<option value = "userId">신고받은 아이디</option>
</select>
	<input type = "text" id = "search_text" placeholder="검색 후 엔터" onkeypress="if(event.keyCode == 13){search();}"/>
</div>

<table border = "1" class = "report_table">
	<colgroup>
		<col width = "20">
		<col width = "20">
		<col width = "100">
		<col width = "100">
		<col width = "50">
	</colgroup>
	<thead>
	<tr>
		<th scope = "col">신고번호</th>
		<th scope = "col">글번호</th>
		<th scope = "col">유저아이디</th>
		<th scope = "col">신고작성자</th>
		<th scope = "col">신고날짜</th>
	</tr>
	</thead>
	<c:forEach items = "${viewAll }" var = "list">
		<tr>
			<td class = "title">${list.reportSeq }</td>
			<td class = "title"><a href='/report_detail.do?seq=${list.jobSeq }'>${list.jobSeq }</a></td>
			<td class = "name">${list.userId }</td>
			<td class = "name">${list.reportWriter }</td>
			<td class = "date"><fmt:formatDate value="${list.reportDate }" pattern="yyyy.MM.dd"/> </td>
		</tr>
	</c:forEach>
</table>



<div style="display: block; text-align: center;">
	<c:choose>
		<c:when test = "${content != null}">
			<c:if test="${paging.startPage != 1 }">
			<a href="/report_search_admin.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&type=${type}&search_content=${content}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="/report_search_admin.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}&type=${type}&search_content=${content}">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="/report_search_admin.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&type=${type}&search_content=${content}">&gt;</a>
		</c:if>
		</c:when>
			
		<c:when test = "${content == null}">
			<c:if test="${paging.startPage != 1 }">
			<a href="/report_admin.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="/report_admin.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="/report_admin.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
		</c:if>
		</c:when>
	</c:choose>
	</div>
	
	<input type = "button" value = "리뷰" onclick = "location.href = '/review_write.do'"/>
	<input type = "button" value = "맵" onclick = "location.href = '/map.do'"/>
	
	
<%@ include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>