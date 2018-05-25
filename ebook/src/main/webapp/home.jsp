<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
	<title>RWeBook</title>
</head>
<body>
<div>
<%@ include file="./include/header.jsp" %>

<%@ include file="./main/main.jsp" %>
<c:if test="${uploadOk eq '1'}"><script>alert("책이 성공적으로 게시되었습니다.");</script></c:if>
</div>
</body>
</html>
