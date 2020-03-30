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


<div id="my-image-editor" style="height: 800px">
    <canvas></canvas>
</div>
</body>
</html>