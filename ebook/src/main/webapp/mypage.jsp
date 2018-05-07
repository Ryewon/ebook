<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyPage</title>	

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mypage.css?ver=323" />
</head>
<script>

$(document).ready(function(){
	$('#infoPw').show();
	$('#upBookList').hide();
	$('#buyList').hide();
});


  function change(input){
	  console.log(input);
	  if(input=='infoPw') {
		 /*  $('#buyList').css('display','none');
		  $('#upBookList').css('display','none');
		  $('#infoPw').css('display','block'); */
			$('#infoPw').show();
			$('#upBookList').hide();
			$('#buyList').hide();
	  } else if (input=='upBookList') {
		 /*  $('#buyList').css('display','none');
		  $('#infoPw').css('display','none');
		  $('#upBookList').css('display','block'); */
			$('#infoPw').hide();
			$('#upBookList').show();
			$('#buyList').hide();
	  } else {
		/*   $('#infoPw').css('display','none');
		  $('#upBookList').css('display','none');
		  $('#buyList').css('display','block'); */
			$('#infoPw').hide();
			$('#upBookList').hide();
			$('#buyList').show();
	  }
  }
</script>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container" style="position:fixed; top: 95px;">
	<div>
		<div id="sidebar-wrapper" class="sidebar-toggle">
			<ul class="sidebar-nav">
		    	<li>
		      		<a href="#" onclick="change('infoPw');">개인정보 및 패스워드 재설정</a>
		    	</li>
		    	<li>
		      		<a href="#" onclick="change('upBookList');">내가 올린 책</a>
		    	</li>
		    	<li>
		      		<a href="#" onclick="change('buyList');">구매목록</a>
		    	</li>
		  	</ul>
		</div>		
	</div>
	
	<div id="infoPw" >
	  <jsp:include page="/mypage/infoPw.jsp"></jsp:include>
	</div>
	
	<div id="upBookList">
	  <jsp:include page="/mypage/upBookList.jsp"></jsp:include>
	</div>
	
	<div id="buyList">
	  <jsp:include page="/mypage/buyList.jsp"></jsp:include>
	</div>

</div>		
</body>
