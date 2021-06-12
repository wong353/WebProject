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
			<form action="mypage_process.jsp" method="post" name="member">
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
									<td colspan="2"><select disabled name="birthyear" class="select_birthday" value="<%=birthYear%>">
											<option value="">선택</option>
											<%-- <option value="1932" <% if(birthYear.equals("1932")) { %> selected <% }%>>1932</option>
											<option value="1933" <% if(birthYear.equals("1933")) { %> selected <% }%>>1933</option>
											<option value="1934" <% if(birthYear.equals("1934")) { %> selected <% }%>>1934</option>
											<option value="1935" <% if(birthYear.equals("1935")) { %> selected <% }%>>1935</option>
											<option value="1936" <% if(birthYear.equals("1936")) { %> selected <% }%>>1936</option>
											<option value="1937" <% if(birthYear.equals("1937")) { %> selected <% }%>>1937</option>
											<option value="1938" <% if(birthYear.equals("1938")) { %> selected <% }%>>1938</option>
											<option value="1939" <% if(birthYear.equals("1939")) { %> selected <% }%>>1939</option>
											<option value="1940" <% if(birthYear.equals("1940")) { %> selected <% }%>>1940</option>
											<option value="1941" <% if(birthYear.equals("1941")) { %> selected <% }%>>1941</option>
											<option value="1942" <% if(birthYear.equals("1942")) { %> selected <% }%>>1942</option>
											<option value="1943" <% if(birthYear.equals("1943")) { %> selected <% }%>>1943</option>
											<option value="1944" <% if(birthYear.equals("1944")) { %> selected <% }%>>1944</option>
											<option value="1945" <% if(birthYear.equals("1945")) { %> selected <% }%>>1945</option>
											<option value="1946" <% if(birthYear.equals("1946")) { %> selected <% }%>>1946</option>
											<option value="1947" <% if(birthYear.equals("1947")) { %> selected <% }%>>1947</option>
											<option value="1948" <% if(birthYear.equals("1948")) { %> selected <% }%>>1948</option>
											<option value="1949" <% if(birthYear.equals("1949")) { %> selected <% }%>>1949</option>
											<option value="1950" <% if(birthYear.equals("1950")) { %> selected <% }%>>1950</option>
											<option value="1951" <% if(birthYear.equals("1951")) { %> selected <% }%>>1951</option>
											<option value="1952" <% if(birthYear.equals("1952")) { %> selected <% }%>>1952</option>
											<option value="1953" <% if(birthYear.equals("1953")) { %> selected <% }%>>1953</option>
											<option value="1954" <% if(birthYear.equals("1954")) { %> selected <% }%>>1954</option>
											<option value="1955" <% if(birthYear.equals("1955")) { %> selected <% }%>>1955</option>
											<option value="1956" <% if(birthYear.equals("1956")) { %> selected <% }%>>1956</option>
											<option value="1957" <% if(birthYear.equals("1957")) { %> selected <% }%>>1957</option>
											<option value="1958" <% if(birthYear.equals("1958")) { %> selected <% }%>>1958</option>
											<option value="1959" <% if(birthYear.equals("1959")) { %> selected <% }%>>1959</option>
											<option value="1960" <% if(birthYear.equals("1960")) { %> selected <% }%>>1960</option>
											<option value="1961" <% if(birthYear.equals("1961")) { %> selected <% }%>>1961</option>
											<option value="1962" <% if(birthYear.equals("1962")) { %> selected <% }%>>1962</option>
											<option value="1963" <% if(birthYear.equals("1963")) { %> selected <% }%>>1963</option>
											<option value="1964" <% if(birthYear.equals("1964")) { %> selected <% }%>>1964</option>
											<option value="1965" <% if(birthYear.equals("1965")) { %> selected <% }%>>1965</option>
											<option value="1966" <% if(birthYear.equals("1966")) { %> selected <% }%>>1966</option>
											<option value="1967" <% if(birthYear.equals("1967")) { %> selected <% }%>>1967</option>
											<option value="1968" <% if(birthYear.equals("1968")) { %> selected <% }%>>1968</option>
											<option value="1969" <% if(birthYear.equals("1969")) { %> selected <% }%>>1969</option>
											<option value="1970" <% if(birthYear.equals("1970")) { %> selected <% }%>>1970</option>
											<option value="1971" <% if(birthYear.equals("1971")) { %> selected <% }%>>1971</option>
											<option value="1972" <% if(birthYear.equals("1972")) { %> selected <% }%>>1972</option>
											<option value="1973" <% if(birthYear.equals("1973")) { %> selected <% }%>>1973</option>
											<option value="1974" <% if(birthYear.equals("1974")) { %> selected <% }%>>1974</option>
											<option value="1975" <% if(birthYear.equals("1975")) { %> selected <% }%>>1975</option>
											<option value="1976" <% if(birthYear.equals("1976")) { %> selected <% }%>>1976</option>
											<option value="1977" <% if(birthYear.equals("1977")) { %> selected <% }%>>1977</option>
											<option value="1978" <% if(birthYear.equals("1978")) { %> selected <% }%>>1978</option>
											<option value="1979" <% if(birthYear.equals("1979")) { %> selected <% }%>>1979</option>
											<option value="1980" <% if(birthYear.equals("1980")) { %> selected <% }%>>1980</option>
											<option value="1981" <% if(birthYear.equals("1981")) { %> selected <% }%>>1981</option>
											<option value="1982" <% if(birthYear.equals("1982")) { %> selected <% }%>>1982</option>
											<option value="1983" <% if(birthYear.equals("1983")) { %> selected <% }%>>1983</option>
											<option value="1984" <% if(birthYear.equals("1984")) { %> selected <% }%>>1984</option>
											<option value="1985" <% if(birthYear.equals("1985")) { %> selected <% }%>>1985</option>
											<option value="1986" <% if(birthYear.equals("1986")) { %> selected <% }%>>1986</option>
											<option value="1987" <% if(birthYear.equals("1987")) { %> selected <% }%>>1987</option>
											<option value="1988" <% if(birthYear.equals("1988")) { %> selected <% }%>>1988</option>
											<option value="1989" <% if(birthYear.equals("1989")) { %> selected <% }%>>1989</option>
											<option value="1990" <% if(birthYear.equals("1990")) { %> selected <% }%>>1990</option>
											<option value="1991" <% if(birthYear.equals("1991")) { %> selected <% }%>>1991</option>
											<option value="1992" <% if(birthYear.equals("1992")) { %> selected <% }%>>1992</option>
											<option value="1993" <% if(birthYear.equals("1993")) { %> selected <% }%>>1993</option>
											<option value="1994" <% if(birthYear.equals("1994")) { %> selected <% }%>>1994</option>
											<option value="1995" <% if(birthYear.equals("1995")) { %> selected <% }%>>1995</option>
											<option value="1996" <% if(birthYear.equals("1996")) { %> selected <% }%>>1996</option>
											<option value="1997" <% if(birthYear.equals("1997")) { %> selected <% }%>>1997</option>
											<option value="1998" <% if(birthYear.equals("1998")) { %> selected <% }%>>1998</option>
											<option value="1999" <% if(birthYear.equals("1999")) { %> selected <% }%>>1999</option>
											<option value="2000" <% if(birthYear.equals("2000")) { %> selected <% }%>>2000</option>
											<option value="2001" <% if(birthYear.equals("2001")) { %> selected <% }%>>2001</option>
											<option value="2002" <% if(birthYear.equals("2002")) { %> selected <% }%>>2002</option>
											<option value="2003" <% if(birthYear.equals("2003")) { %> selected <% }%>>2003</option>
											<option value="2004" <% if(birthYear.equals("2004")) { %> selected <% }%>>2004</option>
											<option value="2005" <% if(birthYear.equals("2005")) { %> selected <% }%>>2005</option>
											<option value="2006" <% if(birthYear.equals("2006")) { %> selected <% }%>>2006</option>
											<option value="2007" <% if(birthYear.equals("2007")) { %> selected <% }%>>2007</option>
											<option value="2008" <% if(birthYear.equals("2008")) { %> selected <% }%>>2008</option>
											<option value="2009" <% if(birthYear.equals("2009")) { %> selected <% }%>>2009</option>
											<option value="2010" <% if(birthYear.equals("2010")) { %> selected <% }%>>2010</option>
											<option value="2011" <% if(birthYear.equals("2011")) { %> selected <% }%>>2011</option>
											<option value="2012" <% if(birthYear.equals("2012")) { %> selected <% }%>>2012</option>
											<option value="2013" <% if(birthYear.equals("2013")) { %> selected <% }%>>2013</option>
											<option value="2014" <% if(birthYear.equals("2014")) { %> selected <% }%>>2014</option>
											<option value="2015" <% if(birthYear.equals("2015")) { %> selected <% }%>>2015</option>
											<option value="2016" <% if(birthYear.equals("2016")) { %> selected <% }%>>2016</option>
											<option value="2017" <% if(birthYear.equals("2017")) { %> selected <% }%>>2017</option>
											<option value="2018" <% if(birthYear.equals("2018")) { %> selected <% }%>>2018</option>
											<option value="2019" <% if(birthYear.equals("2019")) { %> selected <% }%>>2019</option>
											<option value="2020" <% if(birthYear.equals("2020")) { %> selected <% }%>>2020</option>
											<option value="2020" <% if(birthYear.equals("2021")) { %> selected <% }%>>2021</option> --%>
											<%
												int i = 0;
												for(i = 1932; i <= 2021; i++){
													String i2 = String.valueOf(i);
											%>	<option value="<%=i%>" <% if(birthYear.equals(i2)) { %> selected <%} %>><%=i%></option>
											<%
												}
											%>
											
									</select>년
									<select disabled name="birthmonth" class="select_birthday" value="<%=birthMonth%>">
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
									<select disabled name="birthdate" class="select_birthday" value="<%=birthDay%>">
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
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
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
										<input type="button" onclick="check_mypage()" value="확인"><input type="button" value="취소" onclick="cancel()"> </td>
								<td><p>
										<input type="button" value="회원탈퇴" onclick="location.href='delete.jsp'"></td>
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