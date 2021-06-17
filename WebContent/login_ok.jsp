<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/dbconn.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	
	String preUrl = request.getParameter("preUrl");
	System.out.println(preUrl);
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");

	try {
		String sql = "SELECT userno,id,password,name FROM member WHERE id=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		PrintWriter script = response.getWriter();
		
		if(rs.next()){
			String userno = rs.getString("userno");
			String rid = rs.getString("id");
			String rpwd = rs.getString("password");
			String loginName = rs.getString("name");
			if (!id.equals(rid) || !pwd.equals(rpwd)){
				script.println("<script>");
				script.println("alert('아이디 혹은 비밀번호가 다릅니다.')");
				script.println("</script>");
				%>
				<form name="hiddenFrm" action="login.jsp"  method="post">
					<input type="text" name="preUrl" value=<%=preUrl%>>
				</form>
				<script type="text/javascript">
					document.hiddenFrm.submit();
				</script>
				<%
			} else{
				session.setAttribute("userno", userno);	//	유저 고유 번호
				session.setAttribute("id", id);	// 아이디
				session.setAttribute("loginName", loginName);	// 이름
				
				// 특정 쿠키만 삭제하기
			    Cookie eatCookie = new Cookie("saveUrlCk", null);
			    eatCookie.setMaxAge(0);
			    response.addCookie(eatCookie);
			    if(session.getAttribute("id").equals("admin") && preUrl.contains("mypage")){
			    	response.sendRedirect("userList.jsp");
			    }
				if(!preUrl.contains("mypage") && !preUrl.contains("join") && preUrl != null){
					response.sendRedirect(preUrl);
				}
				else if(preUrl.contains("mypage")){
					preUrl = preUrl + "?userno=" + userno;
					response.sendRedirect(preUrl);
				} else if(preUrl.contains("join.jsp") || preUrl.contains("join_process")){
					response.sendRedirect("main.jsp");
				} else if(preUrl.equals("") || preUrl.equals(null)){
					response.sendRedirect("main.jsp");
				} 
			}
		} else{	// rs.next() 가 없으면 
			script.println("<script>");
			script.println("alert('아이디 혹은 비밀번호가 틀렸습니다')");
			script.println("</script>");
			%>
			<form name="hiddenFrm" action="login.jsp"  method="post">	<!-- 주소에다가 값날리기 싫어서 폼으로 날리기 -->
				<input type="text" name="preUrl" value=<%=preUrl%>>
			</form>
			<script type="text/javascript">
				document.hiddenFrm.submit();
			</script>
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
	</body>
</html>