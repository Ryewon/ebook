<%@ page import="member.AuthInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
	int point = authInfo.getPoint();
%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/join.js?ver=221"></script>

<div id="test">

	<div>
		<h2>개인정보</h2>
		<div>
			<label>이름 &nbsp;</label><input type="text" id="name" name="name" value="${authInfo.name }"/>
		</div>
		<div>
			<c:choose>
				<c:when test="${authInfo.gender == 'm' }" >
					<label>성별 &nbsp;</label> <input type="radio" name="gender" value="남" checked="checked"/>남
					&nbsp; &nbsp; <input type="radio" name="gender" value="여" />여
				</c:when>
				<c:otherwise>
					<label>성별 &nbsp;</label> <input type="radio" name="gender" value="남"/>남
					&nbsp; &nbsp; <input type="radio" name="gender" value="여"  checked="checked" />여
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
			<label>보유포인트   ${point }</label>
		</div>
		<label>패스워드 &nbsp;</label><input type="text" id="pw" name="pw" /> <br>
		<input type="submit" value="수정"/>
	</div>
	<br>
	<div class="">
		<h2>패스워드 재설정</h2>
		<div>
			<label>현재 패스워드 &nbsp;</label><input type="text" id="cur_pw" name="cur_pw" /> <br>
			<label>새 패스워드 &nbsp;</label><input type="text" id="new_pw1" name="new_pw1" /> <br>
			<label>새 패스워드 확인 &nbsp;</label><input type="text" id="new_pw2" name="new_pw2" />
		</div>
		<input type="submit" value="확인"/>
	</div>
</div>
