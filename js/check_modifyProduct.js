function checkModifyProduct() {

	var productId = document.getElementById("id");
	var name = document.getElementById("name");
	var unitPrice = document.getElementById("unitPrice");
	var size = document.getElementsByName("size"); 
	var color = document.getElementById("color"); 
	var description = document.getElementById("description"); 
	var unitsInStock = document.getElementById("unitsInStock");
	var condition = document.getElementsByName("condition");
	
	// 상품아아디 체크
	if (!check(/^P[0-9]{4,11}$/, productId,"[상품 코드]\nP와 숫자를 조합하여 5~12자까지 입력하세요\n첫 글자는 반드시 P로 시작하세요"))
		return false;
		
	// 상품명 체크
	if (name.value.length < 4 || name.value.length > 50) {
		alert("[상품명]\n최소 4자에서 최대 50자까지 입력하세요");
		name.select();
		name.focus();
		return false;
	}
	
	// 상품 가격 체크
	if (unitPrice.value.length == 0 || isNaN(unitPrice.value)) {
		alert("[가격]\n숫자만 입력하세요");
		unitPrice.select();
		unitPrice.focus();
		return false;
	}
	
	if (unitPrice.value < 0) {
		alert("[가격]\n음수를 입력할 수 없습니다");
		unitPrice.select();
		unitPrice.focus();
		return false;
	} else if (!check(/^\d+(?:[.]?[\d]?[\d])?$/, unitPrice,	"[가격]\n소수점 둘째 자리까지만 입력하세요"))
		return false;
	
	// 상품 사이즈 체크	
	//getElementsByName을 써야 여러 값을 배열에 집어넣어서 값을 반환	
		var count=0;
						
	 	for (var i = 0; i < size.length; i++) {
			if (size[i].checked) count++;	
		}
		if(count==0){
			alert("[사이즈]\n사이즈를 체크하세요");
			return false;
		}
		
	/*if(size[0].checked == false && size[1].checked == false && size[2].checked == false && size[3].checked == false && size[4].checked == false ){
	alert("[사이즈]\n사이즈를 체크하세요");
		return false;
	}	*/

		
	// 상품 컬러 체크
	if(color.value==""){
		alert("[컬러]\n컬러란을 입력하세요");
		color.focus();
		return false;
	}
	
	// 상품 설명 체크
	if(description.value==""){
		alert("[설명]\n설명란을 입력하세요");
		description.focus();
		return false;
	}	
	
	// 상품 분류 체크
	
	if(!modifyProduct.category.value){
		alert("[분류]\n분류를 체크하세요");
		return false;
	}
				
	
	// 재고 수 체크
	if(unitsInStock.value==""){
		alert("[재고 수]\n재고량을 입력해주세요");
		unitsInStock.focus();
		return false;
	}
	if (isNaN(unitsInStock.value)) {
		alert("[재고 수]\n숫자만 입력하세요");
		unitsInStock.select();
		unitsInStock.focus();
		return false;
	}
	
	
	// 상품 상태 체크
	var count3=0;
		
        for (var i = 0; i < condition.length; i++) {
            if (condition[i].checked) count3++;	
        }

		if(count3==0){
			alert("[상태]\n상태를 체크하세요");
			return false;
		}
	
		
	function check(regExp, e, msg) {

		if (regExp.test(e.value)) {
			return true;
		}
		alert(msg);
		e.select();
		e.focus();	
		return false;
	}

	 document.modifyProduct.submit()
}
function cancel(){
	if(confirm("입력하신 내용은 저장되지 않습니다. 상품 페이지로 돌아가시겠습니까?")){
		location.href="productList.jsp"; 
	}
}

