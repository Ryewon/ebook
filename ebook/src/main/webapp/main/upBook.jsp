<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
	<title>책 올리기</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/modal.css?ver=33" />
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-latest.js"></script> 
	<script>
		function priceCk(input) {
			if(input == 'free') {
				$('#price').attr('readonly', true);
			} else {
				$('#price').attr('readonly', false);
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
			} else {
				$('#imgView').attr('src', '/ebook/no_image.png');
			}
		}
	
		function checkUpload() {
			var radio = $("input:radio[name='free']").is(':checked');
			var price = $("input:radio[name='free']").val();
			var title = $('#title').val();
			var pfile = $('#pfile').val();
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
		<h1>책 올리기</h1>	
		<form accept-charset="UTF-8" role="form" name="upBook" action="uploadBook" method="post" 
		enctype="multipart/form-data" onsubmit="return checkUpload();">
		<div style="border: 1px;">
			<div>
				<label>카테고리</label> &nbsp;
				<select id="cate" name="cate">
					<option value="소설">소설</option>
					<option value="만화">만화</option>
					<option value="시/에세이">시/에세이</option>
					<option value="역사/문화">역사/문화</option>
					<option value="예술">예술</option>
					<option value="기술">기술</option>
					<option value="논문">논문</option>
					<option value="외국도서">외국도서</option>
				</select>
			</div>
			<br />
			<div>
				<div style="display: inline-table; width: 300px">
					<label>유료/무료</label> &nbsp;
					<input type="radio" name="free" value="유료" onclick="priceCk('non_free');"/>유료 &nbsp; &nbsp;
					<input type="radio" name="free" value="무료" onclick="priceCk('free');" />무료
				</div>
				<div style="display: inline-table; width: 300px">
					<label>가격</label> &nbsp;
					<input type="text" id="price" name="price"  readonly />원
				</div>
			</div>
			<br />
			<div>
				<div style="display: inline-table; width: 300px;">
					<img src="/ebook/no_image.png" id="imgView" name="imgView" style="width: 200px; height: 200px; border: 1px;">
				</div>
				<!-- <div style="position: absolute; left: 250px; top: 190px; display: inline-table; width: 400px;"> -->
				<div style="display: inline-table; width: 400px;">
					<label>표지 첨부</label> &nbsp;
					<label style="display: inline-table;">
					<input name="file" type="file" accept=".gif, .jpeg, .jpg, .png" onchange="readURL(this);" /></label>
					<input type="hidden" id="cupdir" name="cupdir" value="<%=request.getRealPath("/cuploads/")%>" />
					<br>
					<label>제목</label> &nbsp;
					<input type="text" id="title" name="title"/>
					<br>
					<label>PDF 첨부</label> &nbsp;
					<label style="display: inline-table;">
					<input name="file" type="file" id ="pfile" accept=".pdf" onchange="" /></label>
					<input type="hidden" id="pupdir" name="pupdir" value="<%=request.getRealPath("/puploads/")%>" />
					<input type="hidden" id="iupdir" name="iupdir" value="<%=request.getRealPath("/iuploads/")%>" />
				</div>
			</div>
			<br>
	
			<div>
				<label>책 소개 내용</label><br>
				<textarea rows="" cols="" id="intro" name="intro" style="width:700px; resize: none; overflow-y: scroll"></textarea>
			</div>
			<br>
			<div>
				<label>목차</label><br>
				<textarea rows="" cols="" id="con_table" name="con_table" style="width:700px; resize: none; overflow-y: scroll"></textarea>
			</div>
			<input type="submit" value="올리기">
		</div>
		</form>
</div>