 function replyCheck() {
		var form = document.replyForm;
		if (!form.content.value) {
			alert("내용을 적어주세요!");
			form.content.focus();
			return;
		}
		form.submit();
	}