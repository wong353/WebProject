//이벤트 리스너 등록
/*document.addEventListener('DOMContentLoaded', function() {
	// 수량변경 - 이벤트 델리게이션으로 이벤트 종류 구분해 처리
	document.querySelectorAll('.item-control').forEach(
		function(item, idx) {
			//수량 입력 필드 값 변경
			item.querySelector('input').addEventListener('keyup', function() {
				basket.changePNum(idx + 1);
			});
			//수량 증가 화살표 클릭
			item.children[1].addEventListener('click', function() {
				basket.changePNum(idx + 1);
			});
			//수량 감소 화살표 클릭
			item.children[2].addEventListener('click', function() {
				basket.changePNum(idx + 1);
			});
		}
	);
});*/

// 천단위로 ,찍기
Number.prototype.format = function() {
	if (this == 0)
		return 0;
	var reg = /(^[+-]?\d+)(\d{3})/;
	var n = (this + '');
	while (reg.test(n))	n = n.replace(reg, '$1' + ',' + '$2');
	return n;
};
String.prototype.format = function() {
	var num = parseFloat(this);
	if (isNaN(num))
		return "0";
	return num.format();
};

let basic_amount = "<%=totalPrice%>";
function change_qty2(t) {
	//var min_qty = '수량버튼'*1;
	var min_qty = 1;
	var this_qty = $("#ct_qty").val() * 1;
	var max_qty = '200'; // 현재 재고
	if (t == "m") {
		this_qty -= 1;
		if (this_qty < min_qty) { //alert("최소구매수량 이상만 구매할 수 있습니다.");
			alert("수량은 1개 이상 입력해 주십시오.");
			return;
		}
	} else if (t == "p") {
		this_qty += 1;
		if (this_qty > max_qty) {
			alert("죄송합니다. 재고가 부족합니다.");
			return;
		}
	}
	var show_total_amount = basic_amount * this_qty;
	//$("#ct_qty_txt").text(this_qty);
	$("#ct_qty").val(this_qty);
	$("#it_pay").val(show_total_amount);
	$("#total_amount").html(show_total_amount.format());
}
