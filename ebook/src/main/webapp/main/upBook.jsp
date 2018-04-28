<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<head>
	<title>책 올리기</title>
</head>
<div>
	<h1>책 올리기</h1>
	<div style="border: 1px;">
		<div>
			<label>카테고리</label> &nbsp;
			<select>
				<option>소설</option>
				<option>만화</option>
				<option>시/에세이</option>
				<option>역사/문화</option>
				<option>예술</option>
				<option>기술</option>
				<option>논문</option>
				<option>외국도서</option>
			</select>
		</div>
		<br />
		<div>
			<div style="display: inline-table; width: 300px">
				<label>유료/무료</label> &nbsp;
				<input type="radio" name="gender" value="m"/>남 &nbsp; &nbsp;
				<input type="radio" name="gender" value="f"/>여
			</div>
			<div style="display: inline-table; width: 300px">
				<label>가격</label> &nbsp;
				<input type="text" id="price" name="price" />원
			</div>
		</div>
		<br />
		<div>
			<div style="display: inline-table; width: 300px;">
				<img alt="" src="" id="" name="" style="width: 200px; height: 150px; border: 1px;">
			</div>
			<!-- <div style="position: absolute; left: 250px; top: 190px; display: inline-table; width: 400px;"> -->
			<div style="display: inline-table; width: 400px;">
				<label>표지 첨부</label> &nbsp;
				<label>
				<input id="cfile" name="cfile" type="file" accept=".gif, .jpeg, .jpg, .png" onchange="" />찾기</label>
				<br>
				<label>제목</label> &nbsp;
				<br>
				<label>파일 첨부</label> &nbsp;
				<label>
				<input id="pfile" name="pfile" type="file" accept=".pdf" onchange="" />찾기</label>
			</div>
		</div>
		<br>
		<div>
			<label>책 소개 내용</label><br>
			<textarea rows="" cols=""></textarea>
		</div>
		<br>
		<div>
			<label>목차</label><br>
			<textarea rows="" cols=""></textarea>
		</div>
		<input type="submit" value="올리기">
	</div>
</div>