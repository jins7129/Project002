<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle</title>

	<link rel="icon" href="#">
	<link href="/resources/css/main.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Fira+Sans:300&display=swap" rel="stylesheet">

	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="/resources/js/main.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp" %>


	<!-- 메뉴 -->
	<div class="div">
		<div class="child1">
			<div class="menu">
				<a>&nbsp;</a>
				<div class="smallAll"></div>
			</div>
		</div>


		<div class="child2">
			<div class="menu">
				<a href="#" class="menuList">Offer</a>
				<div class="smallAll">
					<div>
						<a href="#" class="smallList">모아보기</a>
					</div>
					<div>
						<a href="#" class="smallList">지원하기</a>
					</div>
					<div>
						<a href="#" class="smallList">등록하기</a>
					</div>
				</div>
			</div>
		</div>


		<div class="child2">
			<div class="menu">
				<a href="#" class="menuList">Customize</a>
				<div class="smallAll">
					<div>
						<a href="#" class="smallList">그림그리기</a>
					</div>
				</div>
			</div>
		</div>


		<div class="child1">
			<div class="menu">
				<a>&nbsp;</a>
				<div class="smallAll"></div>
			</div>
		</div>
	</div>




	<!-- 해더 + 푸더 중간에 들어가는 친구들 -->
	<div id = "contents">
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<h3>About Us</h3>
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		
		<div class="goDownImg">
			<div class="goDownImgChild"><img id = "goDown" src="<c:url value = '/resources/images/icon_goDown.svg'/>"/></div>
		</div>
		
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<img id="mainImg" src="<c:url value = '/resources/images/main_image.jpg'/>"/>
		
		<div class="mainInfoDiv">
			<div class="mainInfoDivChild">
			<p class="mainInfo">
				소일거리나 심부름을 업무로 인정하지 않았던 과거와 달리,<br/> 개인주의와 개성주의가 발달하여 온 현재, 개개인의 행동 하나에 대한 가치가 높아졌습니다.<br/>
				이로 인해, 상대적으로 낮은 가치로 생각되는 심부름은 아무도 하지 않게 되었고,<br/> 대부분의 사람들은 높고 안정적인 수익을 지니고 있는 업무만을 찾게 되었습니다.<br/><br/>
				우리는 이러한 비대칭적인 사회현상을 타파하고자,<br/> 상대적으로 낮은 가치를 가진 심부름을 플랫폼화 시켜, 자유롭게 수행할 수 있는 프리랜서의 개념을 접목시키는 것입니다.<br/> 
				예를 들어 이동하는 동선에서 한 번에 여러 업무를 보거나,<br/> 특정 지역 반경 안에서 중복수주 할 수 있는 등의 프리랜서 개념을 효율적으로 이용하여, 낮은 가치로 인정받았던,<br/> 심부름 및 소일거리를 높은 가치의 업무로 변화시키는 것이 목표입니다.
			</p>
			</div>
		</div>
		
	</div>
	
	
	
	
	<!-- footer -->
	<div id = "footer"><%@ include file="/WEB-INF/views/footer.jsp" %></div>
	
	

</body>
</html>