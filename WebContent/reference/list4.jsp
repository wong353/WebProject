<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ include file="/include/dbconn.jsp"%>

<%
	ResultSet rs2 = null;
PreparedStatement pstmt2 = null;

try {
	String count = "select count(*) from member";
	pstmt = conn.prepareStatement(count);
	rs = pstmt.executeQuery();
	int dbcount = 0; // DB에 들어있는 레코드 갯수
	if (rs.next()) {
		dbcount = rs.getInt(1);
		//rs.close();
	}

	/* 총페이지수 구하기  */
	int pagesize = 5; // 한페이지당 보여질 게시물 갯수
	int pagecount = 0; // 총페이지 갯수
	if (dbcount % pagesize == 0)
		pagecount = dbcount / pagesize;
	else
		pagecount = dbcount / pagesize + 1;

	/* absolutepage구하기 */
	int absolutepage = 1;
	int pagenum = 1; // 현재페이지번호
	if (request.getParameter("pagenum") != null) {
		pagenum = Integer.parseInt(request.getParameter("pagenum"));
		absolutepage = (pagenum - 1) * pagesize + 1;
	}
	String list = "select * from (select num,email,id,name,nickname,tel,homepage from member) member where num between ? and ? order by num desc";
	pstmt2 = conn.prepareStatement(list);
	pstmt2.setInt(1, absolutepage);
	pstmt2.setInt(2, absolutepage + pagesize);
	rs2 = pstmt2.executeQuery();
	rs2.next();
%>
<html>
<head>
<meta charset="EUC-KR">
<title>회원목록보기</title>
</head>
<body>
	<table border="1" width="700">
		<tr>
			<th>번호</th>
			<th>이메일</th>
			<th>아이디</th>
			<th>이름</th>
			<th>닉네임</th>
			<th>연락처</th>
			<th>홈페이지</th>
			<th>수정 / 삭제</th>
		</tr>
		<%
			int cnt = 0;
		int nums = absolutepage;
		while (cnt < pagesize) {
			int num = rs2.getInt("num");
			String email = rs2.getString("email");
			String id = rs2.getString("id");
			String name = rs2.getString("name");
			String nickname = rs2.getString("nickname");
			String tel = rs2.getString("tel");
			String homepage = rs2.getString("homepage");
		%>
		<tr>
			<td><%=nums++%></td>
			<td><%=email%></td>
			<td><%=id%></td>
			<td><%=name%></tsd>
			<td><%=nickname%></td>
			<td><%=tel%></td>
			<td><%=homepage%></td>
			<td><a href="modify.jsp?num=<%=num%>">수정</a> / <a
				href="delete.jsp?num=<%=num%>">삭제</a></td>
		</tr>
		<%
			if (!rs2.next())
			break;
		cnt++;
		}
		out.println("<tr><td colspan='8'>");

		/* 페이지 달기 */
		int limit = 3; // 보여질 페이지 갯수
		int startpage = pagenum - ((pagenum - 1) % limit); // 시작페이지
		if (startpage - limit > 0) {
		%>
		<a href="list4.jsp?pagenum=<%=pagenum - 1%>">◀</a>
		<%
			}
		for (int i = startpage; i < startpage + limit; i++) {
		%>
		<a href="list4.jsp?pagenum=<%=i%>"><%=i%></a>
		<%
			if (i >= pagecount)
			break;
		}
		if (startpage + limit <= pagecount) {
		%>
		<a href="list4.jsp?pagenum=<%=pagenum + 1%>">▶</a>
		<%
			}
		%>
	</table>
</body>
</html>
<%
	rs2.close();
rs.close();
pstmt2.close();
pstmt.close();
conn.close();
} catch (SQLException e) {
out.print(e);
}
%>