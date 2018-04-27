<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/alterboot.css?ver=33" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/join.js?ver=212"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
									<input id="mid" name="mid" type="text" class="input-text-control"/>
									<input name="dubtn" value="중복검사" type="button" onclick="ckID();"/>
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
									<input id="hint2" name="hint2" type="text" value="가장 좋아하는 색깔은?" class="input-text-control" disabled="disabled"/>
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