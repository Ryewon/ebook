<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script>
	$(document).ready(function () {
		var cate = "<c:out value='${cate }'/>";
		console.log(cate);
		if(cate=='전체') {
			$('#topMenu li > a').eq(0).addClass('remain');
			$('#topMenu li > a').eq(1).removeClass('remain');
			$('#topMenu li > a').eq(2).removeClass('remain');
			$('#topMenu li > a').eq(3).removeClass('remain');
			$('#topMenu li > a').eq(4).removeClass('remain');
			$('#topMenu li > a').eq(5).removeClass('remain');
			$('#topMenu li > a').eq(6).removeClass('remain');
			$('#topMenu li > a').eq(7).removeClass('remain');
			$('#topMenu li > a').eq(8).removeClass('remain');
		} else if (cate=='소설') {
			$('#topMenu li > a').eq(0).removeClass('remain');
			$('#topMenu li > a').eq(1).addClass('remain');
			$('#topMenu li > a').eq(2).removeClass('remain');
			$('#topMenu li > a').eq(3).removeClass('remain');
			$('#topMenu li > a').eq(4).removeClass('remain');
			$('#topMenu li > a').eq(5).removeClass('remain');
			$('#topMenu li > a').eq(6).removeClass('remain');
			$('#topMenu li > a').eq(7).removeClass('remain');
			$('#topMenu li > a').eq(8).removeClass('remain');
		} else if (cate=='만화') {
			$('#topMenu li > a').eq(0).removeClass('remain');
			$('#topMenu li > a').eq(1).removeClass('remain');
			$('#topMenu li > a').eq(2).addClass('remain');
			$('#topMenu li > a').eq(3).removeClass('remain');
			$('#topMenu li > a').eq(4).removeClass('remain');
			$('#topMenu li > a').eq(5).removeClass('remain');
			$('#topMenu li > a').eq(6).removeClass('remain');
			$('#topMenu li > a').eq(7).removeClass('remain');
			$('#topMenu li > a').eq(8).removeClass('remain');
		} else if (cate=='시/에세이') {
			$('#topMenu li > a').eq(0).removeClass('remain');
			$('#topMenu li > a').eq(1).removeClass('remain');
			$('#topMenu li > a').eq(2).removeClass('remain');
			$('#topMenu li > a').eq(3).addClass('remain');
			$('#topMenu li > a').eq(4).removeClass('remain');
			$('#topMenu li > a').eq(5).removeClass('remain');
			$('#topMenu li > a').eq(6).removeClass('remain');
			$('#topMenu li > a').eq(7).removeClass('remain');
			$('#topMenu li > a').eq(8).removeClass('remain');
		} else if (cate=='역사/문화') {
			$('#topMenu li > a').eq(0).removeClass('remain');
			$('#topMenu li > a').eq(1).removeClass('remain');
			$('#topMenu li > a').eq(2).removeClass('remain');
			$('#topMenu li > a').eq(3).removeClass('remain');
			$('#topMenu li > a').eq(4).addClass('remain');
			$('#topMenu li > a').eq(5).removeClass('remain');
			$('#topMenu li > a').eq(6).removeClass('remain');
			$('#topMenu li > a').eq(7).removeClass('remain');
			$('#topMenu li > a').eq(8).removeClass('remain');
		} else if (cate=='예술') {
			$('#topMenu li > a').eq(0).removeClass('remain');
			$('#topMenu li > a').eq(1).removeClass('remain');
			$('#topMenu li > a').eq(2).removeClass('remain');
			$('#topMenu li > a').eq(3).removeClass('remain');
			$('#topMenu li > a').eq(4).removeClass('remain');
			$('#topMenu li > a').eq(5).addClass('remain');
			$('#topMenu li > a').eq(6).removeClass('remain');
			$('#topMenu li > a').eq(7).removeClass('remain');
			$('#topMenu li > a').eq(8).removeClass('remain');
		} else if (cate=='기술') {
			$('#topMenu li > a').eq(0).removeClass('remain');
			$('#topMenu li > a').eq(1).removeClass('remain');
			$('#topMenu li > a').eq(2).removeClass('remain');
			$('#topMenu li > a').eq(3).removeClass('remain');
			$('#topMenu li > a').eq(4).removeClass('remain');
			$('#topMenu li > a').eq(5).removeClass('remain');
			$('#topMenu li > a').eq(6).addClass('remain');
			$('#topMenu li > a').eq(7).removeClass('remain');
			$('#topMenu li > a').eq(8).removeClass('remain');
		} else if (cate=='논문') {
			$('#topMenu li > a').eq(0).removeClass('remain');
			$('#topMenu li > a').eq(1).removeClass('remain');
			$('#topMenu li > a').eq(2).removeClass('remain');
			$('#topMenu li > a').eq(3).removeClass('remain');
			$('#topMenu li > a').eq(4).removeClass('remain');
			$('#topMenu li > a').eq(5).removeClass('remain');
			$('#topMenu li > a').eq(6).removeClass('remain');
			$('#topMenu li > a').eq(7).addClass('remain');
			$('#topMenu li > a').eq(8).removeClass('remain');
		} else if (cate=='외국도서') {
			$('#topMenu li > a').eq(0).removeClass('remain');
			$('#topMenu li > a').eq(1).removeClass('remain');
			$('#topMenu li > a').eq(2).removeClass('remain');
			$('#topMenu li > a').eq(3).removeClass('remain');
			$('#topMenu li > a').eq(4).removeClass('remain');
			$('#topMenu li > a').eq(5).removeClass('remain');
			$('#topMenu li > a').eq(6).removeClass('remain');
			$('#topMenu li > a').eq(7).removeClass('remain');
			$('#topMenu li > a').eq(8).addClass('remain');
		} else {
			$('#topMenu li > a').eq(0).removeClass('remain');
			$('#topMenu li > a').eq(1).removeClass('remain');
			$('#topMenu li > a').eq(2).removeClass('remain');
			$('#topMenu li > a').eq(3).removeClass('remain');
			$('#topMenu li > a').eq(4).removeClass('remain');
			$('#topMenu li > a').eq(5).removeClass('remain');
			$('#topMenu li > a').eq(6).removeClass('remain');
			$('#topMenu li > a').eq(7).removeClass('remain');
			$('#topMenu li > a').eq(8).removeClass('remain');
		}
	});
</script>

<style>

</style>

<div style="width: 100%; position: fixed; border-bottom: 4px solid #4f5467;">
<nav id="topMenu">
	<ul>
		<li><a class="menuLink" href="/ebook/searchBook?cate=전체&price=전체&sortType=최신순">Best&신간 도서</a></li>
		<li><a class="menuLink" href="/ebook/searchBook?cate=소설&price=전체&sortType=최신순">소설</a></li>
		<li><a class="menuLink" href="/ebook/searchBook?cate=만화&price=전체&sortType=최신순">만화</a></li>
		<li><a class="menuLink" href="/ebook/searchBook?cate=시/에세이&price=전체&sortType=최신순">시/에세이</a></li>
		<li><a class="menuLink" href="/ebook/searchBook?cate=역사/문화&price=전체&sortType=최신순">역사/문화</a></li>
		<li><a class="menuLink" href="/ebook/searchBook?cate=예술&price=전체&sortType=최신순">예술</a></li>
		<li><a class="menuLink" href="/ebook/searchBook?cate=기술&price=전체&sortType=최신순">기술</a></li>
		<li><a class="menuLink" href="/ebook/searchBook?cate=논문&price=전체&sortType=최신순">논문</a></li>
		<li><a class="menuLink" href="/ebook/searchBook?cate=외국도서&price=전체&sortType=최신순">외국도서</a></li>
	</ul> 
</nav>
</div>