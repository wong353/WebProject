function check_login(){
	
	//아이디 
	if(!member.id.value){
		alert("아이디를 입력하세요!")
		member.id.focus();
		return false;
	}
	
	//비밀번호
	if(!member.pwd.value){
		alert("비밀번호를 입력하세요!")
		member.pwd.focus();
		return false;
	}
	member.submit();
}