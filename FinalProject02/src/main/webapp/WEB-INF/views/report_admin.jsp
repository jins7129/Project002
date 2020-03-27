<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
	function search(){
		var obj = document.getElementById('type');
		var search_type = obj.options[obj.selectedIndex].value;
		var search_content = document.getElementById('search').value;
		
		location.href = "/report_search_admin.do?type=" + search_type + "&search_content=" + search_content;
	}
</script>
</head>
<body>
<select id = "type">
	<option></option>
	<option value = "reportWriter">신고한 아이디</option>
	<option value = "userId">신고받은 아이디</option>
</select>
<input type = "text" id = "search" placeholder="검색 후 엔터" onkeypress = "if(event.keyCode == 13){search();}">

<table border = "1">
		<col width = "100">
		<col width = "100">
		<col width = "100">
		<col width = "100">
		<col width = "100">
	<tr>
		<th>신고번호</th>
		<th>글번호</th>
		<th>유저아이디</th>
		<th>신고작성자</th>
		<th>신고날짜</th>
	</tr>
	<c:forEach items = "${viewAll }" var = "list">
		<tr>
			<th>${list.reportSeq }</th>
			<th><a href='/report_detail.do?seq=${list.jobSeq }'>${list.jobSeq }</a></th>
			<th>${list.userId }</th>
			<th>${list.reportWriter }</th>
			<th><fmt:formatDate value="${list.reportDate }" pattern="yyyy.MM.dd"/> </th>
		</tr>
	</c:forEach>
</table>
<br/><br/><br/>
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
</body>
</html>