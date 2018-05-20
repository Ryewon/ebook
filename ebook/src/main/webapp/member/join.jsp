<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/alterboot.css?ver=33" /> --%>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RWeBook - Join</title>
<script>
	// id 입력란에 key 입력하면 중복검사 결과 초기화
	function delDuChk() {
		$('#ck').val("");
		document.getElementById("ckText").innerHTML = "아이디 중복확인 해주세요.";
	}
	
	// ID 중복 검사
	function ckID() {
		var mid= $('#mid').val();
		
		if (mid=="") {
			document.getElementById("ckText").innerHTML = "ID를 입력해 주세요.";
		} else {
//			var idRegexp = /^[a-z][a-zA-Z0-9]{7,19}$/;
//			if(!mid.match(idRegexp)) {
//				document.getElementById("ckText").innerHTML = "영문자 소문자로 시작해서 8~20 글자로 입력하세요";
//			} else {
				$.ajax({
					type : "POST",
					url : "/ebook/ckID",
					async:false,
					data : "mid=" + mid,
					success : function(ck) {
						console.log("js 왔음 ");
						console.log("ck:" + ck);
						if(ck == 1) {				
							document.getElementById("ckText").innerHTML = "사용 가능한 아이디 입니다.";
							$('#ck').val(ck);
						} else {				
							document.getElementById("ckText").innerHTML = "이미 존재하는 아이디 입니다.";
							$('#ck').val(ck);
						}
					}
				});
//			}
		}
	}

	function hintEdit() {
		var index = document.joinForm.hint.selectedIndex;
		if(index == "4") {
			$('#hint2').attr('readonly', false);
			$('#hint2').val("");
		} else {
			$('#hint2').attr('readonly', true);
			$('#hint2').val(document.joinForm.hint[index].value);
			console.log($('#hint2').val());
		}
	}

	//회원가입 정규식
	//function checkValue() {
//		var nameExp=/^ [가-힣]{2,5}$/;
//		var phoneExp=/^01([0|1|6|7|8|9|]?)-?([0-9]{3,4})-?([0-9]{4})$/;
//		var regExp=/^ [a-z][a-zA-Z0-9]{7,10}$/;
//		var pwExp=/^ (?=.*[a-zA-Z])(?=.*\d)|(?=.*\W)).{8,20}$/;
//		if(! $('#name').val().match(nameExp)) {
//			document.getElementById("ckName").innerHTML = "정확한 이름을 입력하세요.";
//			return false;
//		} else if(! $('#phone').val().match(phoneExp)) {
//			document.getElementById("ckPhone").innerHTML = "올바른 휴대폰번호를 입력하세요";
//			return false;
//		} else if(! $('#mid').val().match(regExp)) {
//			document.getElementById("ckText").innerHTML = "아이디를 8~20 글자의 영소문자나 숫자를 입력하세요.";
//			return false;
//		} else if(! $('#pw').val().match(pwExp)) {
//			document.getElementById("ckPw").innerHTML = "비밀번호를 8~20글자 사이로 입력하세요";	
//			return false;
//		} 
	//}

	function checkValue() {
		if($('#name').val()=="") {
			document.getElementById("ckName").innerHTML = "이름을 입력하세요.";
			document.getElementById("name").focus();
			$("#ckName").show();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if(document.joinForm.gender.value=="") {
			document.getElementById("ckGender").innerHTML = "성별을 선택하세요.";
			$("#ckName").hide();
			$("#ckGender").show();
			$("#ckPhone").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if($('#phone').val()=="") {
			document.getElementById("ckPhone").innerHTML = "연락처를 입력하세요.";
			document.getElementById("phone").focus();
			$("#ckName").hide();
			$("#ckGender").hide();;
			$("#ckPhone").show();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if($('#mid').val()=="") {
			document.getElementById("ckText").innerHTML = "아이디를 입력하세요.";
			document.getElementById("mid").focus();
			$("#ckName").hide();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if($('#pw').val()=="") {
			document.getElementById("ckPw").innerHTML = "패스워드를 입력하세요.";
			document.getElementById("pw").focus();
			$("#ckName").hide();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckPw").show();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if($('#repw').val()=="") {
			document.getElementById("ckRepw").innerHTML = "패스워드 확인을 입력하세요.";
			document.getElementById("repw").focus();
			$("#ckName").hide();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckText").hide();
			$("#ckPw").hide();
			$("#ckRepw").show();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if($('#pw').val() != $('#repw').val()) {
			document.getElementById("ckRepw").innerHTML = "패스워드가 일치하지 않습니다.";
			document.getElementById("repw").focus();
			$("#ckName").hide();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckText").hide();
			$("#ckPw").hide();
			$("#ckRepw").show();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if($('#hint2').val()=="") {
			document.getElementById("ckHint").innerHTML = "힌트를 입력하세요.";
			document.getElementById("hint").focus();
			$("#ckName").hide();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").show();
			$("#ckAnswer").hide();
			return false;
		} else if($('#answer').val()=="") {
			document.getElementById("ckAnswer").innerHTML = "답변을 입력하세요.";
			document.getElementById("answer").focus();
			$("#ckName").hide();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").show();
			return false;
		} else if($('#ck').val()=="") {
			document.getElementById("ckText").innerHTML = "아이디 중복확인 해주세요.";
			document.getElementById("dubtn").focus();
			$("#ckName").hide();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		}
	}
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-body">
						<form accept-charset="UTF-8" role="form" name="joinForm" action="memberJoin" method="post" onsubmit="return checkValue();">
							<fieldset>
								<div>
									<label style="width: 60px">이름</label>
									<input id="name" name="name" type="text" class="input-text-control"/>
									<span id="ckName"></span>
								</div>
								<div>
									<label style="width: 60px">성별</label>
									<input type="radio" name="gender" value="m"> 남 &nbsp; &nbsp;
									<input type="radio" name="gender" value="f"> 여
									<span id="ckGender"></span>
								</div>
								<div>
									<label style="width: 60px">H/P</label>
									<input id="phone" name="phone" type="text" class="input-text-control"/>
									<span id="ckPhone"></span>
								</div>
								<div>
									<label style="width: 60px">ID</label>
									<input id="mid" name="mid" type="text" class="input-text-control" onkeypress="delDuChk();"/>
									<input id="dubtn" name="dubtn" value="중복검사" type="button" onclick="ckID();"/>
									<span id="ckText"></span>
									<input type="hidden" id="ck" name="ck"/>
								</div>
								<div>
									<label style="width: 60px">P/W</label>
									<input id="pw" name="pw" type="password" class="input-text-control"/>
									<span id="ckPw"></span>
								</div>
								<div>
									<label style="width: 60px">P/W 확인</label>
									<input id="repw" name="repw" type="password" class="input-text-control"/>
									<span id="ckRepw"></span>
								</div>
								<div>
									<label style="width: 60px">힌트</label>
									<select id="hint" name="hint" onchange="hintEdit();" >
										<option value="가장 좋아하는 색깔은?">가장 좋아하는 색깔은?</option>
										<option value="가장 소중한 보물은?">가장 소중한 보물은?</option>
										<option value="어렸을 적 짝꿍의 이름은?">어렸을 적 짝꿍의 이름은?</option>
										<option value="기억에 남는 장소는?">기억에 남는 장소는?</option>
										<option value="기타">기타</option>
									</select>
									<input id="hint2" name="hint2" type="text" value="가장 좋아하는 색깔은?" class="input-text-control" readonly />
									<span id="ckHint"></span>
								</div>
								<div>
									<label style="width: 60px">답변</label>
									<input id="answer" name="answer" type="text" class="input-text-control"/>
									<span id="ckAnswer"></span>
								</div>
								<br />
								<input class="btn btn-lg btn-success btn-block" type="submit" value="완료" />
							</fieldset>
						</form>
					</div>
				</div>	
			</div>
		</div>
	</div>
</body>
</html>