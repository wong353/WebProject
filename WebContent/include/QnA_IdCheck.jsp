<%@page import="java.io.PrintWriter"%>
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
	String pageNo = request.getParameter("pg");
	if(pageNo.equals("") || pageNo == null) pageNo = "1";
	
	String url2 = request.getRequestURI().toString(); // url 을 문자열로 전환 
	if (request.getQueryString() != null) {
		url2 = request.getQueryString();
	}
	// split() 을 이용해 '='를 기준으로 문자열을 자른다.
	// split() 은 지정한 문자를 기준으로 문자열을 잘라 배열로 반환.
	// | 로 다수의 구분자로 나누기 가능 
	String url_id[] = url2.split("=|&");

	if (session.getAttribute("id").equals("admin")) {}
	else if (session.getAttribute("id").equals(url_id[3])) {}
	else {
%>
	<script type="text/javascript">
		alert('다른 사용자의 글입니다.');
		location.href=history.back(-1);
	</script>
<%
	}
	
	%>
</body>
</html>