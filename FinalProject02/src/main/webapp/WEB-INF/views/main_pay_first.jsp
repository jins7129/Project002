<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>
<link rel="icon" href="/resources/images/icon.png" type="image/x-icon">
<%@ include file="/WEB-INF/views/header.jsp"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style type="text/css">
#kakaoPayImg{
	cursor: pointer;
}

.payCheckbox{
	width:50px;
	
}
.bread{
	border-radius: 50px 10px 10px 50px;
	font-size: 20pt;
	
	color : #F87061;
}
.kakaoForm{
font-family: 'Fira Sans';
}

</style>
<script type="text/javascript">
	function chargeKakao(){
		var check = confirm("정말 결제하시겠습니까?");
		
		if(check == true){
			$(".kakaoForm").submit();
		} else {
			history.back();
		}
	}


</script>
</head>
<body>

<div align="center" style="margin:50px;" >
<form action="/main_pay_first.do" method="post" class="kakaoForm">
	<div><img src="/resources/images/bread64.png"/><br/><input type="text" class="bread" readonly="readonly" value="빵집" /></div>
	<table>
		<tr>
			<td>
				<div class="custom-control custom-radio">
						<input type="radio" id="jb-radio1" name="quantity" class="custom-control-input" value="100">
						<label class="custom-control-label" for="jb-radio1">bread 100개</label>
					</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="custom-control custom-radio">
						<input type="radio" id="jb-radio2" name="quantity" class="custom-control-input" value="200">
						<label class="custom-control-label" for="jb-radio2">bread 200개</label>
					</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="custom-control custom-radio">
						<input type="radio" id="jb-radio3" name="quantity" class="custom-control-input" value="500">
						<label class="custom-control-label" for="jb-radio3">bread 500개</label>
					</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="custom-control custom-radio">
						<input type="radio" id="jb-radio4" name="quantity" class="custom-control-input" value="1000">
						<label class="custom-control-label" for="jb-radio4">bread 1000개</label>
					</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="custom-control custom-radio">
						<input type="radio" id="jb-radio5" name="quantity" class="custom-control-input" value="2000">
						<label class="custom-control-label" for="jb-radio5">bread 2000개</label>
					</div>
			</td>
		</tr>
	
	</table>
	<br/>
	<img id="kakaoPayImg" src="/resources/Login/images/icons/kakaolink_btn_medium.png" onclick="chargeKakao();"/>
	

</form>
</div>

<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>