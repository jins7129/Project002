$(function() {
	
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