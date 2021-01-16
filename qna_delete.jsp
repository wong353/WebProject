<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	String num = request.getParameter("num");
	
	int pg = Integer.parseInt(request.getParameter("pg"));
%>
	<script type="text/javascript">
		window.onload = function() {
			var check = confirm("삭제하시겠습니까?");
			if (check == true) {
				location.href="qna_delete_process.jsp?num=<%=num%>&pg=<%=pg%>";
			}
			if (check == false) {
				history.back();
			}
		}
	</script>
</body>
</html>