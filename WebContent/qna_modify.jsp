<%@ include file="/include/QnA_IdCheck.jsp"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.*"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA</title>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<link rel="stylesheet" type="text/css" href="stylesheet/qna_modify.css">
<link rel="stylesheet" type="text/css" href="stylesheet/qna_write.css">
<link rel="stylesheet" type="text/css" href="stylesheet/fileButton.css">
<style type="text/css">
</style>
<script type="text/javascript" src="./include/jquery-1.9.0.js"></script>
<script type="text/javascript" src="./js/qna_modify.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				var fileTarget = $('.filebox .upload-hidden');
				fileTarget.on('change', function() { // 값이 변경되면
					if (window.FileReader) { // modern browser
						var filename = $(this)[0].files[0].name;
					} else { // old IE
						var filename = $(this).val().split('/').pop().split(
								'\\').pop(); // 파일명만 추출
					} // 추출한 파일명 삽입 
					$(this).siblings('.upload-name').val(filename);	//siblings(): 선택한 요소를 제외한 형제 요소를 모두 찾습니다.
					// 이미지 컨테이너 및 input file 초기화
					$("div#image_container").empty()
				});
			});
</script>
<script>
	// 이미지 업로드 간에 미리보기 
	function setThumbnail(event) {
		let reader = new FileReader();
		reader.onload = function(event) {
			let img = document.createElement("img");
			img.setAttribute("src", event.target.result);
			document.querySelector("div#image_container").appendChild(img);
		};
		reader.readAsDataURL(event.target.files[0]);
	}
</script>
<script>
	// 버튼 클릭 시 이미지 컨테이너, label 태그내의 이미지 명을 비워주기
	function del() {
		$("div#image_container").empty()
		$("#ex_filename").val("");
		$(".upload-name").val("");
	};
</script>
</head>
<body>

<%@ include file="/include/dbconn.jsp"%>

<%@include file="/include/loginSessionPass.jsp" %>

<%@include file="/include/header.jsp"%>

<%
	request.setCharacterEncoding("utf-8");

	int pg = Integer.parseInt(request.getParameter("pg"));
	
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

	String num = request.getParameter("num");
	String nowDate = sf.format(nowTime); // 현재 날짜
	String thumbnail="";
	String thumb_sub1="";
	try {
		String sql = "SELECT * FROM board WHERE num=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, num);
		rs = pstmt.executeQuery();

		if (rs.next()) {
		String postNo = rs.getString("num");
		String subject = rs.getString("subject");
		String rid = rs.getString("id");
		String name = rs.getString("name");
		String content = rs.getString("content");
		if (rs.getString("thumbnail") != null){
			thumbnail = rs.getString("thumbnail");
			thumb_sub1 = thumbnail.substring(thumbnail.lastIndexOf("/")+1); // 파일 명만 나오도록 substring */
		}
		String regiDate = rs.getString("regist_day");
%>
<form name="modifyForm" method="post" enctype="multipart/form-data" action="qna_modify_process.jsp?num=<%=num%>&id=<%=id%>&pg=<%=pg%>">
	<input type="hidden" value="<%=sf.format(nowTime)%>" name="dateNow"> 
	<input type="hidden" value=<%=thumbnail%> name="imgOrigin"> 
	<input type="hidden" value=<%=thumb_sub1%> name="imgOriginSub"> 
	<table>
		<tr>
			<td>
				<label class="write-title">SUBJECT:</label>
			</td>
			<td>
				<input type="text" name="subject" value="<%=subject%>" class="text-area">
			</td> 
		</tr>
		<tr>
			<td>
				<label class="write-title">NAME:</label>
			</td>
			<td>
				<input type="text" name="name" value="<%=name%>" class="text-area" readonly="readonly">
			</td> 
		</tr>
		<tr>
			<td>
				<label class="write-title">CONTENT:</label>
			</td>
			<td>
				<%if(thumbnail!=null){%>
					<div id="image_container"><img alt="" src="<%=thumbnail%>"></div>
				<%}%>
				<br> 	
				<textarea rows="10" cols="30" name="content" id="content"><%=content%></textarea> 

				<div class="filebox">
					<input class="upload-name" id="upload-name" value=<%if(thumb_sub1!=""||!thumb_sub1.equals("")){%><%=thumb_sub1%><%}else{%>"파일선택"<%}%> readonly="readonly" name="thumbnail2">
					<label for="ex_filename">업로드</label> <input type="file" id="ex_filename" class="upload-hidden" name="thumbnail1" accept="image/*" onchange="setThumbnail(event);">
					<label class="preview-del" onclick="del()">삭제</label>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<div id="bot-btn-wrapper">
				<input type="button" value="수정" class="button" onclick="modifyCheck();">
				<input type="button" value="취소" class="button" onclick="history.back(-1);">
			</div>
			</td>
		</tr>
	</table>
</form>
<%
		}
	} catch (Exception e){
		e.printStackTrace();
		out.println(e.getMessage());
	} finally{
		if(rs!=null) rs.close();
		if(pstmt!=null) pstmt.close();
		if(conn!=null) conn.close();
	}
%>

<%@include file="/include/footer.jsp"%>
</body>
</html>