//이벤트 리스너 등록
document.addEventListener('DOMContentLoaded', function() {
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
});