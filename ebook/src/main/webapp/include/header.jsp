<%@ page import="member.AuthInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
%>

<div>
	<div>
		<c:if test="${empty authInfo }">
			<a href="/ebook/login" class="btn btn-custom" style="width:119px">로그인</a>
			<a href="/ebook/join" class="btn btn-custom" style="width:119px">회원가입</a>
		</c:if>
		<c:if test="${! empty authInfo }">
			<label><c:out value="${authInfo.name }(${authInfo.mid })" />님</label>
			<a href="" class="btn btn-custom" style="width:119px">MyPage</a>
			<a href="" class="btn btn-custom" style="width:119px">포인트 충전</a>
			<a href="/ebook/upbook" class="btn btn-custom" style="width:119px">책 올리기</a>
			<a href="/ebook/logout" class="btn btn-custom" style="width:119px">로그아웃</a>
		</c:if>
	</div>
	
</div>