<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   response.setHeader("Pragma","no-cache");
   response.setHeader("Cache-control","no-store");
   response.setHeader("Expires","0");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<link rel="icon" href="#">

<link href="<c:url value = '/resources/css/header.css'/>"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Fira+Sans:300&display=swap"
	rel="stylesheet">


<script type="text/javascript"
	src="<c:url value = '/resources/js/header.js'/>"></script>

</head>
<body>

	<header>

		<!-- login * join을 ajax로 불러오는 부분 -->
		<div id="loginPage" style="background-color: #F7F7F7;"></div>


		<!-- 맨 위 추천 순위 1 ~ 10 -->
		<div id="ranking">
		</div>


		<!-- 마이페이지 + 장바구니 + css(부모태그 display: flex;) -->
		<div class="div">
			<div class="child1"></div>
			<div class="child2"></div>
			<div class="child3"></div>

			<div class="child2" id="mypage_mybag">
				<div class="parent">
					<div class="container1">
						<c:choose>
							<c:when test="${loginInfo.userStatus == 'ADMIN'}">
								<a href="report_admin.do" id="mypageTxt"><img id="mypage"
								src="<c:url value = '/resources/images/icon_rabit.svg'/>" />&nbsp;ADMIN
							Page</a>
							</c:when>
							<c:when test="${loginInfo.userStatus == 'USER'}">
								<a href="mypage_main.do" id="mypageTxt"><img id="mypage"
								src="<c:url value = '/resources/images/icon_rabit.svg'/>" />&nbsp;My
							Page</a>
							</c:when>
						</c:choose>
						<div class="overlay">
							<div class="rabitRunning">
								<img id="rabitRunning"
									src="<c:url value = '/resources/images/icon_rabitRunning.svg'/>" />
							</div>
						</div>
					</div>
					<div class="container2">
						<a href="#" id="mybagTxt"><img id="mybag"
							src="<c:url value = '/resources/images/icon_bag.svg'/>" />&nbsp;MyBag</a>
					</div>
				</div>
			</div>

			<div class="child1"></div>
		</div>




		<!-- 로고 + 검색창 + 로그인 + 사인업(회원가입) + css(부모태그 display: flex;) -->
		<div class="div">
			<div class="child1"></div>

			<div class="child2">
				<a href="main.do"><img id="logo"
					src="<c:url value = '/resources/images/icon_logo.svg'/>" /></a>&nbsp;&nbsp;&nbsp;
			</div>

			<div class="child3" id="searchBox">
				<a rel="tooltip" title=""><input type="text" name="inputSearch"
					id="inputSearch" placeholder="type to search" /></a> <img id="search"
					src="<c:url value = '/resources/images/icon_search.svg'/>" />&nbsp;&nbsp;<img
					id="search_image"
					src="<c:url value = '/resources/images/icon_search_image.svg'/>" />
			</div>

			<c:choose>
				<c:when test="${empty loginInfo }">
					<div class="child2" id="login_signup">
						<a id="login" href="javascript:void(0);">Login</a>&nbsp;&nbsp;&nbsp;<a
							id="signUp" href="signUp.do">Sign Up</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="child2" id="login_signup">
						<a id="logout" href="logout.do">Logout</a>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="child1"></div>
		</div>
		
		<!-- 메뉴 -->
	<div class="div">
		<div class="child1">
			<div class="Hmenu">
				<a>&nbsp;</a>
				<div class="smallAll"></div>
			</div>
		</div>

		<div class="child2">
			<div class="Hmenu">
				<a href="#" class="menuList">Offer</a>
				<div class="smallAll">
					<div>
						<a href="#" class="smallList">모아보기</a>
					</div>
					<div>
						<a href="main_insert.do" class="smallList">의뢰하기</a>
					</div>
				</div>
			</div>
		</div>


		<div class="child2">
			<div class="Hmenu">
				<a href="#" class="menuList">Other</a>
				<div class="smallAll">
					<div>
						<a href="editor.do" class="smallList">사진 편집</a>
					</div>
					<div>
						<a href="main_pay_main.do" class="smallList">결제 하기</a>
					</div>
				</div>
			</div>
		</div>


		<div class="child1">
			<div class="Hmenu">
				<a>&nbsp;</a>
				<div class="smallAll"></div>
			</div>
		</div>
	</div>

	</header>
	
	

</body>
</html>