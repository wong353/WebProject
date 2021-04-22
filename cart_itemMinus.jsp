<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	int itemCount = Integer.parseInt(request.getParameter("itemCount"));
	itemCount--;
%>
	<script type="text/javascript">
		location.href = document.referrer;
	</script>
%>