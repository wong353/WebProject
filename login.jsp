<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<meta charset="UTF-8">
<title>회원 로그인</title>
<script language="javascript" type="text/javascript" src="./js/check_login.js"></script>
</head>

<style type="text/css">
table {
	padding-top:100px;
	width: 50%;
	margin: auto;
	padding-bottom:100px;
}

</style>

<%@ include file = "include/loginSessionExist.jsp" %>

<%@ include file = "include/header.jsp" %>


		<form action="login_ok.jsp" method="post" name="member">
			<table>
				<caption>LOGIN</caption>
				<tr>
					<td>ID<br> <input type="text" name="id"></td>
					<td><a href="join.jsp"><span>간편 회원가입</span></a></td>
				</tr>
				<tr>
					<td>PASSWORD<br> <input type="password" name="pwd"></td>
					<td><a href="pwd_forget.jsp">SNS회원가입</a></td>
				</tr>
				<tr>
					<td colspan="2"><a href="pwd_forget.jsp">아이디 찾기</a> &nbsp |
						&nbsp <a href="pwd_forget.jsp">비밀번호 찾기</a></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" onclick="check_login()" value="LOGIN"></td>
				</tr>
			</table>
		</form>
		
		
		<%@ include file = "/include/footer.jsp" %>
</body>
</html>