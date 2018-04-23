<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/alterboot.css?ver=33" />
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/member.js?ver=118"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-body">
						<form accept-charset="UTF-8" role="form" action="/joinInfo" method="post">
							<fieldset>
								<div class="input-text-control">
									<label style="width: 60px">이름</label>
									<input name="name" type="text" />
								</div>
								<div class="input-text-control">
									<label style="width: 60px">생년월일</label>
									<input name="birth" type="text" />
								</div>
								<div class="input-text-control">
									<label style="width: 60px">성별</label>
									<input type="radio" name="gender" value="0"> 남 &nbsp; &nbsp;
									<input type="radio" name="gender" value="1"> 여
								</div>
								<div class="input-text-control">
									<label style="width: 60px">H/P</label>
									<input name="phone" type="text" />
								</div>
								<div class="input-text-control">
									<label style="width: 60px">EMAIL</label>
									<input name="email" type="text" />
									<input name="dubtn" value="중복검사" type="button" onclick="ckEmail()"/>
								</div>
								<div class="input-text-control">
									<label style="width: 60px">힌트</label>
									<input name="hint" type="text" />
								</div>
								<div class="input-text-control">
									<label style="width: 60px">답변</label>
									<input name="answer" type="text" />
								</div>
								<div class="input-text-control">
									<label style="width: 60px">P/W</label>
									<input name="pw" type="password" />
								</div>
								<div class="input-text-control">
									<label style="width: 60px">P/W 확인</label>
									<input name="repw" type="password" />
								</div>
								<input class="btn btn-lg btn-success btn-block" type="submit"
									value="JOIN">
							</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>