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
	
	

});