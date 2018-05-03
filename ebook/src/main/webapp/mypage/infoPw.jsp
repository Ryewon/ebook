<%@ page import="member.AuthInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script>
	function hintEdit() {
		var index = document.infoForm.hint.selectedIndex;
		if(index == "4") {
			$('#hint2').attr('readonly', false);
			$('#hint2').val("");
			$('#hint2').focus();
		} else {
			$('#hint2').attr('readonly', true);
			$('#hint2').val(document.infoForm.hint[index].value);
			console.log($('#hint2').val());
		}
	}
</script>

<div id="test">

	<div>
		<h2>개인정보</h2>
		<form accept-charset="UTF-8" role="form" name="infoForm" action="infoModify" method="post">
			<div>
				<label>아이디 &nbsp;</label> ${authInfo.mid } <br>
				<label>이름 &nbsp;</label><input type="text" id="name" name="name" value="${authInfo.name }"/>
			</div>
			<div>
				<c:choose>
					<c:when test="${authInfo.gender == 'm' }" >
						<label>성별 &nbsp;</label> <input type="radio" name="gender" value="m" checked="checked"/>남
						&nbsp; &nbsp; <input type="radio" name="gender" value="f" />여
					</c:when>
					<c:otherwise>
						<label>성별 &nbsp;</label> <input type="radio" name="gender" value="m"/>남
						&nbsp; &nbsp; <input type="radio" name="gender" value="f"  checked="checked" />여
					</c:otherwise>
				</c:choose>
			</div>
			<div>
				<label>휴대전화 &nbsp;</label><input type="text" id="phone" name="phone" value="${authInfo.phone }"/>
			</div>
			<div>
				<label>힌트</label> <select id="hint" name="hint"
					onchange="hintEdit();">
					<option value="가장 좋아하는 색깔은?">가장 좋아하는 색깔은?</option>
					<option value="가장 소중한 보물은?">가장 소중한 보물은?</option>
					<option value="어렸을 적 짝꿍의 이름은?">어렸을 적 짝꿍의 이름은?</option>
					<option value="기억에 남는 장소는?">기억에 남는 장소는?</option>
					<option value="기타">기타</option>
				</select> <input id="hint2" name="hint2" type="text" value="가장 좋아하는 색깔은?"
					class="input-text-control" readonly /> <span id="ckHint"></span>
			</div>
			<div>
				<label style="width: 60px">답변</label> <input id="answer"
					name="answer" type="text" value="${authInfo.answer }" />
			</div>
			<div>
				<label>보유포인트  </label> ${authInfo.point } point
			</div>
			<label>패스워드 &nbsp;</label><input type="password" id="pw" name="pw" /> <br>
			<input type="submit" value="수정"/>
		</form>
	</div>
	
	<br>
	<div class="">
		<h2>패스워드 재설정</h2>
		<form accept-charset="UTF-8" role="form" name="passForm" action="passModify" method="post">
			<div>
				<label>현재 패스워드 &nbsp;</label><input type="text" id="cur_pw" name="cur_pw" /> <br>
				<label>새 패스워드 &nbsp;</label><input type="text" id="new_pw1" name="new_pw1" /> <br>
				<label>새 패스워드 확인 &nbsp;</label><input type="text" id="new_pw2" name="new_pw2" />
			</div>
			<input type="submit" value="확인"/>
		</form>
	</div>
</div>
