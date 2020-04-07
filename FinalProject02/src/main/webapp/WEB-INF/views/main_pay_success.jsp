<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   response.setHeader("Pragma","no-cache");
   response.setHeader("Cache-control","no-store");
   response.setHeader("Expires","0");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>

<link rel="icon" href="/resources/images/icon.png" type="image/x-icon">
</head>
<style type="text/css">
#kakaoSuccessDiv{
}

.kakaoSuccessDivChild{
	text-align: left;
	width: 450px;
	padding : 15px;
	margin : 10px;
	border-radius: 15px 15px 15px 15px;
	background: #55acee;
	color: white;
}

</style>
<body>

<%@ include file="/WEB-INF/views/header.jsp"%>

<div align="center" id="kakaoSuccessDiv" >
<div style="background: #00bf8f;" class="kakaoSuccessDivChild">결제가 정상적으로 완료되었습니다. </div>
<div class="kakaoSuccessDivChild" style="height: 50px;" >결제일시<br/>
${kakaoInfo.approved_at}</div>
<div class="kakaoSuccessDivChild">주문번호 : 
${kakaoInfo.partner_order_id}<br/>
상품명 : 
${kakaoInfo.item_name}<br/>
상품수량 : 
${kakaoInfo.quantity}</div>
<div class="kakaoSuccessDivChild">결제금액 : 
${kakaoInfo.amount.total}<br/>
결제방법 : 
${kakaoInfo.payment_method_type}</div>
<div class="kakaoSuccessDivChild">현재  빵 갯수 : ${loginInfo.userCoin }개</div>

</div>
<%@ include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>