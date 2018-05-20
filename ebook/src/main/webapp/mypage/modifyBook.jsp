<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<title>RWeBook</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/modal.css?ver=33" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<script>
	$(document).ready(function(){
		console.log("coverName="+$('#coverName').val());
		console.log("pfileName="+$('#pfileName').val());
	});
	
	function priceCk(input) {
		if(input == 'free') {
			$('#price').attr('readonly', true);
			$('#price').val("");
		} else {
			$('#price').attr('readonly', false);
			$('#price').focus();
		}
	}

	function readURL(input) {
		console.log("함수실행");
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			
			reader.onload = function (e) {
				$('#imgView').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
			$('#coverName').val(input.files[0].name);
		} else {
			$('#imgView').attr('src', '/ebook/no_image.png');
			$('#coverName').val("");
		}
		console.log("coverchange:" + $('#coverName').val());
	}
	
	function changePfile(input) {
		if (input.files && input.files[0]) {			
			$('#pfileName').val(input.files[0].name);
		} else {
			$('#pfileName').val("");
		}
		console.log("pfilechange:" + $('#pfileName').val());
	}

	function checkUpload() {
		var radio = $("input:radio[name='free']").is(':checked');
		var price = $("input:radio[name='free']").val();
		var title = $('#title').val();
		var pfile = $('#pfileName').val();
		var freeCk = $('input:radio[name=free]:checked').val();
		if (radio == false) {
			console.log("라디오");
			$('#con').html('유료/무료를 선택하세요.');
			$('#myModal').show();
			return false;
		} else if (freeCk=='유료' && $('#price').val()=='') {			
			$('#con').html('유료 가격을 입력하세요.');
			$('#myModal').show();
			return false;
		} else if (title == "") {			
			$('#con').html('제목을 입력하세요.');
			$('#myModal').show();
			return false;
		} else if (pfile == "") {
			$('#con').html('pdf 파일을 올려주세요.');
			$('#myModal').show();
			return false;
		}
	}
	
	function close_pop(flag) {
    	$('#myModal').hide();
    }
	
	function onlyNum(price) {
		 $(price).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    }); 
	}
	
</script>
</head>
<%@ include file="../include/header.jsp" %>
<div id="myModal" class="modal">
	<!-- Modal content -->
	<div class="modal-content">
	          <p style="text-align: center;">
	          	<span style="font-size: 14pt;">
	          		<b><span style="font-size: 24pt;">알림</span></b>
	          	</span>
	          </p>
	          <p style="text-align: center; line-height: 1.5;"><br />
	          <span id="con"></span>
	          </p>
	          <p><br /></p>
	      <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
	          <span class="pop_bt" style="font-size: 13pt;" >
	               닫기
	          </span>
	      </div>
	</div>
</div>
		
<div style="top: 90px; position: fixed; margin-left: 27.5%;">
	<h1>책 수정하기</h1>	
	<form accept-charset="UTF-8" role="form" name="modifyUpBook" action="modifyUpBook" method="post" 
	enctype="multipart/form-data" onsubmit="return checkUpload();">
	<input type="hidden" id="bid" name="bid" value="${book.bid }">
	<div style="border: 1px;">
		<div>
			<label>카테고리</label> &nbsp;
			<select id="cate" name="cate">
				<option value="소설" <c:if test="${book.book_cate eq '소설' }"> selected </c:if>>소설</option>
				<option value="만화" <c:if test="${book.book_cate eq '만화' }"> selected </c:if>>만화</option>
				<option value="시/에세이" <c:if test="${book.book_cate eq '시/에세이' }"> selected </c:if>>시/에세이</option>
				<option value="역사/문화" <c:if test="${book.book_cate eq '역사/문화' }"> selected </c:if>>역사/문화</option>
				<option value="예술" <c:if test="${book.book_cate eq '예술' }"> selected </c:if>>예술</option>
				<option value="기술" <c:if test="${book.book_cate eq '기술' }"> selected </c:if>>기술</option>
				<option value="논문" <c:if test="${book.book_cate eq '논문' }"> selected </c:if>>논문</option>
				<option value="외국도서" <c:if test="${book.book_cate eq '외국도서' }"> selected </c:if>>외국도서</option>
			</select>
		</div>
		<br />
		<div>
			<div style="display: inline-table; width: 300px">
				<label>유료/무료</label> &nbsp;
				<input type="radio" name="free" value="유료" onclick="priceCk('non_free');" <c:if test="${book.price ne '0' }">checked</c:if> />유료 &nbsp; &nbsp;
				<input type="radio" name="free" value="무료" onclick="priceCk('free');" <c:if test="${book.price eq '0' }">checked</c:if> />무료
			</div>
			<div style="display: inline-table; width: 300px">
				<label>가격</label> &nbsp;
				<c:if test="${book.price ne '0' }">
					<input type="text" id="price" name="price" value="${book.price }" />원
				</c:if>
				<c:if test="${book.price eq '0' }">
					<input type="text" id="price" name="price" onkeypress="onlyNum(this);" readonly />원
				</c:if>
			</div>
		</div>
		<br />
		<div>
			<div style="display: inline-table; width: 300px;">
				<c:if test="${empty book.cover_name}">
					<img src="/ebook/no_image.png" id="imgView" name="imgView" style="width: 200px; height: 200px; border: 1px;">
				</c:if>
				<c:if test="${! empty book.cover_name }">
					<img style="width: 200px; height: 200px; border: 1px;" src="/ebook/cuploads/${book.bid }_coverFile"  />
				</c:if>
			</div>
			<!-- <div style="position: absolute; left: 250px; top: 190px; display: inline-table; width: 400px;"> -->
			<div style="display: inline-table; width: 400px;">
				<label>표지 첨부</label> &nbsp;
				<label style="display: inline-table;">
				<input type="hidden" id="OrgCoverName" name="OrgCoverName" value="${book.cover_path }">
				<input type="hidden" id="coverName" name="coverName" value="${book.cover_path }">
				<input name="file" type="file" accept=".gif, .jpeg, .jpg, .png" onchange="readURL(this);"/></label>
				<input type="hidden" id="cupdir" name="cupdir" value="<%=request.getRealPath("/cuploads/")%>" />
				<br>
				<label>제목</label> &nbsp;
				<input type="text" id="title" name="title" value="${book.book_title1 }"/>
				<br>
				<label>PDF 첨부</label> &nbsp;
				<label style="display: inline-table;">
				<input type="hidden" id="OrgPfileName" name="OrgPfileName" value="${book.pfile_path }">
				<input type="hidden" id="pfileName" name="pfileName" value="${book.pfile_path }">
				<input name="file" type="file" id ="pfile" accept=".pdf" onchange="changePfile(this)" /></label>
				<input type="hidden" id="pupdir" name="pupdir" value="<%=request.getRealPath("/puploads/")%>" />
			</div>
		</div>
		<br>

		<div>
			<label>책 소개 내용</label><br>
			<textarea rows="" cols="" id="intro" name="intro" style="width:700px; resize: none; overflow-y: scroll">${book.book_intro }</textarea>
		</div>
		<br>
		<div>
			<label>목차</label><br>
			<textarea rows="" cols="" id="con_table" name="con_table" style="width:700px; resize: none; overflow-y: scroll">${book.contents_table }</textarea>
		</div>
		<input type="submit" value="올리기">
	</div>
	</form>
</div>