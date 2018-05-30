<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<%
 String strReferer = request.getHeader("referer");
 
 if(strReferer == null){
%>
 <script language="javascript">
  alert("비정상적인 방법으로 접근하셨습니다.");
  document.location.href="/ebook/home";
 </script>
<%
  return;
 }
%>

<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	window.history.forward();
	$(document).ready(function () {
		$('#mid').focus();
	})
	
	function ckLogin() {
		var mid = $('#mid').val();
		var pw = $('#pw').val();
		
		document.getElementById("ckMid").innerHTML = "";
		document.getElementById("ckPw").innerHTML = "";
		if (mid == "") {
			document.getElementById("ckMid").innerHTML = "아이디를 입력해 주세요.";
			$('#loginRS').hide();
			return false;
		} else if (pw == "") {
			document.getElementById("ckPw").innerHTML = "패스워드를 입력해 주세요.";
			$('#loginRS').hide();
			return false;
		} 
	}
</script>
<style type="text/css">
	.alertSmall {
		color : red;
		
	}
</style>
</head>
<body>
<div style="width: 100%; height: 100%; position: fixed; background-color: #EBF7FF">
	<div class="container" style="margin: 15% auto;">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-body" style="text-align: center;">
						<a href="./home"><img src="/ebook/logo.png" style="width: 200px; height: 80px;"></a>
						<form accept-charset="UTF-8" role="form" method="post" action="ckLogin" onsubmit="return ckLogin();">
							<fieldset>
								<div class="form-group">
									<input class="form-control" placeholder="ID"
										id="mid" name="mid" type="text"/>
									<span class="alertSmall" id="ckMid"></span>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="Password"
										id="pw" name="pw" type="password" value=""/>
									<span class="alertSmall" id="ckPw"></span>
								</div>
								<c:if test="${mck eq 'no'}">
										<span id="loginRS" class="alertSmall">아이디 또는 패스워드를 확인하세요.</span>
								</c:if>
								<input class="btn btn-lg btn-success btn-block" type="submit"
									value="LOGIN">
							</fieldset>
						</form>
						<hr />
						<!-- <center>
							<h4>OR</h4>
						</center> -->
						<a href="/join" class="btn btn-lg btn-facebook btn-block">JOIN</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>