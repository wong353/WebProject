<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ include file = "reference/addressAPI.jsp" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<link rel="stylesheet" type="text/css" href="stylesheet/mypage.css">
<style type="text/css">
	.select_birthday{
		disabled: disabled;
	}
</style>
<meta charset="UTF-8">
<title>회원정보수정</title>
<script lang="javascript" type="text/javascript" src="./js/check_mypage.js"></script>

<script type="text/javascript">

function tel_auto(){
	if(member.tel1.value.length==3){
		member.tel2.focus();
	}
	if (member.tel2.value.length==4){
		member.tel3.focus();
	}
}

</script>


</head>

<style type="text/css">
table {
	padding-top: 100px;
	margin: 0 auto;
} 

</style>

<body>
	<%@include file = "/include/dbconn.jsp" %>
	
	<%@include file="/include/loginSessionPass.jsp" %>

	<%@include file="/include/header.jsp" %>

			<div id="join-caption">
				<h4>회원정보 입력</h4>
			</div>
			
			<%
			request.setCharacterEncoding("utf-8");
			
			String ruserno = request.getParameter("userno");
			String pg = "";
			if(request.getParameter("pg")!=""){
				pg = request.getParameter("pg");
			}
			try{
			String sql = "SELECT * FROM member WHERE userno=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ruserno);
			rs = pstmt.executeQuery();
			while(rs.next()){
				String name = rs.getString("name");		
				String rid= rs.getString("id");	
				String password = rs.getString("password");	
				String nickname = rs.getString("nickname");	
				String email = rs.getString("email");	
				String birthday = rs.getString("birthday");	
				String birthYear = birthday.substring(0,4);
				String birthMonth = birthday.substring(4,6);
				String birthDay = birthday.substring(6);
				String zip = rs.getString("zip");	
				String addr = rs.getString("addr");	
				String addr_detail = rs.getString("addr_detail");	
				String addr_ref = rs.getString("addr_ref");	
				String tel = rs.getString("tel");
				String tel1 = tel.substring(0, 3);
				String tel2 = tel.substring(3, 7);
				String tel3 = tel.substring(7);
			%>	
			<form action="mypage_process.jsp?pg=<%=pg%>" method="post" name="member">
			<input type="hidden" name="userno" value="<%=ruserno%>">
				<div id="join-wrapper">
					<div id="join-table">
						<table border="0">
							<tr>
								<td>*이름</td>
								<td colspan="2"><%=name%></td>
							</tr>
							<tr>
								<td>*아이디</td>
								<td colspan="2"><%=rid%></td>
							</tr>
							<tr>
								<td>*비밀번호</td>
								<td colspan="2"><input type="password" name="pwd1" id="pwd1" value="<%=password%>"></td>
							</tr>
							<tr>
								<td>*비밀번호 확인</td>
								<td colspan="2"><input type="password" name="pwd2" id="pwd2" value="<%=password%>"></td>
							</tr>
							<tr>
								<td>*닉네임</td>
								<td colspan="2"><input type="text" name="nickname" id="nickname" value="<%=nickname%>"></td>
							</tr>
							<tr>
								<td>*이메일</td>
								<td colspan="2"><input type="text" name="email" id="email" value="<%=email%>"></td>
							</tr>
							<div class="birth">
								<tr>
									<td>*생일</td>
									<td colspan="2"><select name="birthyear" class="select_birthday" value="<%=birthYear%>">
											<option value="">선택</option>
											<%
												int i = 0;
												for(i = 1932; i <= 2021; i++){
													String i2 = String.valueOf(i);
											%>	<option value="<%=i%>" <% if(birthYear.equals(i2)) { %> selected <%} %>><%=i%></option>
											<%
												}
											%>
											
									</select>년
									<select name="birthmonth" class="select_birthday" value="<%=birthMonth%>">
											<option value="">선택</option>
											<option value="01" <% if(birthMonth.equals("01")) { %> selected <% }%>>1</option>
											<option value="02" <% if(birthMonth.equals("02")) { %> selected <% }%>>2</option>
											<option value="03" <% if(birthMonth.equals("03")) { %> selected <% }%>>3</option>
											<option value="04" <% if(birthMonth.equals("04")) { %> selected <% }%>>4</option>
											<option value="05" <% if(birthMonth.equals("05")) { %> selected <% }%>>5</option>
											<option value="06" <% if(birthMonth.equals("06")) { %> selected <% }%>>6</option>
											<option value="07" <% if(birthMonth.equals("07")) { %> selected <% }%>>7</option>
											<option value="08" <% if(birthMonth.equals("08")) { %> selected <% }%>>8</option>
											<option value="09" <% if(birthMonth.equals("09")) { %> selected <% }%>>9</option>
											<option value="10" <% if(birthMonth.equals("10")) { %> selected <% }%>>10</option>
											<option value="11" <% if(birthMonth.equals("11")) { %> selected <% }%>>11</option>
											<option value="12" <% if(birthMonth.equals("12")) { %> selected <% }%>>12</option>
											
									</select>월
									<select name="birthdate" class="select_birthday" value="<%=birthDay%>">
											<option value="">선택</option>
											<option value="01" <% if(birthDay.equals("01")) { %> selected <% }%>>1</option>
											<option value="02" <% if(birthDay.equals("02")) { %> selected <% }%>>2</option>
											<option value="03" <% if(birthDay.equals("03")) { %> selected <% }%>>3</option>
											<option value="04" <% if(birthDay.equals("04")) { %> selected <% }%>>4</option>
											<option value="05" <% if(birthDay.equals("05")) { %> selected <% }%>>5</option>
											<option value="06" <% if(birthDay.equals("06")) { %> selected <% }%>>6</option>
											<option value="07" <% if(birthDay.equals("07")) { %> selected <% }%>>7</option>
											<option value="08" <% if(birthDay.equals("08")) { %> selected <% }%>>8</option>
											<option value="09" <% if(birthDay.equals("09")) { %> selected <% }%>>9</option>
											<option value="10" <% if(birthDay.equals("10")) { %> selected <% }%>>10</option>
											<option value="11" <% if(birthDay.equals("11")) { %> selected <% }%>>11</option>
											<option value="12" <% if(birthDay.equals("12")) { %> selected <% }%>>12</option>
											<option value="13" <% if(birthDay.equals("13")) { %> selected <% }%>>13</option>
											<option value="14" <% if(birthDay.equals("14")) { %> selected <% }%>>14</option>
											<option value="15" <% if(birthDay.equals("15")) { %> selected <% }%>>15</option>
											<option value="16" <% if(birthDay.equals("16")) { %> selected <% }%>>16</option>
											<option value="17" <% if(birthDay.equals("17")) { %> selected <% }%>>17</option>
											<option value="18" <% if(birthDay.equals("18")) { %> selected <% }%>>18</option>
											<option value="19" <% if(birthDay.equals("19")) { %> selected <% }%>>19</option>
											<option value="20" <% if(birthDay.equals("20")) { %> selected <% }%>>20</option>
											<option value="21" <% if(birthDay.equals("21")) { %> selected <% }%>>21</option>
											<option value="22" <% if(birthDay.equals("22")) { %> selected <% }%>>22</option>
											<option value="23" <% if(birthDay.equals("23")) { %> selected <% }%>>23</option>
											<option value="24" <% if(birthDay.equals("24")) { %> selected <% }%>>24</option>
											<option value="25" <% if(birthDay.equals("25")) { %> selected <% }%>>25</option>
											<option value="26" <% if(birthDay.equals("26")) { %> selected <% }%>>26</option>
											<option value="27" <% if(birthDay.equals("27")) { %> selected <% }%>>27</option>
											<option value="28" <% if(birthDay.equals("28")) { %> selected <% }%>>28</option>
											<option value="29" <% if(birthDay.equals("29")) { %> selected <% }%>>29</option>
											<option value="30" <% if(birthDay.equals("30")) { %> selected <% }%>>30</option>
											<option value="31" <% if(birthDay.equals("31")) { %> selected <% }%>>31</option>
											
									</select>일</td>
								</tr>
							</div>
							
							<tr>
								<td>*우편번호</td>
								<td colspan="2"><input type="text" id="sample6_postcode" placeholder="우편번호" name="zip" value="<%=zip%>">
							<input type="button" class="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
							</tr>
							<tr>
								<td>*집주소</td>
								<td colspan="2"><input type="text" id="sample6_address" placeholder="주소" name="addr" value="<%=addr%>"><br>
							</td>
							</tr>
							<tr>
								<td>*상세주소</td>
								<td colspan="2"><input type="text" id="sample6_detailAddress" placeholder="상세주소" name="addr_detail" value="<%=addr_detail%>">
							<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="addr_ref" value="<%=addr_ref%>"></td>
							</tr>
							<tr>
								<td>*휴대폰</td>
								<td colspan="2"><input type="text" name=tel1 maxlength="3" size="3" onkeyup="tel_auto()" value="<%=tel1%>">-
								<input type="text" name=tel2 maxlength="4" size="4" onkeyup="tel_auto()" value="<%=tel2%>">-
								<input type="text" name=tel3 maxlength="4" size="4" onkeyup="tel_auto()" value="<%=tel3%>"></td>
							</tr>
							<!-- <tr>
								<td>SMS 인증번호</td>	
								<td><input type="button" onclick="" value="확인"></td>	
							</tr> -->
							<tr> 	
								<td colspan="2"><p>
										<input type="button" onclick="check_mypage()" value="확인" class="button"><input type="button" value="취소" onclick="cancel()" class="button"> </td>
								<td><p>
										<input type="button" value="회원탈퇴" onclick="location.href='delete.jsp'" class="button"></td>
						</table>
					</div>
				</div> 
			</form>
			<%
			}
			}	catch (Exception e){
					out.println("실패");
					out.println(e.getMessage());
				} finally{
					if(rs!=null) rs.close();
					if(pstmt!=null) pstmt.close();
					if(conn!=null) conn.close();
				}
			%>
		
		<%@ include file = "/include/footer.jsp" %>
</body>
</html>