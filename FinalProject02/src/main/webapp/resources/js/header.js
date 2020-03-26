$(function() {

	// 검색 input 태그 호버
	$("#searchBox").hover(function() {
		$(this).css({
			"border-right" : "none",
			"border-left" : "none",
			"border" : "1.2px solid black"
		});
		$(this).parent("div").css("border-bottom", "none");
		$(this).siblings().css({
			"border-bottom" : "1px solid #d9d9d9",
			"border-top" : "1px solid #d9d9d9"
		});
		$(".div").first().css("border-bottom", "none");

	}, function() {
		$(this).css({
			"border" : "1px solid #d9d9d9",
			"border-top" : "none"
		});
		$(this).siblings().css("border-top", "none");
		$(".div").first().css("border-bottom", "1px solid #d9d9d9");

	});	
	

	// 검색 호버했을때 팝업으로 띄우는거
	$("a[rel='tooltip']").mouseover(
			function(e) {
				var tip = $(this).attr('title');
				$(this).attr('title', '');
				$(this).append(
						'<div id = "tooltip"><div class = "tipBody">' + tip
								+ '</div></div>');

			}).mousemove(function(e) {
		$("#tooltip").css('top', e.pageY + 10);
		$("#tooltip").css('left', e.pageX + 10);

	}).mouseout(function() {
		$(this).attr('title', $('.tipBody').html());
		$(this).children('div#tooltip').remove();
	});
	
	

	// 토끼 호버
	$(".container1").hover(function() {
		$("#mypage").css("display", "none");

	}, function() {
		$("#mypage").fadeIn();
	});

	// 실시간
	
	

	// header 해더 스크롤
	$(window).scroll(function() {
		var navbar = $(this).scrollTop();
		console.log(navbar);
		alert("asdf");
		$(".div").eq(1).css("border-bottom", "none");
		
	}, function(){
		$(".div").eq(1).css("border-bottom", "1px solid #d9d9d9");
		
	});
	
	

	// 로그인 ajax 불러오기
	$("#loginPage").css("display", "none");
	var loginPageCnt = 1;
	$("#login").click(function(){
		
		if (loginPageCnt == 1) {

			$("#loginPage").show();
			$("#loginPage").animate({
				'left' : "+=61%"
			});
			

			$.ajax({

				type : "post",
				url : "logins.do",
				dataType : "text",
				success : function(data) {

					$("#loginPage").html(data);

				},
				error : function() {
					alert("통신 실패");
				}

			});

			loginPageCnt++;

		} else {
			$("#loginPage").show();

			$('#loginPage').animate({
				'left' : "+=122%"
			});

			$.ajax({

				type : "post",
				url : "logins.do",
				dataType : "text",
				success : function(data) {

					$("#loginPage").html(data);

				},
				error : function() {
					alert("통신 실패");
				}

			});

			loginPageCnt++;
		}
	});
	// 메뉴 호버
	$(".menu div").css("display", "none");
	$(".menu").hover(
			function() {
				$(this).children("div").show();
				$(this).children("div").children("div").show().css({
					"background-color" : "black"
				});

				$(".menu").children("div").css("background-color", "black");
				$(".menu").not(this).children("div").show();
				$(".menu").not(this).children("div").children("div").show();
				$(".menu").not(this).children("div").children("div").css(
						"display", "none");

				$(this).parent("div").parent("div").css({
					"border-bottom" : "none",
					"background-color" : "black"
				});
				$(this).children(".menuList").css("text-decoration",
						"underline");
				$(".menu").children(".menuList").css("color", "#7f7f7f");
				$(this).children("a").css("color", "white");
				$(".smallList").css({
					"text-decoration" : "none",
					"color" : "#7f7f7f",
					"z-index" : "9999"
				});

			}, function() {
				$(this).parent("div").parent("div").css({
					"border-bottom" : "1px solid #d9d9d9",
					"background-color" : "white"
				});
				$(this).children("a").css("text-decoration", "none");
				$(".menu").children("a").css("color", "black");
				$(this).children("div").hide();
				$(this).children("div").children("div").hide();
				$(".menu").children("div").hide();
				$(".menu").children("div").children("div").hide();

			});
	
	

	// 메뉴 호버 했을때 리스트들을 호버했을때
	$(".smallList").hover(function() {
		$(".smallList").css({
			"color" : "#7f7f7f"
		});
		$(this).css({
			"text-decoration" : "underline",
			"color" : "white"
		});

	}, function() {
		$(".smallList").css("text-decoration", "none");

	});
	
	
	

});