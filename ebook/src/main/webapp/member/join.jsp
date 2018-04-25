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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/join.js?ver=312"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-body">
						<form accept-charset="UTF-8" role="form" action="memberJoin" method="post" onsubmit="return checkValue();">
							<fieldset>
								<div>
									<label style="width: 60px">이름</label>
									<input name="name" type="text" class="input-text-control"/>
									<span id="ckName"></span>
								</div>
								<div>
									<label style="width: 60px">성별</label>
									<input type="radio" name="gender" value="0"> 남 &nbsp; &nbsp;
									<input type="radio" name="gender" value="1"> 여
									<span id="ckGender"></span>
								</div>
								<div>
									<label style="width: 60px">H/P</label>
									<input name="phone" type="text" class="input-text-control"/>
									<span id="ckPhone"></span>
								</div>
								<div>
									<label style="width: 60px">ID</label>
									<input id="mid" name="mid" type="text" class="input-text-control"/>
									<input name="dubtn" value="중복검사" type="button" onclick="ckID();"/>
									<span id="ckText"></span>
									<input type="hidden" id="ck" name="ck"/>
								</div>
								<div>
									<label style="width: 60px">P/W</label>
									<input name="pw" type="password" class="input-text-control"/>
									<span id="ckPw"></span>
								</div>
								<div>
									<label style="width: 60px">P/W 확인</label>
									<input name="repw" type="password" class="input-text-control"/>
									<span id="ckRepw"></span>
								</div>
								<div>
									<label style="width: 60px">힌트</label>
									<input name="hint" type="text" class="input-text-control"/>
									<span id="ckHint"></span>
								</div>
								<div>
									<label style="width: 60px">답변</label>
									<input name="answer" type="text" class="input-text-control"/>
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