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
<link rel="stylesheet" type="text/css" href="stylesheet/delete.css">
<meta charset="UTF-8">
<title>회원탈퇴</title>
<script type="text/javascript">
function checkForm(){
	var confirm_test = confirm("작성한 내용은 저장되지 않습니다. 마이페이지로 돌아가시겠습니까?");
	if(confirm_test == true) history.back();
}
</script>

</head>

<style type="text/css">

</style>

<body>
	<%@include file="/include/dbconn.jsp"%>

	<%@include file="/include/header.jsp"%>

	<div class="dbox-wrap">
			<div class="d-box">
				<ul>
					<li>저희 쇼핑몰의 부족했던 점과 아쉬웠던 점을 적어주십시오.<br>
					 더 좋은 모습으로 발전하도록	최선을 다하겠습니다.<br><br>
					   앞으로 더 나은 모습으로 고객님을 다시 만날 수 있도록 노력하겠습니다.<br>
					   그동안 이용해주신 것을 진심으로 감사드립니다.
					</li>
				</ul>
			</div>
		</div>
		<div class="scede-frm">
			<hr>
			<form action="delete_process.jsp" method="post">
-				<fieldset border="0">
					<div class="table-d2-view">
						<table summary="사유" border="0">
							<caption></caption>
							<colgroup>
								<col width="90">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><div class="tb-center">사유</div></th>
									<td>
										<div class="tb-center">
											<textarea id="reason" class="MS_input_textarea txt-area1" name="reason" rows="10" cols="70"></textarea>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</fieldset>
				<div class="btn-foot">
					<input type="submit" value="회원탈퇴"> </a> <input type="button" onclick="checkForm()" value="취소"></a>
				</div>
			</form>
			<hr>
		</div>

		<%@include file="/include/footer.jsp"%>
</body>
</html>