<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp"%>



<h1> 결제가 정상적으로 완료되었습니다. </h1>
 
결제일시:     [[${kakaoInfo.approved_at}]]<br/>
주문번호:    [[${kakaoInfo.partner_order_id}]]<br/>
상품명:    [[${kakaoInfo.item_name}]]<br/>
상품수량:    [[${kakaoInfo.quantity}]]<br/>
결제금액:    [[${kakaoInfo.amount.total}]]<br/>
결제방법:    [[${kakaoInfo.payment_method_type}]]<br/>

<h2>${kakaoInfo }</h2>
 
<%@ include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>