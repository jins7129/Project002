<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/header.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.js"></script>
<script type="text/javascript">
   $(function() {
     $('#summernote').summernote({
       height: 500,
       witdh : 200,
       
       //callback
       callbacks: {
			onImageUpload: function(files, editor, welEditable) {
	            for (var i = files.length - 1; i >= 0; i--) {
	            	sendFile(files[i], this);
	            }
	        }
		}
     });
     
     //upload function
     function sendFile(file, el) {
 		var form_data = new FormData();
       	form_data.append('file', file);
       	$.ajax({
         	data: form_data,
         	type: "POST",
         	url: 'insertTest.do',
         	cache: false,
         	contentType: false,
         	enctype: 'multipart/form-data',
         	processData: false,
         	success: function(img_name) {
           		$(el).summernote('editor.insertImage', img_name);
         	}
       	});
     }
   });
</script>
<body>

<textarea id="summernote"></textarea>

</body>
</html>