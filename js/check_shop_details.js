'use strict';
function check_shop_detail() {

	// size 체크
	if (shop.p_size.value === "옵션 선택") {
		alert("사이즈를 선택해주세요!");
		return false;
	}
	const getId = '<%=u_id%>';
	if (!getId) {
		alert("로그인이 필요합니다");
		location.href = 'login.jsp';
	} else {
		document.shop.submit();
	}
}