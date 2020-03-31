<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-image-editor/latest/tui-image-editor.css">
<script src="https://uicdn.toast.com/tui-image-editor/latest/tui-image-editor.js"></script>

<script type="text/javascript">
var imageEditor = new tui.component.ImageEditor('#my-image-editor canvas', {
    cssMaxWidth: 1000, // Component default value: 1000
    cssMaxHeight: 800  // Component default value: 800
});
mageEditor.loadImageFromURL('img/sampleImage.jpg', 'My sample image')

</script>
</head>
<body>

<div style="width: 500px; height: 400px;" align="center">
	<h2>
		<img alt="" src="resources/images/icon_logo.svg" style="width: 250px; height: 100px;"><br>
		<b>지금 바로 결제하세요!</b><br><br>
		<input type="button" value="결제하기" style="background-color:lime; border: none; width: 100px; height: 30px"><br><br>
		<b>1개월 무료체험 이후 </b>
		<h3>언제든지 취소가능</h3><br>
		<a href="">어쩌구저쩌구 블라블라 에헤이이히이힝히이</a>
	</h2>
</div>
<div id="my-image-editor" style="height: 800px">
    <canvas></canvas>
</div>
</body>
</html>