<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mypage.css?ver=22" />

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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyPage</title>	
</head>

<script>
//infoPw 쪽 스크립트임
	$(document).ready(function(){
		$('#alert2').hide();
		
		var check = $('#check').val();
		var checkInfo = "<c:out value='${changeInfo }' />";
		var checkPw = $('#checkPw').val();
		
		if(check=="miss") {
			$('#con').html('패스워드가 일치하지 않습니다.');
			$('#refreshBtn').hide();
			$('#closeBtn').show();
			$('#myModal').show();
		}
		
		if(checkInfo=="y") {
			$('#con').html('개인정보 변경이 완료되었습니다.');
			$('#refreshBtn').show();
			$('#closeBtn').hide();
			$('#myModal').show();
		}
		
		console.log(checkPw)
		if(checkPw=="y") {
			$('#con').html('패스워드 변경이 완료되었습니다.');
			$('#refreshBtn').show();
			$('#closeBtn').hide();
			$('#myModal').show();
			$('#checkPw').val('');
		} else if(checkPw=="n") {
			$('#con').html('현재 패스워드를 확인해 주세요.');
			$('#refreshBtn').hide();
			$('#closeBtn').show();
			$('#myModal').show();
		}
	});
	
	$(document).ready(function(){
		var spot= "<c:out value='${spot }'/>";
		if (spot=="infoPw") {
			$('#sidebar-wrapper li > a').eq(0).addClass('sideRemain');
			$('#sidebar-wrapper li > a').eq(1).removeClass('sideRemain');
			$('#sidebar-wrapper li > a').eq(2).removeClass('sideRemain');
		} else if (spot=="upBookList") {
			$('#sidebar-wrapper li > a').eq(0).removeClass('sideRemain');
			$('#sidebar-wrapper li > a').eq(1).addClass('sideRemain');
			$('#sidebar-wrapper li > a').eq(2).removeClass('sideRemain');
		} else {
			$('#sidebar-wrapper li > a').eq(0).removeClass('sideRemain');
			$('#sidebar-wrapper li > a').eq(1).removeClass('sideRemain');
			$('#sidebar-wrapper li > a').eq(2).addClass('sideRemain');
		}
	});
	
	function close_pop(flag) {
	    $('#myModal').hide();
	    window.location.href="/ebook/mypage?spot=infoPw";
	}
	
	function mdclose() {
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
		var nameExp=/^[가-힣]{2,5}$/;
		var phoneExp=/^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;

		if($('#name').val()=="") {
			document.getElementById("ckName").innerHTML = "이름을 입력하세요.";
			document.getElementById("name").focus();
			$("#ckName").show();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckText").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if (! document.infoForm.name.value.match(nameExp)) {
			document.getElementById("ckName").innerHTML = "올바른 이름을 입력하세요.";
			document.getElementById("name").focus();
			$("#ckName").show();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckText").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if(document.infoForm.gender.value=="") {
			document.getElementById("ckGender").innerHTML = "성별을 선택하세요.";
			$("#ckName").hide();
			$("#ckGender").show();
			$("#ckPhone").hide();
			$("#ckText").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if($('#phone').val()=="") {
			document.getElementById("ckPhone").innerHTML = "휴대폰번호를 입력하세요.";
			document.getElementById("phone").focus();
			$("#ckName").hide();
			$("#ckGender").hide();;
			$("#ckPhone").show();
			$("#ckText").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if (! document.infoForm.phone.value.match(phoneExp)) {
			document.getElementById("ckPhone").innerHTML = "올바른 휴대폰번호를 입력하세요";
			$("#ckName").hide();
			$("#ckGender").hide();;
			$("#ckPhone").show();
			$("#ckText").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			return false;
		} else if($('#hint2').val()=="" || $('#hint2').val().trim().length==0) {
			document.getElementById("ckHint").innerHTML = "힌트를 입력하세요.";
			document.getElementById("hint").focus();
			$("#ckName").hide();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckText").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").show();
			$("#ckAnswer").hide();
			return false;
		} else if($('#answer').val()=="" || $('#answer').val().trim().length==0) {
			document.getElementById("ckAnswer").innerHTML = "답변을 입력하세요.";
			document.getElementById("answer").focus();
			$("#ckName").hide();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckText").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").show();
			return false;
		} else if ($('#pw').val()=="") {
			$("#ckName").hide();
			$("#ckGender").hide();
			$("#ckPhone").hide();
			$("#ckText").hide();
			$("#ckPw").hide();
			$("#ckRepw").hide();
			$("#ckHint").hide();
			$("#ckAnswer").hide();
			$('#con').html('패스워드를 입력해주세요.');
			$('#refreshBtn').hide();
			$('#closeBtn').show();
			$('#myModal').show();
			return false;
		}		
	}
	
	function changePass() {
		var pwExp=/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,20}$/;
		
		if($('#cur_pw').val() == "") {
			document.getElementById("alert1").innerHTML = "현재 패스워드를 입력해 주세요.";
			$('#alert1').show();
			$('#alert2').hide();
			$('#alert3').hide();
			$('#alert4').hide();
			return false;
		} else if($('#new_pw1').val() == "") {
			$('#alert1').hide();
			document.getElementById("alert2").innerHTML = "새로운 패스워드를 입력해 주세요.";
			$('#alert2').show();
			$('#alert3').hide();
			$('#alert4').hide();
			return false;
		}  else if(! $('#new_pw1').val().match(pwExp)) {
			$('#alert1').hide();
			document.getElementById("alert2").innerHTML = "패스워드를 알맞은 형식으로 입력해주세요.";
			$('#alert2').show();
			$('#alert3').hide();
			$('#alert4').hide();
			return false;
		}  else if($('#new_pw2').val() == "") {
			$('#alert1').hide();
			$('#alert2').hide();
			document.getElementById("alert3").innerHTML = "새 패스워드 확인을 입력해 주세요.";
			$('#alert3').show();
			$('#alert4').hide();
			return false;
		} else if($('#new_pw1').val() != $('#new_pw2').val()) {
			$('#alert1').hide();
			$('#alert2').hide();
			$('#alert3').hide();
			document.getElementById("alert4").innerHTML = "새 패스워드를 확인해 주세요.";
			$('#alert4').show();
			return false;
		}
	}

	function close_del(flag) {
	    $('#delModal').hide();
	}
	
	function delCheck(id, spot) {
		console.log("delCheck()의 id="+id+"spot="+spot);
		$('#delId').val(id);
		$('#spotId').val(spot);
		$('#delModal').show();
	}
	
	function delBook() {
		var delId = $('#delId').val();
		var spot = $('#spotId').val();
		console.log("delBook()의 delId="+delId+"spot="+spot);
		$.ajax({
			type: "POST",
			url: "/ebook/mypage",
			data: "spot=" + spot + "&delId="+delId ,
			success: function() {
				$('#delModal').hide();
				window.location.href="/ebook/mypage?spot="+spot+"&page=1";
			}			
		});
	}
</script>
<style type="text/css">
	.alertSmall {
		color : red;
	}
	
	.sideRemain {
		background-color: #B2CCFF;
	}
</style>
<body>

<%@ include file="../include/header.jsp" %>
<div style="position: fixed; top: 103px; width: 100%; height: 100%; background-color: #F6F6F6">
<div style="width: 1000px; margin: 0 auto; height: 100%; background-color: white;">
	
	<div id="sidebar-wrapper" class="sidebar-toggle">
		<ul class="sidebar-nav">
	    	<li>
	      		<a href="/ebook/mypage?spot=infoPw">개인정보 및 패스워드 재설정</a>
	    	</li>
	    	<li>
	      		<a href="/ebook/mypage?spot=upBookList">내가 올린 책</a>
	    	</li>
	    	<li>
	      		<a href="/ebook/mypage?spot=buyList">구매목록</a>
	    	</li>
	  	</ul>
	</div>		
	
	<div style="width: 700px;">
		<c:choose>
			<c:when test="${spot eq 'infoPw' }">
				<div id="myModal" class="modal">
					<!-- Modal content -->
					<div class="modal-content">
					          <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알림</span></b></span></p>
					          <p style="text-align: center; line-height: 1.5;"><br />
					          <span id="con"></span>
					          </p>
					          <p><br /></p>
					      <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" id="refreshBtn" onClick="close_pop();">
					          <span class="pop_bt" style="font-size: 13pt;" >닫기</span>
					      </div>
					      <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" id="closeBtn" onClick="mdclose();">
					          <span class="pop_bt" style="font-size: 13pt;" >닫기</span>
					      </div>
					</div>
				 </div>
				<!--  -->
				<div id="test">
					<div>
						<h2>개인정보</h2>
						<input type="hidden" id="check" name="check" value="${check }">
						<form accept-charset="UTF-8" role="form" name="infoForm" action="infoModify" method="post" onsubmit="return inputCheck();"  style="padding-top: 20px;">
							<div>
								<label style="width: 100px;">아이디</label> ${authInfo.mid } <br>
								<label style="width: 100px;">이름</label> <input type="text" id="name" name="name" value="${authInfo.name }"/>
								<small style="margin-left: 100px;" class="alertSmall" id="ckName"></small>
							</div>
							<div>
								<c:choose>
									<c:when test="${authInfo.gender == 'm' }" >
										<label style="width: 100px;">성별</label> <input type="radio" name="gender" value="m" checked="checked"/>남
										&nbsp; &nbsp; <input type="radio" name="gender" value="f" />여
									</c:when>
									<c:otherwise>
										<label style="width: 100px;">성별</label> <input type="radio" name="gender" value="m"/>남
										&nbsp; &nbsp; <input type="radio" name="gender" value="f"  checked="checked" />여
									</c:otherwise>
								</c:choose>
								<small style="margin-left: 100px;" class="alertSmall" id="ckGender"></small>
							</div>
							<div>
								<label style="width: 100px;">휴대전화</label> <input type="text" id="phone" name="phone" value="${authInfo.phone }"/>
								<small>(010-xxxx-xxxx 형식으로 입력)</small><br>
								<small style="margin-left: 100px;" class="alertSmall" id="ckPhone"></small>
							</div>
							<div>
								<label style="width: 100px;">힌트<small>(20자이내)</small></label> 
								<select id="hint" name="hint" onchange="hintEdit();" style="height: 25px;">
									<option value="가장 좋아하는 색깔은?" <c:if test="${authInfo.hint eq '가장 좋아하는 색깔은?'}"> selected </c:if>>가장 좋아하는 색깔은?</option> 
									<option value="가장 소중한 보물은?" <c:if test="${authInfo.hint eq '가장 소중한 보물은?'}"> selected </c:if>>가장 소중한 보물은?</option>
									<option value="어렸을 적 짝꿍의 이름은?" <c:if test="${authInfo.hint eq '어렸을 적 짝꿍의 이름은?'}"> selected </c:if>>어렸을 적 짝꿍의 이름은?</option>
									<option value="기억에 남는 장소는?" <c:if test="${authInfo.hint eq '기억에 남는 장소는?'}"> selected </c:if>>기억에 남는 장소는?</option>
									<option value="기타" <c:if test="${authInfo.hint ne '가장 좋아하는 색깔은?'
																	 && authInfo.hint ne '가장 소중한 보물은?'
																	 && authInfo.hint ne '어렸을 적 짝꿍의 이름은?'
																	 && authInfo.hint ne '기억에 남는 장소는?'}"> selected 
														</c:if>>기타</option>
								</select> 
								<c:choose>
									<c:when test="${authInfo.hint ne '가장 좋아하는 색깔은?'
													&& authInfo.hint ne '가장 소중한 보물은?'
													&& authInfo.hint ne '어렸을 적 짝꿍의 이름은?'
													&& authInfo.hint ne '기억에 남는 장소는?'}">
										<input id="hint2" name="hint2" type="text" value="${authInfo.hint }" class="input-text-control" maxlength="20" /> 
									</c:when>
									<c:otherwise>
										<input id="hint2" name="hint2" type="text" value="${authInfo.hint }" class="input-text-control" maxlength="20" readonly />
									</c:otherwise>
								</c:choose>
								<small style="margin-left: 100px;" class="alertSmall" id="ckHint"></small>
							</div>
							<div>
								<label style="width: 100px">답변<small>(20자이내)</small></label> <input id="answer" name="answer" type="text" value="${authInfo.answer }" maxlength="20"/>
								<small style="margin-left: 100px;" class="alertSmall" id="ckAnswer"></small>
							</div>
							<div>
								<label style="width: 100px;">보유포인트</label> ${authInfo.point } point
							</div>
							<label style="width: 100px;">패스워드</label> <input type="password" id="pw" name="pw" /> <br>
							<div style="text-align: center; margin-top: 20px;"><input class="submitBtn" type="submit" value="수정"/></div>
						</form>
					</div>
					
					<br>
					<div>
						<input type="hidden" id="checkPw" value="${changePw }"/>
						<h2>패스워드 재설정</h2>
						<form accept-charset="UTF-8" role="form" name="passForm" action="passModify" method="post" onsubmit="return changePass();" style="padding-top: 20px;">
							<div>
								<label style="width: 140px;">현재 패스워드 &nbsp;</label><input type="password" id="cur_pw" name="cur_pw" /> 
								<small class="alertSmall" id="alert1" ></small>
								<br>
								<label style="width: 140px;">새 패스워드 &nbsp;</label><input type="password" id="new_pw1" name="new_pw1" /> 
								<small class="alertSmall" id="alert2" ></small><br>
								<small>(영어, 숫자 또는 특수문자 조합 8~20 글자)</small>
								<br>
								<label style="width: 140px;">새 패스워드 확인 &nbsp;</label><input type="password" id="new_pw2" name="new_pw2" />
								<small class="alertSmall" id="alert3" ></small><br>
								<small class="alertSmall" id="alert4" ></small>
							</div>
							<div style="text-align: center; margin-top: 20px;"><input class="submitBtn" type="submit" value="확인"/></div>
						</form>
					</div>
				</div>
			</c:when>
			<c:otherwise>			
				<%
					int listcount = ((Integer)request.getAttribute("listcount")).intValue();
					int nowpage = ((Integer)request.getAttribute("page")).intValue();
					int maxpage = ((Integer)request.getAttribute("maxpage")).intValue();
					int startpage = ((Integer)request.getAttribute("startpage")).intValue();
					int endpage = ((Integer)request.getAttribute("endpage")).intValue();
					System.out.println(nowpage);
					System.out.println(nowpage);
				%>		
				<div id="delModal" class="modal">
					<!-- Modal content -->
					<input type="hidden" id="delId" />
					<input type="hidden" id="spotId" />
					<div class="modal-content">
			          <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알림</span></b></span></p>
			          <p style="text-align: center; line-height: 1.5;"><br />
			          <span id="">정말로 삭제하시겠습니까?</span>
			          </p>
			          <p><br /></p>
			          <div style="text-align: center;">
				          <span style="cursor:pointer;background-color:#DDDDDD; text-align: center;padding-bottom: 10px;padding-top: 10px; margin: 5px;" onClick="delBook();">
					          <span class="pop_bt" style="font-size: 13pt;" > 확인 </span>
					      </span>
					      <span style="cursor:pointer;background-color:#DDDDDD; text-align: center;padding-bottom: 10px;padding-top: 10px; margin: 5px;" onClick="close_del();">
					          <span class="pop_bt" style="font-size: 13pt;" > 닫기 </span>
					      </span>
				      </div>
					</div>
				 </div>
				<c:choose>			
					<c:when test="${spot eq 'upBookList' }">
						<div id="test">
							<h2>내가 올린 책 목록</h2>
							<c:choose>
								<c:when test="${empty upbook}">
									<p>작성하신 책이 없습니다.</p>
								</c:when>
								<c:otherwise>
									<table>
										<tbody>
											<c:forEach var="ulist"  items="${upbook }">
												<tr style="border-bottom: 1px solid #8C8C8C;">
													<td>
														<c:choose>
															<c:when test="${!empty ulist.cover_path }">
																<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/cuploads/${ulist.bid }_coverFile"/></th>
															</c:when>
															<c:otherwise>
																<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/no_image.png"/></th>
															</c:otherwise>
														</c:choose>
													</td>
													<td style="width: 300px;">
														<label>카테고리: </label> ${ulist.book_cate } <br>
														<label>제목: </label> ${ulist.book_title1 } <br>
														<label>작가: </label> ${ulist.book_writer1 } <br>
														<label>작성일: </label> ${ulist.book_date } <br>
														<label>판매량: </label> ${ulist.book_vol } <br>
													</td>
													<td style="width: 100px;">
														<label>가격: ${ulist.price }</label>
													</td>
													<td>
														<button class="normalBtn" style="margin-bottom: 3px;" onclick="location.href='/ebook/bookDetail?bid=${ulist.bid }'">상세보기</button><br>
														<button class="normalBtn" style="margin-bottom: 3px;" onclick="window.open('./viewer.jsp?title=${ulist.book_title1}&writer=${ulist.book_writer1 }&pfile=${ulist.bid }_pdfFile&mid=${authInfo.mid }&lastpage=${ulist.lastpage }&bid=${ulist.bid }', '내가 올린 책 ${ulist.bid }')">읽기</button><br>
														<button class="modifyBtn" style="margin-bottom: 3px;" onclick="location.href='/ebook/modifyBook?bid=${ulist.bid}'">수정</button><br>
														<button class="deleteBtn" style="margin-bottom: 3px;" onclick="delCheck('${ulist.bid}', 'upBookList');">삭제</button>
													</td>
												</tr>
											</c:forEach>
											<% if(listcount > 5) { %>
											<tr align="center" height="20">
												<td colspan=7>
													<% if(nowpage<=1){ %>
													[이전]&nbsp;
													<%} else { %>
													<a href="/ebook/mypage?page=<%= nowpage-1 %>&spot=${spot}">[이전]</a>&nbsp;
													<%} %>
													
													<% for(int a = startpage; a <= endpage; a++) {
														if(a==nowpage){%>
														[<%=a %>]
														<%} else { %>
														<a href="/ebook/mypage?page=<%= a %>&spot=${spot}">[<%= a %>]</a>&nbsp;
														<%} %>
													<%} %>
													
													<%if(nowpage >= maxpage) {%>
													[다음]
													<%} else { %>
													<a href="/ebook/mypage?page=<%= nowpage+1 %>&spot=${spot}">[다음]</a>
													<%} %>
												</td>
											</tr> 
											<%} %>
										</tbody>
									</table>
								</c:otherwise>
							</c:choose>
						</div>
					</c:when>
					
					<c:otherwise>
						<div id="test">
							<h2>구매목록</h2>
							<c:choose>
								<c:when test="${empty purbook}">
									<p>구매하신 책이 없습니다.</p>
								</c:when>
								<c:otherwise>
									<table>
										<tbody>
											<c:forEach var="plist" items="${purbook }">
												<tr>
													<th style="width: 150px;">구매일: ${plist.buy_date }</th>
												</tr>
												<tr style="border-bottom: 1px solid #8C8C8C;">
													<c:choose>
														<c:when test="${!empty plist.cover_name }">
															<td>
																<img style="width: 100px; height: 100px; margin-left: 35px;" src="/ebook/cuploads/${plist.bid }_coverFile" />
															</td>
														</c:when>
														<c:otherwise>
															<td>
																<img style="width: 100px; height: 100px; margin-left: 35px;" src="/ebook/no_image.png" />
															</td>
														</c:otherwise>
													</c:choose>				
													<td style="width: 300px;">
														<label style="width: 70px; text-align: right;">카테고리: &nbsp;</label> ${plist.book_cate } <br>
														<label style="width: 70px; text-align: right;">제목: &nbsp;</label> ${plist.book_title1 } <br> 
														<label style="width: 70px; text-align: right;">작가: &nbsp;</label> ${plist.book_writer1 } <br>
														<label style="width: 70px; text-align: right;">작성일: &nbsp;</label> ${plist.book_date } <br> 
														<label style="width: 70px; text-align: right;">판매량: &nbsp;</label> ${plist.book_vol } <br>
													</td>
													<td style="width: 100px;">
														<label>가격: ${plist.price }</label>
													</td>
													<td style="width: 100px;">
														<button class="normalBtn" style="margin-bottom: 3px;" onclick="location.href='/ebook/bookDetail?bid=${plist.bid }'">상세보기</button><br>
														<button class="normalBtn" style="margin-bottom: 3px;" onclick="window.open('./viewer.jsp?title=${plist.book_title1}&writer=${plist.book_writer1 }&pfile=${plist.bid }_pdfFile&mid=${authInfo.mid }&lastpage=${plist.lastpage }&bid=${plist.bid }', '내가 올린 책 ${plist.bid }')">읽기</button><br>
														<button class="deleteBtn" style="margin-bottom: 3px;" onclick="delCheck('${plist.pur_id}', 'buyList')">삭제</button><br>
													</td>
												</tr>
											</c:forEach>
											<% if(listcount > 5) { %>
											<tr align="center" height="20">
												<td colspan=7>
													<% if(nowpage<=1){ %>
													[이전]&nbsp;
													<%} else { %>
													<a href="/ebook/mypage?page=<%= nowpage-1 %>&spot=${spot}">[이전]</a>&nbsp;
													<%} %>
													
													<% for(int a = startpage; a <= endpage; a++) {
														if(a==nowpage){%>
														[<%=a %>]
														<%} else { %>
														<a href="/ebook/mypage?page=<%= a %>&spot=${spot}">[<%= a %>]</a>&nbsp;
														<%} %>
													<%} %>
													
													<%if(nowpage >= maxpage) {%>
													[다음]
													<%} else { %>
													<a href="/ebook/mypage?page=<%= nowpage+1 %>&spot=${spot}">[다음]</a>
													<%} %>
												</td>
											</tr> 
											<%} %>
										</tbody>
									</table>
								</c:otherwise>
							</c:choose>
						</div>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</div>
</div>
</div>		
</body>
