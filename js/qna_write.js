function formCheck() {
     
    if (!writeBoard.subject.value){      
        alert('제목을 입력하세요');           
        writeBoard.subject.value.focus();   
        return false;                       
    }
   
    if (!writeBoard.content.value){      
        alert('내용을 입력하세요');           
        writeBoard.content.value.focus();   
        return false;                       
    }
	var confirm_test = confirm("글을 쓰시겠습니까?");
	if(confirm_test==false){
		return false;
	}
   writeBoard.submit();
}