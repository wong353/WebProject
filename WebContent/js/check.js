function check(){	
	// 이름 검증
	if (!member.name.value){
		alert("이름을 입력하세요!");
		member.name.focus();
		return false;
	}
	
	// 아이디 검증
	if(!member.id.value){
		alert("아이디를 입력하세요!");
		member.id.focus();
		return false;
	}
	
	/* var regType1 = /^[A-Za-z0-9+]{4,12}$/; */
	var regType1 = /(?=.*\d{1,12})(?=.*[a-zA-Z]{1,12}).{4,12}$/;
	if (!member.id.value.match(regType1)){
		alert('아이디는 영문과 숫자를 조합한 4~12자 까지 사용 가능합니다!');
		member.id.focus;
		return false;
	}
	
	if(member.notThisId.value == "idUncheck"){
		alert("아이디 중복 체크를 해주세요!");
		member.id.focus();
		return false;
	}
	 
	/* if(member.id.value == member.notThisId.value){
		alert("중복된 아이디 입니다!");
		member.id.focus();
		return false;
	}  */
	
	// 비밀번호 검증
	if (!member.pwd1.value){
		alert("비밀번호를 입력하세요!");
		member.pwd1.focus();
		return false;
	}
	
	// 비밀번호 확인
	if (!member.pwd2.value){
		alert("비밀번호 확인을 입력하세요!");
		member.pwd2.focus();
		return false;
	}
	
	// 비밀번호 일치 검증
	if (!(member.pwd1.value == member.pwd2.value)){
		alert("비밀번호가 일치하지 않습니다!");		
		member.pwd1.focus();
		return false;
	}
	
	// 비밀번호 조합
	var pwd = member.pwd1.value;
  	/*var reg1 = /^[A-Za-z0-9+]{4,12}$/; */
	var regPwd = /(?=.*\d{1,20})(?=.*[~`!@#$%\^&*()-+=]{1,20})(?=.*[a-zA-Z]{1,20}).{8,20}$/;
   
	if (!pwd.match(regPwd)){
		alert("비밀번호는 문자, 숫자, 특수문자를 포함한 8~20자리로 입력해주세요!");
		member.pwd1.focus="";
		return false;
	}		

	// 닉네임
	if (!member.nickname.value){
		alert("닉네임을 입력하세요!");
		member.nickname.focus();
		return false;
	}	
	
	// 이메일
	if(!member.email.value){
		alert("이메일을 입력하세요!");
		member.email.focus();
		return false;
	}
	
	// 생일
	if (!member.birthyear.value){
		alert("생일(연도)을 입력하세요!");
		return false;
	}		
	
	if (!member.birthmonth.value){
		alert("생일(월)을 입력하세요!");
		return false;
	}		
	
	if (!member.birthdate.value){
		alert("생일(일)을 입력하세요!");
		return false;
	}		
	
	// 우편번호
		if (!member.zip.value){
		alert("우편번호를 입력하세요!");
		return false;
	}	
	
	// 집주소
		if (!member.addr.value){
		alert("집주소를 입력하세요!");
		return false;
	}	
	
	// 상세주소
		if (!member.addr_detail.value){
		alert("상세주소를 입력하세요!");
		return false;
	}	
	
	// 휴대폰번호
		if (!member.tel1.value){
		alert("휴대폰 번호를 입력하세요!");
		member.tel.focus();
		return false;
	}	
		if (!member.tel2.value){
		alert("휴대폰 번호를 입력하세요!");
		member.tel.focus();
		return false;
	}	
		if (!member.tel3.value){
		alert("휴대폰 번호를 입력하세요!");
		member.tel.focus();
		return false;
	}	
	member.submit();
}