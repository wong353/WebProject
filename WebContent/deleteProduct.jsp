<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GARMENTDYING OFFICIAL SITE</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	String p_id = request.getParameter("p_id");
	String pg = request.getParameter("pg");
%>
	<script type="text/javascript">
		window.onload = function() {
			var check = confirm("삭제하시겠습니까?");
			if (check == true) {
				location.href="deleteProduct_process.jsp?p_id=<%=p_id%>&pg=<%=pg%>";
			}
			if (check == false) {
				history.back();
			}
		}
	</script>
</body>
</html>