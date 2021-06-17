<%@ page import="java.sql.*"%>
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
<script lang="javascript" type="text/javascript" src="./js/check_modifyProduct.js"></script>
<script type="text/javascript" src="./include/jquery-1.9.0.js"></script>
</head>
<body>
	<%@ include file="/include/dbconn.jsp"%>
	<%@ include file="/include/admin.jsp"%>
	<%@include file="/include/header.jsp"%>
	<%
		request.setCharacterEncoding("utf-8");

		String p_id = request.getParameter("p_id");
		String pg = request.getParameter("pg");
		try {
			String sql = "SELECT * FROM product WHERE p_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_id);
			rs = pstmt.executeQuery();
			String p_thumbnail = "";
			String thumbnail_sub = "";
			String p_fileName1 = "";
			String fileName1_sub = "";
			String p_fileName2 = "";
			String fileName2_sub = "";
			String p_fileName3 = "";
			String fileName3_sub = "";
			String p_fileName4 = "";
			String fileName4_sub = "";
			if (rs.next()) {
				String rp_id = rs.getString("p_id");
				String p_name = rs.getString("p_name");
				int p_unitPrice = rs.getInt("p_unitPrice");
				String p_size = rs.getString("p_size");
				String p_color = rs.getString("p_color");
				String p_description = rs.getString("p_description");
				
				// 카테고리
				String p_categorySub = rs.getString("p_category");
				String p_categoryTop = "";
				if (p_categorySub.equals("mtm") || p_categorySub.equals("shirts") || p_categorySub.equals("t-shirts")  || p_categorySub.equals("hood")) {
					p_categoryTop = "top";
				} else if (p_categorySub.equals("pants")  || p_categorySub.equals("shorts")) {
					p_categoryTop = "bottom";
				} else if (p_categorySub.equals("coat")  || p_categorySub.equals("jacket"))  {
					p_categoryTop = "outer";
				}
				// 
				
				String p_unitsInStock = rs.getString("p_unitsInStock");
				String p_condition = rs.getString("p_condition");
				
				// 상품 이미지
				if(rs.getString("p_thumbnail") != null){
					p_thumbnail = rs.getString("p_thumbnail");
					thumbnail_sub = p_thumbnail.substring(p_thumbnail.lastIndexOf("/")+1);
				}
				if(rs.getString("p_fileName_detail1") != null){
					p_fileName1 = rs.getString("p_fileName_detail1");
					fileName1_sub = p_fileName1.substring(p_fileName1.lastIndexOf("/")+1);
				}
				if(rs.getString("p_fileName_detail2") != null){
					p_fileName2 = rs.getString("p_fileName_detail2");
					fileName2_sub = p_fileName2.substring(p_fileName2.lastIndexOf("/")+1);
				}
				if(rs.getString("p_fileName_detail3") != null){
					p_fileName3 = rs.getString("p_fileName_detail3");
					fileName3_sub = p_fileName3.substring(p_fileName3.lastIndexOf("/")+1);
				}
				if(rs.getString("p_fileName_detail4") != null){
					p_fileName4 = rs.getString("p_fileName_detail4");
					fileName4_sub = p_fileName4.substring(p_fileName4.lastIndexOf("/")+1);
				}
				//
	%>
<!-- 자동 카테고리 변경 함수 -->
<script type="text/javascript">
	$(window).on('load',function(){
	    const temp = $("select[name=category2]");
		const a = $(category).val();
		let b = "<%=p_categorySub%>";
		temp.children().remove();
		temp.append('<option value="">선택 </option>');
			
		if (a == 'top') {
			temp.append("<option value='mtm'>mtm</option>");
			temp.append("<option value='shirts'>shirts</option>");
			temp.append("<option value='t-shirts'>t-shirts</option>");
			temp.append("<option value='hood'>hood</option>");
		}
		if (a == 'bottom') {
			temp.append("<option value='pants'>pants</option>");
			temp.append("<option value='shorts'>shorts</option>");
		}
		if (a == 'outer') {
			temp.append("<option value='coat'>coat</option>");
			temp.append("<option value='jacket'>jacket</option>");
		}
		$("#category2").val(b).prop("selected", true);
	});
</script>
<!-- 카테고리 변경 함수 -->
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
	<form name="modifyProduct" action="modifyPrd_ok.jsp?pg=<%=pg%>"
		enctype="multipart/form-data" method="post">
		<input type="hidden" value=<%if(p_thumbnail!=""||!p_thumbnail.equals("")){%><%=p_thumbnail%><%}%> name="img1" id="img1">
		<input type="hidden" value=<%if(p_fileName1!=""||!p_fileName1.equals("")){%><%=p_fileName1%><%}%> name="img2" id="img2">
		<input type="hidden" value=<%if(p_fileName2!=""||!p_fileName2.equals("")){%><%=p_fileName2%><%}%> name="img3" id="img3">
		<input type="hidden" value=<%if(p_fileName3!=""||!p_fileName3.equals("")){%><%=p_fileName3%><%}%> name="img4" id="img4">
		<input type="hidden" value=<%if(p_fileName4!=""||!p_fileName4.equals("")){%><%=p_fileName4%><%}%> name="img5" id="img5">
		
		<input type="hidden" value=<%=p_thumbnail%> name="imgOrigin1">
		<input type="hidden" value=<%=p_fileName1%> name="imgOrigin2">
		<input type="hidden" value=<%=p_fileName2%> name="imgOrigin3">
		<input type="hidden" value=<%=p_fileName3%> name="imgOrigin4">
		<input type="hidden" value=<%=p_fileName4%> name="imgOrigin5">
		
		<table border="0">
			<caption>
				<h3>상품 수정</h3>
			</caption>
			<tr>
				<td>상품아이디</td>
				<td><input type="text" name="id" id="id" value="<%=rp_id%>">
				</td>
			</tr>
			<tr>
				<td>상품명</td>
				<td><input type="text" name="name" id="name" value="<%=p_name%>"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="unitPrice" id="unitPrice" value="<%=p_unitPrice%>"></td>
			</tr>
			<tr>
				<td>사이즈</td>
				<td>S<input type="checkbox" name="size" class="size" value="S"
					<%if (p_size.indexOf("S") > 0) {%> checked <%}%>>
					M<input	type="checkbox" name="size" class="size" value="M"
					<%if (p_size.indexOf("M") > 0) {%> checked <%}%>>
					L<input	type="checkbox" name="size" class="size" value="L"
					<%if (p_size.indexOf("L") > 0) {%> checked <%}%>>
					FREE<input type="checkbox" name="size" class="size" value="FREE"
					<%if (p_size.indexOf("FREE") > 0) {%> checked <%}%>>
				</td>
			</tr>
			<tr>
				<td>컬러</td>
				<td><input type="text" name="color" id="color"
					value="<%=p_color%>"></td>
			</tr>
			<tr>
				<td>상품 설명</td>
				<td><textarea name="description" id="description"
						placeholder="설명란" value="<%=p_description%>"><%=p_description%></textarea>
				</td>
			</tr>
			<tr>
				<td>분류</td>
				<td>
					<select id="category" name="category" onchange="cateChange()">
 						<option value="">선택</option>
						<option value="top" <%if(p_categoryTop.equals("top")){%> selected <%}%>>top</option>
						<option value="bottom" <%if(p_categoryTop.equals("bottom")){%> selected <%}%>>bottom</option>
						<option value="outer" <%if(p_categoryTop.equals("outer")){%> selected <%}%>>outer</option>
					</select>
					<select id="category2" name="category2">
						<option value="">선택</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>재고수</td>
				<td>
					<input type="text" name="unitsInStock" id="unitsInStock" value="<%=p_unitsInStock%>">
				</td>
			</tr>
			<tr>
				<td>상태</td>
				<td>NEW<input type="radio" name="condition" id="condition"
					value="new" <%if (p_condition.equals("new")) {%> checked <%}%>>
					OLD<input type="radio" name="condition" id="condition" value="old"
					<%if (p_condition.equals("old")) {%> checked <%}%>>
					EVENT<input type="radio" name="condition" id="condition"
					value="event" <%if (p_condition.equals("event")) {%> checked
					<%}%>>
				</td>
			</tr>
			<tr>
				<td>썸네일</td>
				<td>
					<div class="filebox1">
						<input class="upload-name1" value=<%if(p_thumbnail!=""||!p_thumbnail.equals("")){%><%=p_thumbnail%><%}else{%>"파일선택"<%}%> readonly="readonly" name="thumbnailImg">
						<label for="ex_filename1">업로드</label> <input type="file" id="ex_filename1" class="upload-hidden" name="thumbnail2" accept="image/*" onclick="nameChange(this.id)">
						<label class="preview-del" id="1" onclick="del(this.id)">삭제</label>
					</div>
				</td>
			</tr>
			<tr>
				<td>상품디테일1</td>
				<td>
					<div class="filebox2">
						<input class="upload-name2" value=<%if(p_fileName1!=""||!p_fileName1.equals("")){%><%=p_fileName1%><%}else{%>"파일선택"<%}%> readonly="readonly" name="detail1">
						<label for="ex_filename2">업로드</label> <input type="file" id="ex_filename2" class="upload-hidden" name="detail1_file" accept="image/*" onclick="nameChange(this.id)">
						<label class="preview-del" id="2" onclick="del(this.id)">삭제</label>
					</div>
				</td>
			</tr>
			<tr>
				<td>상품디테일2</td>
				<td>
					<div class="filebox3">
						<input class="upload-name3" value=<%if(p_fileName2!=""||!p_fileName2.equals("")){%><%=p_fileName2%><%}else{%>"파일선택"<%}%> readonly="readonly" name="detail2">
						<label for="ex_filename3">업로드</label> <input type="file" id="ex_filename3" class="upload-hidden" name="detail2_file" accept="image/*" onclick="nameChange(this.id)">
						<label class="preview-del" id="3" onclick="del(this.id)">삭제</label>
					</div>
				</td>
			</tr>
			<tr>
				<td>상품디테일3</td>
				<td>
					<div class="filebox4">
						<input class="upload-name4" value=<%if(p_fileName3!=""||!p_fileName3.equals("")){%><%=p_fileName3%><%}else{%>"파일선택"<%}%> readonly="readonly" name="detail3">
						<label for="ex_filename4">업로드</label> <input type="file" id="ex_filename4" class="upload-hidden" name="detail3_file" accept="image/*" onclick="nameChange(this.id)">
						<label class="preview-del" id="4" onclick="del(this.id)">삭제</label>
					</div>
				</td>
			</tr>
			<tr>
				<td>상품디테일4</td>
				<td>
					<div class="filebox5">
						<input class="upload-name5" value=<%if(p_fileName4!=""||!p_fileName4.equals("")){%><%=p_fileName4%><%}else{%>"파일선택"<%}%> readonly="readonly" name="detail4">
						<label for="ex_filename5">업로드</label> <input type="file" id="ex_filename5" class="upload-hidden" name="detail4_file" accept="image/*" onclick="nameChange(this.id)">
						<label class="preview-del" id="5" onclick="del(this.id)">삭제</label>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" onclick="checkModifyProduct()" value="수정">
					<input type="button" onclick="cancel()" value="취소">
				</td>
			</tr>
		</table>
	</form>
	<%
		}
	} catch (Exception e) {
	out.println("실패");
	out.println(e.getMessage());
	} finally {
	if (rs != null)
	rs.close();
	if (pstmt != null)
	pstmt.close();
	if (conn != null)
	conn.close();
	}
	%>
	
	<%@include file="/include/footer.jsp"%>
</body>
</html>