<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>썸네일 만들기</title>
<style type="text/css">
.thumb {
	width: 100px;
	height: 100px;
	margin: 0.2em -0.7em 0 0;
}

.remove_img_preview {
	position: relative;
	top: -25px;
	right: 5px;
	background: black;
	color: white;
	border-radius: 50px;
	font-size: 0.9em;
	padding: 0 0.3em 0;
	text-align: center;
	cursor: pointer;
}
</style>
</head>
<script type="text/javascript" src="jquery-1.9.0.js"></script>
<!-- <script>
	function setThumbnail(event) {
		var reader = new FileReader();
		reader.onload = function(event) {
			var img = document.createElement("img");
			img.setAttribute("src", event.target.result);
			document.querySelector("div#image_container").appendChild(img);
		};
		reader.readAsDataURL(event.target.files[0]);
	}
</script> -->
<body>
	<div class="file-wrapper flie-wrapper-area">
		<div class="float-left">
			<span class="label-plus"><i class="fas fa-plus"></i></span> <input
				type="file" name="file" id="file" class="upload-box upload-plus"
				accept="image/*">
			<div id="preview"></div>
			<div class="file-edit-icon">
				<a href="#" class="preview-edit">수정</a>
				<a href="#" class="preview-de">삭제</a>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		console.log()
		function handleFileSelect(event) {
			var input = this;
			console.log(input.files)
			if (input.files && input.files.length) {
				var reader = new FileReader();
				this.enabled = false
				reader.onload = (function(e) {
					console.log(e)
					$("#preview").html(
							[ '<img class="thumb" src="', e.target.result,
									'" title="', escape(e.name), '"/>' ]
									.join(''))
				});
				reader.readAsDataURL(input.files[0]);
			}
		}
		/* $('#file').change(handleFileSelect); */
		$('.file-edit-icon').on('click', '.preview-de', function() {
			$("#preview").empty()
			$("#file").val("");
		});
		$('.preview-edit').click(function() {
			$("#file").click();
		});
	</script>

</body>

</html>