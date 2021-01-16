<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/include/dbconn.jsp"%>

<%@include file="/include/loginSessionPass.jsp" %>

<%@include file="/include/header.jsp"%>

<%@include file="/include/QnA_IdCheck.jsp"%>
<%String y="yahee331"; %>
<table>
<%if(session.getAttribute("id").equals(url_id[2])){%>
<tr>
<td><%=session.getAttribute("id")%></td>
</tr>
<tr>
<td><%=url_id[2]%> </td>
</tr>
<%
}
%>
</table>
</body>
</html>