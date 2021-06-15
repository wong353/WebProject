<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file = "reference/addressAPI.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<meta charset="UTF-8">
<title>회원가입</title>
<script language="javascript" type="text/javascript" src="./js/check.js"></script>
<script type="text/javascript">
	
function idcheck(id){
	if(!member.id.value){
		alert("아이디를 입력하세요!");
		member.id.focus();
		return false;
	}
	window.open('idCheck_process.jsp?id='+id, '_blank', 'width=400, height=300, top=300, left= 500');
}

function tel_auto(){
	if(member.tel1.value.length==3){
		member.tel2.focus();
	}
	if (member.tel2.value.length==4){
		member.tel3.focus();
	}
}

function cancel(){
	if(confirm("메인 페이지로 돌아가시겠습니까?")){
		location.href="main.jsp";
	}
}

</script>


</head>

<style type="text/css">
table {
	width: 50%;
	padding-top: 0px;
	margin: 0 auto;
} 

</style>

<body>
	<%@include file = "./include/loginSessionExist.jsp" %>
	
	<%@include file="/include/dbconn.jsp"%>

	<%@include file="/include/header.jsp"%>

			<div id="join-caption">
				<h4>회원정보 입력</h4>
			</div>
			<form action="join_process.jsp" method="post" name="member">
				<div id="join-wrapper">
					<div id="join-table">
						<table border="0">
							<tr>
								<td>*이름</td>
								<td colspan="2"><input type="text" name="name" id="name"></td>
							</tr>
							<tr>
								<td>*아이디</td>
								<td colspan="2"><input type="text" name="id" id="id"> <input type="button" value="중복체크" onclick="idcheck(member.id.value)"></td>
							</tr>
							<tr>
								<td>*비밀번호</td>
								<td colspan="2"><input type="password" name="pwd1" id="pwd1"></td>
							</tr>
							<tr>
								<td>*비밀번호 확인</td>
								<td colspan="2"><input type="password" name="pwd2" id="pwd2"></td>
							</tr>
							<tr>
								<td>*닉네임</td>
								<td colspan="2"><input type="text" name="nickname" id="nickname"></td>
							</tr>
							<tr>
								<td>*이메일</td>
								<td colspan="2"><input type="text" name="email" id="email"></td>
							</tr>
							<div class="birth">
								<tr>
									<td>*생일</td>
									<td colspan="2"><select name="birthyear" class="select_birthday">
											<option value="">선택</option>
											<option value="1932">1932</option>
											<option value="1933">1933</option>
											<option value="1934">1934</option>
											<option value="1935">1935</option>
											<option value="1936">1936</option>
											<option value="1937">1937</option>
											<option value="1938">1938</option>
											<option value="1939">1939</option>
											<option value="1940">1940</option>
											<option value="1941">1941</option>
											<option value="1942">1942</option>
											<option value="1943">1943</option>
											<option value="1944">1944</option>
											<option value="1945">1945</option>
											<option value="1946">1946</option>
											<option value="1947">1947</option>
											<option value="1948">1948</option>
											<option value="1949">1949</option>
											<option value="1950">1950</option>
											<option value="1951">1951</option>
											<option value="1952">1952</option>
											<option value="1953">1953</option>
											<option value="1954">1954</option>
											<option value="1955">1955</option>
											<option value="1956">1956</option>
											<option value="1957">1957</option>
											<option value="1958">1958</option>
											<option value="1959">1959</option>
											<option value="1960">1960</option>
											<option value="1961">1961</option>
											<option value="1962">1962</option>
											<option value="1963">1963</option>
											<option value="1964">1964</option>
											<option value="1965">1965</option>
											<option value="1966">1966</option>
											<option value="1967">1967</option>
											<option value="1968">1968</option>
											<option value="1969">1969</option>
											<option value="1970">1970</option>
											<option value="1971">1971</option>
											<option value="1972">1972</option>
											<option value="1973">1973</option>
											<option value="1974">1974</option>
											<option value="1975">1975</option>
											<option value="1976">1976</option>
											<option value="1977">1977</option>
											<option value="1978">1978</option>
											<option value="1979">1979</option>
											<option value="1980">1980</option>
											<option value="1981">1981</option>
											<option value="1982">1982</option>
											<option value="1983">1983</option>
											<option value="1984">1984</option>
											<option value="1985">1985</option>
											<option value="1986">1986</option>
											<option value="1987">1987</option>
											<option value="1988">1988</option>
											<option value="1989">1989</option>
											<option value="1990">1990</option>
											<option value="1991">1991</option>
											<option value="1992">1992</option>
											<option value="1993">1993</option>
											<option value="1994">1994</option>
											<option value="1995">1995</option>
											<option value="1996">1996</option>
											<option value="1997">1997</option>
											<option value="1998">1998</option>
											<option value="1999">1999</option>
											<option value="2000">2000</option>
											<option value="2001">2001</option>
											<option value="2002">2002</option>
											<option value="2003">2003</option>
											<option value="2004">2004</option>
											<option value="2005">2005</option>
											<option value="2006">2006</option>
											<option value="2007">2007</option>
											<option value="2008">2008</option>
											<option value="2009">2009</option>
											<option value="2010">2010</option>
											<option value="2011">2011</option>
											<option value="2012">2012</option>
											<option value="2013">2013</option>
											<option value="2014">2014</option>
											<option value="2015">2015</option>
											<option value="2016">2016</option>
											<option value="2017">2017</option>
											<option value="2018">2018</option>
											<option value="2019">2019</option>
											<option value="2020">2020</option>
									</select>년
									<select name="birthmonth" class="select_birthday">
											<option value="">선택</option>
											<option value="01">1</option>
											<option value="02">2</option>
											<option value="03">3</option>
											<option value="04">4</option>
											<option value="05">5</option>
											<option value="06">6</option>
											<option value="07">7</option>
											<option value="08">8</option>
											<option value="09">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
									</select>월
									<select name="birthdate" class="select_birthday">
											<option value="">선택</option>
											<option value="01">1</option>
											<option value="02">2</option>
											<option value="03">3</option>
											<option value="04">4</option>
											<option value="05">5</option>
											<option value="06">6</option>
											<option value="07">7</option>
											<option value="08">8</option>
											<option value="09">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
											<option value="21">21</option>
											<option value="22">22</option>
											<option value="23">23</option>
											<option value="24">24</option>
											<option value="25">25</option>
											<option value="26">26</option>
											<option value="27">27</option>
											<option value="28">28</option>
											<option value="29">29</option>
											<option value="30">30</option>
											<option value="31">31</option>
									</select>일</td>
								</tr>
							</div>
							
							<tr>
								<td>*우편번호</td>
								<td colspan="2"><input type="text" id="sample6_postcode" placeholder="우편번호" name="zip">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
							</tr>
							<tr>
								<td>*집주소</td>
								<td colspan="2"><input type="text" id="sample6_address" placeholder="주소" name="addr"><br>
							</td>
							</tr>
							<tr>
								<td>*상세주소</td>
								<td colspan="2"><input type="text" id="sample6_detailAddress" placeholder="상세주소" name="addr_detail">
							<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="addr_ref"></td>
							</tr>
							<tr>
								<td>*휴대폰</td>
								<td colspan="2"><input type="text" name=tel1 maxlength="3" size="3" onkeyup="tel_auto()">-
								<input type="text" name=tel2 maxlength="4" size="4" onkeyup="tel_auto()">-
								<input type="text" name=tel3 maxlength="4" size="4" onkeyup="tel_auto()"></td>
							</tr>
							<!-- <tr>
								<td>SMS 인증번호</td>	
								<td><input type="button" onclick="" value="확인"></td>	
							</tr> -->
							<tr> 	
								<td colspan="2"><p>
										<input type="button" onclick="check()" value="회원가입"> <input type="reset" value="초기화"></td>
								<td><p>
										<input type="button" value="취소" onclick="cancel()"></td>
						</table>
					</div>
				</div> 
			</form>
	<%@include file="/include/footer.jsp"%>
</body>
</html>