<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>
<link rel="icon" href="/resources/images/icon.png" type="image/x-icon">
</head>
<body>
${dto.jobSeq }<br>
${dto.jobView }<br>
${dto.userId }<br>
${dto.jobTitle }<br>
${dto.jobStart } ~ 
${dto.jobDone }<br>
${dto.jobContent }<br>
${dto.jobDate }<br>

<%@ include file="/WEB-INF/views/header.jsp"%>

<div align="center" >

${jobInfo.jobContent }

</div>


<%@ include file="/WEB-INF/views/footer.jsp" %>

</body>
</html>