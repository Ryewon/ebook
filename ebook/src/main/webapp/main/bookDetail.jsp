<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
	<title>RWeBook</title>
</head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/navbar.css?ver=115" />

<%@ include file="../include/header.jsp" %>
<div style="top: 95px; position: fixed;">
<%@ include file="./navbar.jsp" %>

<div>
	<div>
		<table>
			<tbody>
				<tr style="border-bottom: 1px solid #8C8C8C;">
					<c:choose>
						<c:when test="${!empty plist.cover_name }">
							<td>
								<th style="width: 120px;">
									<img style="width: 100px; height: 100px;" src="/ebook/cuploads/${plist.bid }_${plist.cover_name}" />
								</th>
							</td>
						</c:when>
						<c:otherwise>
							<td>
								<th style="width: 120px;">
									<img style="width: 100px; height: 100px;" src="/ebook/no_image.png" />
								</th>
							</td>
						</c:otherwise>
					</c:choose>				
					<td style="width: 200px;"><input type="hidden" id="bookId" name="bookId" value="${plist.bid }" /> 
						<label>카테고리: </label>${plist.book_cate } <br> 
						<label>제목: </label> ${plist.title } <br> 
						<label>작가: </label> ${plist.book_writer } <br> 
						<label>작성일: </label> ${plist.book_date } <br> 
						<label>판매량: </label> ${plist.book_vol } <br>
						<label>가격: ${plist.price }</label>
					</td>
					<td>
						<button onclick="">구매</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div>
		
	</div>
	<div>
		
	</div>
</div>
</div>