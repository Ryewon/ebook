/**
 *  로그인
 */
$(function() {
	$('#mid').focus(function() {
		$('#m').hide();
	})
});

function ckLogin() {
	var mid = $('#mid').val();
	var pw = $('#pw').val();
	
	document.getElementById("ckMid").innerHTML = "";
	document.getElementById("ckPw").innerHTML = "";
	if (mid == "") {
		document.getElementById("ckMid").innerHTML = "아이디를 입력해 주세요.";
		return false;
	} else if (pw == "") {
		document.getElementById("ckPw").innerHTML = "패스워드를 입력해 주세요.";
		return false;
	} 
//	else {
//		$.ajax({
//			type : "POST",
//			url : "/ebook/ckLogin",
//			async:false,
//			data : "mid=" + mid + "&pw=" + pw,
//			success : function(rs) {
//				console.log("rs:" + rs);
//				if(rs == null) {				
//					document.getElementById("ckText").innerHTML = "아이디 또는 패스워드를 확인해주세요.";
//					return false;
//				}
//				return true;
//			}
//		});
//	}
}
