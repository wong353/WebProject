<%@page import="java.util.Arrays"%>
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
<body>
<%@ include file = "include/dbconn.jsp" %>
<%@ include file = "include/loginSessionExist.jsp" %>
<%@ include file = "include/header.jsp" %>
<%!
	public String setDefault(String str) {
		if (str == null)
			return "";
		else
			return str;
	}

	public String getCookieValue(Cookie[] cookies, String cookieName) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(cookieName)) {
				return cookie.getValue();
			}
		}
		return "";
	}

	public boolean cookieExist(Cookie[] cookies, String cookieName) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(cookieName)) {
				return true;
			}
		}
		return false;
	}

	public String getCookieName(Cookie[] cookies, String cookieName) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(cookieName)) {
				return cookieName;
			}
		}
		return "";
	}
%>
<%
		String preUrl = setDefault(request.getHeader("referer"));	// 전 페이지의 주소
		String preUrl_login = request.getParameter("preUrl");
		/* if(preUrl.equals(null)) preUrl = "main.jsp"; */
		// String webUrl = request.getServerName().toString(); 서버 이름 가져오기
		String webUrl2 = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
		// getScheme: http return | getServerName: www.localhost return | getServerPort: port num return(8080)
		if(preUrl.equals(webUrl2 + "/MyWeb/login_ok.jsp") && webUrl2 != null) preUrl = preUrl_login;
		
		Cookie urlCookie = new Cookie("urlCookie", preUrl); // create cookie
		urlCookie.setComment("store login.jsp url due to multiple click");	// comment
		urlCookie.setMaxAge(60*60*24);	// valid time
		response.addCookie(urlCookie);
		
	 	Cookie[] cookies = request.getCookies();
	    String ckVal = getCookieValue(cookies, "urlCookie");
	    boolean ckExist = cookieExist(cookies,"saveUrlCk");
	    
	    if(ckExist == false){	// saveUrlCk 가 없으면
	    	
	    	Cookie saveUrlCk = new Cookie("saveUrlCk", preUrl);
			response.addCookie(saveUrlCk);
			System.out.println("생성 완료!");
	    	
	    } else {	// // saveUrlCk 가 있으면
	    	
	    	System.out.println("이미 생성된 쿠키입니다.");
			if(preUrl.equals(webUrl2+"/MyWeb/login.jsp")){
	    	System.out.println("login.jsp 두 번 클릭");
			preUrl = getCookieValue(cookies, "saveUrlCk");
			
			}
	    }
	    
	    for(int i=0; i<cookies.length; i++ ){
	    	System.out.println("========");
	    	System.out.println(cookies.length);
	    	System.out.println("쿠키이름:" + cookies[i].getName());
	    	System.out.println("쿠키 값:" + cookies[i].getValue());
	    	System.out.println("========");
    	}
    /* TODO: 쿠키 삭제
     
    	// 전체 쿠키 삭제하기
     
    if(cookies != null){
        for(int i=0; i < cookies.length; i++){
             
            // 쿠키의 유효시간을 0으로 설정하여 만료시킨다
            cookies[i].setMaxAge(0) ;
             
            // 응답 헤더에 추가한다
            response.addCookie(cookies[i]) ;
        }
        System.out.println("삭제완료");
    }
     
    	// 특정 쿠키만 삭제하기
    Cookie kc = new Cookie("memberNo", null) ;
    kc.setMaxAge(0) ;
    response.addCookie(kc) ;  */

	/* TODO: URL 관련 함수
	Context : request.getContextPath()
	URL : request.getRequestURL()
	URI :  request.getRequestURI() 
	Path :  request.getServletPath()
	*/
%>

	<div id="main-contents">
		<div id="content">
			<form action="login_ok.jsp" method="post" name="member">
			<input type="hidden" name="preUrl" value=<%=preUrl%>>
				<table>
					<caption>LOGIN</caption>
					<tr>
						<td>ID<br> <input type="text" name="id"></td>
						<td><a href="join.jsp"><span>간편 회원가입</span></a></td>
					</tr>
					<tr>
						<td colspan="2">PASSWORD<br> <input type="password" name="pwd"></td>
						<!-- <td><a href="pwd_forget.jsp">SNS회원가입</a></td> -->
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
		</div>
	</div>
	
	<%@ include file = "/include/footer.jsp" %>

</body>
</html>