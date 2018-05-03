<%@ page import="member.AuthInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/modal.css?ver=33" />
<script>
	$(document).ready(function(){
		var check = $('#check').val();
		var checkPw = $('#checkPw').val();
		
		if(check=="miss") {
			$('#con').html('패스워드가 일치하지 않습니다.');
			$('#myModal').show();
		}
		console.log(checkPw)
		if(checkPw=="y") {
			$('#con').html('패스워드 변경이 완료되었습니다.');
			$('#myModal').show();
		} else if(checkPw=="n") {
			$('#con').html('현재 패스워드를 확인해 주세요.');
			$('#myModal').show();
		}
	});
	
	function close_pop(flag) {
        $('#myModal').hide();
   	}
	
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
	
	function inputCheck() {
		if($('#pw').val()=="") {
			$('#con').html('패스워드를 입력해주세요.');
			$('#myModal').show();
			return false;
		}
		
	}
	
	function changePass() {
		if($('#cur_pw').val() == "") {
			document.getElementById("alert1").innerHTML = "현재 패스워드를 입력해 주세요.";
			document.getElementById("alert2").innerHTML = "";
			document.getElementById("alert3").innerHTML = "";
			document.getElementById("alert4").innerHTML = "";
			return false;
		} else if($('#new_pw1').val() == "") {
			document.getElementById("alert1").innerHTML = "";
			document.getElementById("alert2").innerHTML = "새로운 패스워드를 입력해 주세요.";
			document.getElementById("alert3").innerHTML = "";
			document.getElementById("alert4").innerHTML = "";
			return false;
		} else if($('#new_pw2').val() == "") {
			document.getElementById("alert1").innerHTML = "";
			document.getElementById("alert2").innerHTML = "";
			document.getElementById("alert3").innerHTML = "새 패스워드 확인을 입력해 주세요.";
			document.getElementById("alert4").innerHTML = "";
			return false;
		} else if($('#new_pw1').val() != $('#new_pw2').val()) {
			document.getElementById("alert1").innerHTML = "";
			document.getElementById("alert2").innerHTML = "";
			document.getElementById("alert3").innerHTML = "";
			document.getElementById("alert4").innerHTML = "새 패스워드를 확인해 주세요.";
			return false;
		}
	}
</script>

<!-- 모달 -->
<div id="myModal" class="modal">
	<!-- Modal content -->
	<div class="modal-content">
	          <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">공지</span></b></span></p>
	          <p style="text-align: center; line-height: 1.5;"><br />
	          <span id="con"></span>
	          </p>
	          <p><br /></p>
	      <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
	          <span class="pop_bt" style="font-size: 13pt;" >
	               닫기
	          </span>
	      </div>
	</div>
 </div>

<!--  -->
<div id="test">
	<div>
		<h2>개인정보</h2>ㅁㅇㄹ
		<input type="hidden" id="check" name="check" value="${check }">
		<form accept-charset="UTF-8" role="form" name="infoForm" action="infoModify" method="post" onsubmit="return inputCheck();">
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
		<input type="hidden" id="checkPw" value="${changePw }"/>
		<h2>패스워드 재설정</h2>
		<form accept-charset="UTF-8" role="form" name="passForm" action="passModify" method="post" onsubmit="return changePass();">
			<div>
				<label>현재 패스워드 &nbsp;</label><input type="password" id="cur_pw" name="cur_pw" /> 
				<span id="alert1" ></span>
				<br>
				<label>새 패스워드 &nbsp;</label><input type="password" id="new_pw1" name="new_pw1" /> 
				<span id="alert2" ></span>
				<br>
				<label>새 패스워드 확인 &nbsp;</label><input type="password" id="new_pw2" name="new_pw2" />
				<span id="alert3" ></span><br>
				<span id="alert4" ></span>
			</div>
			<input type="submit" value="확인"/>
		</form>
	</div>
</div>
