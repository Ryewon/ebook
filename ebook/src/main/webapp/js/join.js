/**
 * 
 */
// ID 중복 검사
function ckID() {
	var mid= $('#mid').val();
	
	if (mid=="") {
		document.getElementById("ckText").innerHTML = "ID를 입력해 주세요.";
	} else {
		var idRegexp = /^[a-z][a-zA-Z0-9]{7,19}$/;
		if(!mid.match(idRegexp)) {
			document.getElementById("ckText").innerHTML = "영문자 소문자로 시작해서 8~20 글자로 입력하세요";
		} else {
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
		}
	}
}


//회원가입 정규식
function checkValue() {
	var nameExp=/^ [가-힣]{2,5}$/;
	var phoneExp=/^01([0|1|6|7|8|9|]?)-?([0-9]{3,4})-?([0-9]{4})$/;
	var regExp=/^ [a-z][a-zA-Z0-9]{7,10}$/;
	var pwExp=/^ (?=.*[a-zA-Z])(?=.*\d)|(?=.*\W)).{8,20}$/;
	if(! $('#name').val().match(nameExp)) {
		document.getElementById("ckName").innerHTML = "정확한 이름을 입력하세요.";
		return false;
	} else if(! $('#phone').val().match(phoneExp)) {
		document.getElementById("ckPhone").innerHTML = "올바른 휴대폰번호를 입력하세요";
		return false;
	}
	
	else if($('#mid').val() == "") {
		document.getElementById("ckText").innerHTML = "ID를 입력해 주세요."
		return false;
	} else if ($('#ck').val() == "0") {
		document.getElementById("ckText").innerHTML = "중복된 아이디 입니다.";
		return false;
	} else if ($('#ck').val() == "") {
		document.getElementById("ckText").innerHTML = "아이디 중복확인 해주세요.";
		return false;
	}
	
	else if(! $('#mid').val().match(regExp)) {
		document.getElementById("ckText").innerHTML = "아이디를 8~20 글자의 영소문자나 숫자를 입력하세요.";
		return false;
	} else if(! $('#pw').val().match(pwExp)) {
		document.getElementById("ckPw").innerHTML = "비밀번호를 8~20글자 사이로 입력하세요";	
		return false;
	} else if($('#name').val()=="") {
		document.getElementById("ckName").innerHTML = "이름을 입력하세요.";
		document.getElementById("name").focus();
		return false;
	} else if($('#gender').val()=="") {
		document.getElementById("ckGender").innerHTML = "성별을 선택하세요.";
		document.getElementById("gender").focus();
		return false;
	} else if($('#phone').val()=="") {
		document.getElementById("ckPhone").innerHTML = "연락처를 입력하세요.";
		document.getElementById("phone").focus();
		return false;
	} else if($('#mid').val()=="") {
		document.getElementById("ckText").innerHTML = "아이디를 입력하세요.";
		document.getElementById("mid").focus();
		return false;
	} else if($('#pw').val()=="") {
		document.getElementById("ckPw").innerHTML = "패스워드를 입력하세요.";
		document.getElementById("pw").focus();
		return false;
	} else if($('#repw').val()=="") {
		document.getElementById("ckRepw").innerHTML = "패스워드 확인을 입력하세요.";
		document.getElementById("repw").focus();
		return false;
	} else if($('#pw').val() != $('#repw').val()) {
		document.getElementById("ckRepw").innerHTML = "패스워드가 일치하지 않습니다.";
		document.getElementById("repw").focus();
		return false;
	} else if($('#hint').val()=="") {
		document.getElementById("ckHint").innerHTML = "힌트를 입력하세요.";
		document.getElementById("hint").focus();
		return false;
	} else if($('#answer').val()=="") {
		document.getElementById("ckAnswer").innerHTML = "답변을 입력하세요.";
		document.getElementById("answer").focus();
		return false;
	} else {
		return true;
	}
}
