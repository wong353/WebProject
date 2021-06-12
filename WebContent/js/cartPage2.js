//이벤트 리스너 등록
document.addEventListener('DOMContentLoaded', function() {
	// "선택 상품 삭제" 버튼 클릭
	document.querySelector('.cart-info-box a:first-child').addEventListener('click', function() {
		cart-info-box.delCheckedItem();
	});
	// "장바구니 비우기" 버튼 클릭
	document.querySelector('.cart-info-box a:nth-child(2)').addEventListener('click', function() {
		cart-info-box.delAllItem();
	});
	// 장바구니 행 "삭제" 버튼 클릭
	document.querySelectorAll('.basketcmd a').forEach(
		function(item) {
			item.addEventListener('click', function() {
				basket.delItem();
			});
		}
	);
	// 수량변경 - 이벤트 델리게이션으로 이벤트 종류 구분해 처리
	document.querySelectorAll('.updown').forEach(
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
	//앵커 # 대체해 스크롤 탑 차단
	document.querySelectorAll('a[href="#"]').forEach(function(item) {
		item.setAttribute('href', 'javascript:void(0)');
	});
});