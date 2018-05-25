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
			var pathpoint = input.value.lastIndexOf('.');
			var filepoint = input.value.substring(pathpoint + 1, input.length);
			var filetype = filepoint.toLowerCase();
			if(filetype=='jpg'||filetype=='gif'||filetype=='png'||filetype=='jpeg') {
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					
					reader.onload = function (e) {
						$('#imgView').attr('src', e.target.result);
					}
					reader.readAsDataURL(input.files[0]);
				} else {
					$('#imgView').attr('src', '/ebook/no_image.png');
				}
			} else if(filetype=='') {
				$('#imgView').attr('src', '/ebook/no_image.png');
			} else {
				alert('지원하지 않는 파일형식입니다.');
				$('#imgView').attr('src', '/ebook/no_image.png');
				input.value="";
			}
		}
		
		function changePfile(input) {
			var pathpoint = input.value.lastIndexOf('.');
			var filepoint = input.value.substring(pathpoint + 1, input.length);
			var filetype = filepoint.toLowerCase();
			if(filetype!='pdf' && filetype!='') {
				alert('지원하지 않는 파일형식입니다.');
				input.value="";
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
				$('#mcloseBtn').val("닫기");
				$('#mSubmitBtn').hide();
				$('#myModal').show();
			} else if (freeCk=='유료' && $('#price').val()=='') {			
				$('#con').html('유료 가격을 입력하세요.');
				$('#mcloseBtn').val("닫기");
				$('mSubmitBtn').hide();
				$('#myModal').show();
			} else if (title == "") {			
				$('#con').html('제목을 입력하세요.');
				$('#mcloseBtn').val("닫기");
				$('#mSubmitBtn').hide();
				$('#myModal').show();
			} else if (pfile == "") {
				$('#con').html('pdf 파일을 올려주세요.');
				$('#mcloseBtn').val("닫기");
				$('#mSubmitBtn').hide();
				$('#myModal').show();
			} else {
				$('#con').html('책을 게시하시겠습니까?');
				$('#mcloseBtn').val("취소");
				$('#mSubmitBtn').show();
				$('#myModal').show();
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
<div style=" width: 100%; height: 100%; position: fixed; background-color: #F6F6F6;">
<div style="top: 90px; position: fixed; width: 1000px; margin:0 24%; height: 100%; background-color: white; padding: 30px 10%;">
		<h2>책 올리기</h2>	<br><br><br>
		<form accept-charset="UTF-8" role="form" name="upBook" action="uploadBook" method="post" enctype="multipart/form-data">
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
			          <div style="text-align: center;">
					      <input class="submitBtn" type="submit" id="mSubmitBtn" value="확인">
					      <input type="button" id="mcloseBtn" class="submitBtn" onClick="close_pop();"/>
				      </div>
				</div>
			 </div>
				
		<div style="border: 1px;">
			<div>
				<label>카테고리</label> &nbsp;
				<select id="cate" name="cate" style="height: 25px;">
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
					<input type="text" id="price" name="price" onkeypress="onlyNum(this);" maxlength="5" readonly style="text-align: right"/>원<br>
					<small>5자리 이하로 입력가능</small>
				</div>
			</div>
			<br />
			<div>
				<div style="display: inline-table; width: 300px;">
					<img src="/ebook/no_image.png" id="imgView" name="imgView" style="width: 200px; height: 200px; border: 1px;">
				</div>
				<!-- <div style="position: absolute; left: 250px; top: 190px; display: inline-table; width: 400px;"> -->
				<div style="display: inline-table; width: 300px;">
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
					<input name="file" type="file" id ="pfile" accept=".pdf" onchange="changePfile(this)" /></label>
					<input type="hidden" id="pupdir" name="pupdir" value="<%=request.getRealPath("/puploads/")%>" />
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
			<br>
			<div style="text-align: center;"><input class="submitBtn" type="button" value="올리기" onclick="checkUpload();"></div>
		</div>
		</form>
</div>
</div>