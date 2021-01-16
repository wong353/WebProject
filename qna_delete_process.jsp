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
	<%@ include file="/include/dbconn.jsp"%>

	<%
	request.setCharacterEncoding("utf-8");

	int pnum = Integer.parseInt(request.getParameter("num"));

	int pg = Integer.parseInt(request.getParameter("pg"));
	
	int ref = 0;

	try {
		// 해당 글에 답글이 있을 경우, 삭제된 글로 게시판에 보여지도록 수정하는 Query
		String parentPost = "SELECT ref,parent FROM board WHERE num = ?";
		pstmt = conn.prepareStatement(parentPost);
		pstmt.setInt(1, pnum);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			int parent = rs.getInt("parent");
			ref = rs.getInt("ref");
			if (parent == 1) {	// 하위에 답글을 포함하는 경우
				rs.close();
				pstmt.close();
				parentPost = "UPDATE board SET subject='삭제된 글입니다', content=0, hit=0, parent=2 where num=?";
				pstmt = conn.prepareStatement(parentPost);
				pstmt.setInt(1, pnum);
				pstmt.executeUpdate();
				pstmt.close();
				
				// 답글이 달린 글들이 모두 삭제 되었을 때 DB에서도 전부 삭제시키는 Query
				String compDelete = "SELECT count(*) FROM board WHERE ref = ? and (parent = 1 or parent = 0)"; // ref 집합의 parent 갯수를 count 
				pstmt = conn.prepareStatement(compDelete);
				pstmt.setInt(1, ref);
				rs = pstmt.executeQuery();
				 if (rs.next()) {
					int count = rs.getInt(1);
					if (count == 0) { // parent == 2 인 글밖에 없다는 말이므로 전부 삭제
						compDelete = "DELETE FROM board WHERE ref = ?"; // 해당 ref 글 모두 삭제
						pstmt = conn.prepareStatement(compDelete);
						pstmt.setInt(1, ref);
						pstmt.executeUpdate();
					}
				} 
				
				
			} else if (parent == 0) {	// 원글 또는 마지막 답글 일 때
				if (pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				
				// ref가 같은 모든 글이 parent == 2가 되면 삭제하는 쿼리
				String finalArrange = "SELECT ref FROM board WHERE num = ?";
				pstmt = conn.prepareStatement(finalArrange);
				pstmt.setInt(1, pnum);
				rs = pstmt.executeQuery();
				if(rs.next()){
					ref = rs.getInt("ref");
					finalArrange = "DELETE FROM board where num =?";
					pstmt = conn.prepareStatement(finalArrange);
					pstmt.setInt(1,pnum);
					pstmt.executeUpdate();
					finalArrange = "SELECT COUNT(*) FROM board WHERE ref = ? and (parent = 1 or parent = 0)";
					pstmt = conn.prepareStatement(finalArrange);
					pstmt.setInt(1, ref);
					rs = pstmt.executeQuery();
					if(rs.next()){
						int arr = rs.getInt(1);
						out.println(arr);
						if(arr==0){	// parent 가 0 또는 1인 ref가 하나라도 없으면 전부 삭제
							finalArrange = "DELETE FROM board where ref =?";
							pstmt = conn.prepareStatement(finalArrange);
							pstmt.setInt(1,ref);
							pstmt.executeUpdate();
						}
					}
				}
			}
		}
		
		// 정렬 쿼리		
		String arrange = "ALTER TABLE board AUTO_INCREMENT=1";
		pstmt.executeUpdate(arrange);

		String arrange2 = "SET @COUNT = 0;"; // count라는 변수를 선언 및 초기화(프로시저가 끝나도 계속 유지되는 값)
		pstmt.executeUpdate(arrange2);
		
		String arrange3 = "UPDATE board SET num = @COUNT:=@COUNT+1"; // := 는 왼쪽 피연산자에 오른쪽 피연산자를 대입함.
		pstmt.executeUpdate(arrange3);
		
		// ref2 필드로 ref 재정렬
		
		String sqlList = "SELECT num, ref2 FROM board WHERE indent=0 ORDER BY num DESC"; // 원글만 찾아서  역순으로 num, ref2 정렬
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sqlList);
			while (rs.next()) {
				int num = rs.getInt(1);
				out.println(num);
				int ref2 = rs.getInt(2);
				out.println(ref2);
				sqlList = "UPDATE board SET ref='"+num+"'where ref2='"+ref2+"'"; // 가족필드(ref2) 기준으로 조건을 주어 ref를 num으로 변경 
				stmt = conn.createStatement();
				stmt.executeUpdate(sqlList);
				
			}
	%>
		<script>
				alert("삭제에 성공했습니다.");
				document.location.href = "qna.jsp?pg=<%=pg%>";
		</script>
	<%
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e.getMessage());
		
	} finally {
		if(stmt!=null)stmt.close();
		pstmt.close();
	 	rs.close();
	}
	%>

</body>
</html>