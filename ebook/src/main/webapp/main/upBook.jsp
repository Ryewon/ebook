<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<head>
	<title>책 올리기</title>
</head>
<div>
	<h1>책 올리기</h1>
	<form accept-charset="UTF-8" role="form" name="upBook" action="uploadBook" method="post" enctype="multipart/form-data">
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
				<input type="radio" name="free" value="m"/>유료 &nbsp; &nbsp;
				<input type="radio" name="free" value="f"/>무료
			</div>
			<div style="display: inline-table; width: 300px">
				<label>가격</label> &nbsp;
				<input type="text" id="price" name="price" />원
			</div>
		</div>
		<br />
		<div>
			<div style="display: inline-table; width: 300px;">
				<img src="/ebook/no_image.png" id="" name="" style="width: 200px; height: 200px; border: 1px;">
			</div>
			<!-- <div style="position: absolute; left: 250px; top: 190px; display: inline-table; width: 400px;"> -->
			<div style="display: inline-table; width: 400px;">
				<label>표지 첨부</label> &nbsp;
				<label style="display: inline-table;">
				<input id="cfile" name="cfile" type="file" accept=".gif, .jpeg, .jpg, .png" onchange="" /></label>
				<input type="hidden" id="cupdir" name="cupdir" value="<%=request.getRealPath("/cuploads/")%>" />
				<br>
				<label>제목</label> &nbsp;
				<input type="text" id="title" name="title"/>
				<br>
				<label>PDF 첨부</label> &nbsp;
				<label style="display: inline-table;">
				<input id="pfile" name="pfile" type="file" accept=".pdf" onchange="" /></label>
				<input type="hidden" id="pupdir" name="pupdir" value="<%=request.getRealPath("/cuploads/")%>" />
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