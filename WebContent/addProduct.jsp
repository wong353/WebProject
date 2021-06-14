<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GARMENTDYING OFFICIAL SITE</title>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<link rel="stylesheet" type="text/css" href="stylesheet/fileButton_small.css">
<script type="text/javascript" src="./include/jquery-1.9.0.js"></script>
<script lang="javascript" type ="text/javascript" src ="./js/check_addProduct.js"></script>
<script type="text/javascript">
	$(function cateChange() {
		$("select[name=category]").change(function() {
			const temp = $("select[name=category2]");
			const a = $(this).val();
			temp.children().remove();
			temp.append('<option value="">선택</option>');

			if (a == 'top') {
				temp.append('<option value="mtm">mtm</option>');
				temp.append('<option value="shirts">shirts</option>');
				temp.append('<option value="t-shirts">t-shirts</option>');
				temp.append('<option value="hood">hood</option>');
			}
			if (a == 'bottom') {
				temp.append('<option value="pants">pants</option>');
				temp.append('<option value="shorts">shorts</option>');
			}
			if (a == 'outer') {
				temp.append('<option value="coat">coat</option>');
				temp.append('<option value="jacket">jacket</option>');
			}
		});
	});
</script>

<!-- 파일업로드명 변경 함수 -->
<script type="text/javascript">
			function nameChange(id) {	// this.id 파라미터로 받아오기
				id_sub = id.substring(id.lastIndexOf("e")+1);	// substring으로 파라미터 숫자만 남기기
				for(var i=1; i < 6; i++){
					if(id_sub == i){
						let box = ".filebox"+id_sub;	// 모든 class에 반복문 적용되도록 class name + parameter
						let fileTarget = $(box + ' .upload-hidden');
						fileTarget.on('change', function() { // 값이 변경되면
							if (window.FileReader) { // modern browser
								var filename = $(this)[0].files[0].name;
							} else { // old IE
								var filename = $(this).val().split('/').pop().split(
										'\\').pop(); // 파일명만 추출
							} // 추출한 파일명 삽입 
							$(this).siblings('.upload-name'+id_sub).val(filename);	//siblings(): 선택한 요소를 제외한 형제 요소를 모두 찾습니다.
							/* console.log("1: " + $(this).siblings('.upload-name'+id_sub).val()); */
							$('#img'+id_sub).val(filename);
							/* console.log("2: "+$('#img'+id_sub).val()); */
						});
					} 
				} 
			}
</script>

<!-- 파일업로드 삭제 함수 -->
<script>
	// 버튼 클릭 시 이미지 컨테이너, label 태그내의 이미지 명을 비워주기
	function del(clicked_id) {
		let i;
		for(i = 1; i < 6; i++){
			if(clicked_id == i){
				$("#ex_filename"+clicked_id).val("");
				$(".upload-name"+clicked_id).val("파일선택");
				$("#img"+clicked_id).val("");
			}
		}
		console.log($('#img'+clicked_id).val());
	};
</script>
</head>
<body>

<%@ include file = "/include/dbconn.jsp" %>

<%@include file="/include/admin.jsp" %>

<%@include file="/include/header.jsp" %>

<% 
	request.setCharacterEncoding("utf-8");
	try{
	String availableId = "";
	String idStr="";
	String availableId2 = "";
	int num;
	String sql = "SELECT MAX(p_id) as max FROM product";
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	// 여기부터해라
	/* if(rs.next()){ // P00010
		availableId = rs.getString("max");
			String idInt = availableId.substring(1);	// P제거
			num = Integer.parseInt(idInt);	
			out.print("<br>");
			out.println(idInt);
			out.print("<br>");
			out.println(num);
			if(num <= 8 && num > 0){	//P0008
				idInt = availableId.substring(availableId.lastIndexOf("0")+1);
				num = Integer.parseInt(idInt)+1;
				idStr = availableId.substring(0,4);	// 제일 끝 숫자 제외한 나머지 substring
				idStr += Integer.toString(num);	// 캐스팅 후 idStr과 결합
			}else if(num <= 98 && num > 0 || num == 9){
				
			}
			
			out.println(idStr);
			out.print("<br>");
			
			idStr += Integer.toString(num);	// 캐스팅 후 idStr과 결합
			out.println(num);
			out.print("<br>");
			out.println(idStr); */
			
		/*  else if(availableId.length()==6 || availableId.equals("P00099")){	// P00099 까지 
			String idInt = availableId.substring(4);	// 끝에 두자리 substring 
			idStr = availableId.substring(0,2);	// idInt 제외한 나머지 substring
			num = Integer.parseInt(idInt)+1;	// 안겹치게 +1
			idStr += Integer.toString(num);	// 캐스팅 후 idStr과 결합
		} else if(availableId.length()==7 || availableId.equals("P000999")){	// P000999 까지
			String idInt = availableId.substring(4);	// 제일 끝 숫자만 substring
			idStr = availableId.substring(0,1);	// idInt 제외한 나머지 substring
			num = Integer.parseInt(idInt)+1;	// 안겹치게 +1
			idStr += Integer.toString(num);	// 캐스팅 후 idStr과 결합
		} */
	//}
%>
<form name="newProduct" action="addProduct_process.jsp" enctype ="multipart/form-data" method="post">
	<table border="0">
		<caption><h3>상품 등록</h3></caption>
		<tr>	
			<td>상품아이디</td>
			<td><input type="text" name="id" id="id" value=<%=idStr%> ></td>
		</tr>
		<tr>
			<td>상품명</td>
			<td><input type="text" name="name" id="name"> </td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="text" name="unitPrice" id="unitPrice"> </td>
		</tr>
		<tr>
			<td>사이즈</td>
			<td>
				S<input type="checkbox" name="size" class="size" value="S">
				M<input type="checkbox" name="size" class="size" value="M">
				L<input type="checkbox" name="size" class="size" value="LAR">
				FREE<input type="checkbox" name="size" class="size" value="FREE">
			</td>
		</tr>
		<tr>
			<td>컬러</td>
			<td><input type="text" name="color" id="color"> </td>
		</tr>
		<tr>
			<td>상품 설명</td>
			<td><textarea name="description" id="description" placeholder="설명란"></textarea> </td>
		</tr>
		<tr>
			<td>분류</td>
			<td>
				<select id="category" name="category" onchange="cateChange()">
					<option value="">선택</option>
					<option value="top">top</option>
					<option value="bottom">bottom</option>
					<option value="outer">outer</option>
				</select>
				<select id="category2" name="category2">
					<option value="">선택</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>재고수</td>
			<td><input type="text" name="unitsInStock" id="unitsInStock"> </td>
		</tr>
		<tr>
			<td>상태</td>
			<td>
				NEW<input type="radio" name="condition" id="condition" value="new">
				OLD<input type="radio" name="condition" id="condition" value="old">
				EVENT<input type="radio" name="condition" id="condition" value="event">			
			</td>
		</tr>
		<tr>
				<td>썸네일</td>
				<td>
					<div class="filebox1">
						<input class="upload-name1" value="파일선택" readonly="readonly" name="thumbnailImg">
						<label for="ex_filename1">업로드</label> <input type="file" id="ex_filename1" class="upload-hidden" name="thumbnail2" accept="image/*" onclick="nameChange(this.id)">
						<label class="preview-del" id="1" onclick="del(this.id)">삭제</label>
					</div>
				</td>
			</tr>
			<tr>
				<td>상품디테일1</td>
				<td>
					<div class="filebox2">
						<input class="upload-name2" value="파일선택" readonly="readonly" name="detail1">
						<label for="ex_filename2">업로드</label> <input type="file" id="ex_filename2" class="upload-hidden" name="detail1_file" accept="image/*" onclick="nameChange(this.id)">
						<label class="preview-del" id="2" onclick="del(this.id)">삭제</label>
					</div>
				</td>
			</tr>
			<tr>
				<td>상품디테일2</td>
				<td>
					<div class="filebox3">
						<input class="upload-name3" value="파일선택" readonly="readonly" name="detail2">
						<label for="ex_filename3">업로드</label> <input type="file" id="ex_filename3" class="upload-hidden" name="detail2_file" accept="image/*" onclick="nameChange(this.id)">
						<label class="preview-del" id="3" onclick="del(this.id)">삭제</label>
					</div>
				</td>
			</tr>
			<tr>
				<td>상품디테일3</td>
				<td>
					<div class="filebox4">
						<input class="upload-name4" value="파일선택" readonly="readonly" name="detail3">
						<label for="ex_filename4">업로드</label> <input type="file" id="ex_filename4" class="upload-hidden" name="detail3_file" accept="image/*" onclick="nameChange(this.id)">
						<label class="preview-del" id="4" onclick="del(this.id)">삭제</label>
					</div>
				</td>
			</tr>
			<tr>
				<td>상품디테일4</td>
				<td>
					<div class="filebox5">
						<input class="upload-name5" value="파일선택" readonly="readonly" name="detail4">
						<label for="ex_filename5">업로드</label> <input type="file" id="ex_filename5" class="upload-hidden" name="detail4_file" accept="image/*" onclick="nameChange(this.id)">
						<label class="preview-del" id="5" onclick="del(this.id)">삭제</label>
					</div>
				</td>
			</tr>
		<tr>
			<td colspan="2"><input type="button" onclick="checkAddProduct()" value="입력"><input type="button" onclick="cancel()" value="취소"></td>
		</tr>
	</table>
</form>
<%@include file="/include/footer.jsp" %>
<%} catch(Exception e){
	e.getStackTrace();
	out.println(e.getMessage());
}finally{
	stmt.close();
	conn.close();
}
		
%>
</body>
</html>