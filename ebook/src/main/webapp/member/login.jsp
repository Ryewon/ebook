<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/login.js?ver=441"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-body">
						<form accept-charset="UTF-8" role="form" method="post" action="ckLogin" onsubmit="return ckLogin();">
							<fieldset>
								<div class="form-group">
									<input class="form-control" placeholder="ID"
										id="mid" name="mid" type="text"/>
									<span id="ckMid"></span>
									<c:if test="${mck == 'no'}">
										<span id="m">아이디 또는 패스워드를 확인하세요.</span>
									</c:if>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="Password"
										id="pw" name="pw" type="password" value=""/>
									<span id="ckPw"></span>
								</div>
								<!-- <div class="checkbox">
									<label> <input name="remember" type="checkbox"
										value="Remember Me"> Remember Me
									</label>
								</div> -->
								<span id="ckText"></span>
								<input class="btn btn-lg btn-success btn-block" type="submit"
									value="LOGIN">
							</fieldset>
						</form>
						<hr />
						<!-- <center>
							<h4>OR</h4>
						</center> -->
						<a href="/ebook/join" class="btn btn-lg btn-facebook btn-block">JOIN</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>