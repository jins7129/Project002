$(function() {
	
	

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
	
	

	
	
	// 화살표누르면 click function
	$(".mainInfo").hide();
	$("#goDown").on("click",function(e){
		
		e.preventDefault();
		
		// offset() : 절대 위치
		var offset = $("#mainImg").offset();
		 
		// 얼마만큼 내려갈거냐
		$('html, body').stop().animate( { scrollTop : 590 } );
		$(".mainInfo").fadeIn(2500);

	});


	
	

});