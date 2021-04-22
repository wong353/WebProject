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

	String header = request.getHeader("referer");
	int itemCount = Integer.parseInt(request.getParameter("itemCount"));
	itemCount++;
	response.sendRedirect(header);
	%>
	<form action="">
		<input type="hidden" value=<%=itemCount%>>
	</form>
	<script type="text/javascript">
		location.href = document.referrer;
		console.log(<%=itemCount%>);
		alert(<%=header%>);
	</script>
</body>
</html>


 
