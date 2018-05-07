<%@ page import="member.AuthInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css?ver=2223" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/modal.css?ver=3223" />
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<script>
	$(document).ready(function(e){
	    $('.search-panel .dropdown-menu').find('a').click(function(e) {
			e.preventDefault();
			var param = $(this).attr("href").replace("#","");
			var concept = $(this).text();
			$('.search-panel span#search_concept').text(concept);
			$('.input-group #search_param').val(param);
		});
	});
	
	function charge_show() {
		$('#charge_modal').show();
	}
	
	function modal_close() {
		$('#charge_modal').hide();
	}
	
	function charge_select() {
		$('#hmoney').val($('#mpoint').val());
		var chk = $('input:radio[name="chmoney"]:checked').val();
		var hmoney = $('#hmoney').val();

		if(chk == "cin") {
			  $("#cin_money").attr("disabled",false);
			  $('#ccmoney').val($('#cin_money').val());
			  var ccmoney = $('#ccmoney').val();
			  var camoney = Number(hmoney) + Number(ccmoney);
			  if(Number(camoney) >= 0) {
				  $('#camoney').val(camoney);  
			  } else {
				  $('#camoney').val(0);
			  }
		} else {
			$('#ccmoney').val(chk);
			var ccmoney = $('#ccmoney').val();
			var hmoney = $('#hmoney').val();
			var camoney = Number(hmoney) + Number(ccmoney);
			$("#cin_money").val("");
			$("#cin_money").attr("disabled",true);
			if(Number(camoney) >= 0) {
				  $('#camoney').val(camoney);  
			  } else {
				  $('#camoney').val(0);
			  } 
		}
	}
	
	function cin_charge(point) {
	    $(point).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	         $('#ccmoney').val($('#cin_money').val());
	    }); 
	}
	
	function charge() {
		var mid = $('#mid').val();
		$.ajax({
			type : "POST",
			url : "/ebook/charge",
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
</script>
<!-- 모달 -->
<div id="charge_modal" class="modal">
	<!-- Modal content -->
	<div class="modal-content">
	    <p style="text-align: center;">
	    	<span style="font-size: 14pt;">
	    		<b><span style="font-size: 24pt;">포인트 충전</span></b>
	    	</span>
	    </p>
	    <p style="text-align: center; line-height: 1.5;"><br />
	    	<div class="form-inline" style="padding-left: 15%;" onchange="charge_select();">
	    		<label>보유 포인트 : </label>&nbsp; ${authInfo.point }&nbsp;point <br/>
		      	<input id="coneth" type="radio" name="chmoney" value="1000" /> 
				<label for="coneth">1000원</label> &nbsp; &nbsp; &nbsp; &nbsp;
				<input id="cthrth" type="radio" name="chmoney" value="3000" /> 
				<label for="cthrth">3000원</label> &nbsp; &nbsp; &nbsp; &nbsp;
				<input id="cfivth" type="radio" name="chmoney" value="5000" /> 
				<label for="cfivth">5000원</label><br /> 
				<input id="ctenth" type="radio" name="chmoney" value="10000" /> 
				<label for="ctenth">10000원</label> &nbsp; &nbsp; &nbsp;
				<input id="cin" type="radio" name="chmoney" value="cin" /> 
				<label for="cin">직접입력
				<input class="form-control" onkeydown="cin_charge(this)" id="cin_money" type="text" name="cin_money" style="width: 100px" disabled/>원</label>
				<input type="hidden" id="ccmoney" name="ccmoney">
	    	</div>
	    </p>
	    <p><br /></p>
	    <div style="text-align: center;">
		    <span style="cursor:pointer;background-color:#DDDDDD; text-align: center;padding-bottom: 10px;padding-top: 10px; margin: 10px;" onClick="chare()">
				<span class="pop_bt" style="font-size: 13pt;" >충전</span>
		    </span>
			<span style="cursor:pointer;background-color:#DDDDDD; text-align: center;padding-bottom: 10px;padding-top: 10px; margin: 10px;" onClick="modal_close();">
				<span class="pop_bt" style="font-size: 13pt;" >닫기</span>
		    </span>
	    </div>
	</div>
 </div>

<!-- 헤더 -->
<div class="menu">
	<div class="container-fluid" style="height: 20px;">
		<input type="hidden" id="mid" name="mid">
		<ul class="nav navbar-nav navbar-right">
			<c:if test="${empty authInfo }">
				<li><a href="/ebook/login" class="btn btn-custom" style="width:119px">로그인</a></li>
				<li><a href="/ebook/join" class="btn btn-custom" style="width:119px">회원가입</a></li>
			</c:if>
			<c:if test="${! empty authInfo }">
				<li><label style="padding: 10px 35px"><c:out value="${authInfo.name }(${authInfo.mid })" />님</label></li>
				<li><a href="/ebook/mypage" class="btn btn-custom" style="width:119px">MyPage</a></li>
				<li><a href="#" class="btn btn-custom" style="width:119px" onclick="charge_show();">포인트 충전</a></li>
				<li><a href="/ebook/upbook" class="btn btn-custom" style="width:119px">책 올리기</a></li>
				<li><a href="/ebook/logout" class="btn btn-custom" style="width:119px">로그아웃</a></li>
			</c:if>
		</ul>		
	</div>
	<div class="container" style="text-align: center; margin-top: 30px; margin-bottom: 10px;">
	    <div class="row">    
	        <div class="col-xs-8 col-xs-offset-2">
			    <div class="input-group">
			    	<a href="./home"><img src="/ebook/logo.png" style="width: 100px; height: 40px;"></a>
	                <div class="input-group-btn search-panel">
	                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
	                    	<span id="search_concept">제목+작가</span> <span class="caret"></span>
	                    </button>
	                    <ul class="dropdown-menu" role="menu">
	                      <li><a href="#title_writer">제목+작가</a></li>
	                      <li><a href="#title">제목</a></li>
	                      <li><a href="#writer">작가</a></li>
	                    </ul>
	                </div>
	                <input type="hidden" name="search_param" value="all" id="search_param">         
	                <input type="text" class="form-control" name="x" placeholder="검색할 내용을 적어주세요">
	                <span class="input-group-btn">
	                    <button class="btn btn-default" type="button">검색</button>
	                </span>
	            </div>
	        </div>
		</div>
	</div>
</div>