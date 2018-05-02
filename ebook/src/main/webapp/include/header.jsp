<%@ page import="member.AuthInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css?ver=3223" />

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
</script>


<div class="menu">
	<div class="container-fluid">
		<ul class="nav navbar-nav navbar-right">
			<c:if test="${empty authInfo }">
				<li><a href="/ebook/login" class="btn btn-custom" style="width:119px">로그인</a></li>
				<li><a href="/ebook/join" class="btn btn-custom" style="width:119px">회원가입</a></li>
			</c:if>
			<c:if test="${! empty authInfo }">
				<li><label style="padding: 10px 35px"><c:out value="${authInfo.name }(${authInfo.mid })" />님</label></li>
				<li><a href="/ebook/mypage" class="btn btn-custom" style="width:119px">MyPage</a></li>
				<li><a href="" class="btn btn-custom" style="width:119px">포인트 충전</a></li>
				<li><a href="/ebook/upbook" class="btn btn-custom" style="width:119px">책 올리기</a></li>
				<li><a href="/ebook/logout" class="btn btn-custom" style="width:119px">로그아웃</a></li>
			</c:if>
		</ul>		
	</div>
	<div class="container" style="margin-top: 40px; margin-bottom: 20px;">
    <div class="row">    
        <div class="col-xs-8 col-xs-offset-2">
		    <div class="input-group">
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