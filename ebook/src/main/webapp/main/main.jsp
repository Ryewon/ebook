<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/navbar.css?ver=5155" />

<div style="top: 95px; position: fixed;">
<%@ include file="./navbar.jsp" %>
<div class="container" style="position: fixed; top: 150px;">
cate = ${cate }
	<table>
		<tbody>
			<c:forEach var="blist"  items="${book }">
				<tr style="border-bottom: 1px solid #8C8C8C;">
					<td>
						<c:choose>
							<c:when test="${!empty blist.cover_path }">
								<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/cuploads/${blist.bid }_${blist.cover_name}"/></th>
							</c:when>
							<c:otherwise>
								<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/no_image.png"/></th>
							</c:otherwise>
						</c:choose>
					</td>
					<td style="width: 200px;">
						<input type="hidden" id="bookId" name="bookId" value="${blist.bid }" />
						<label>카테고리: </label> ${blist.book_cate } <br>
						<label>제목: </label> ${blist.title } <br>
						<label>작가: </label> ${blist.book_writer } <br>
						<label>작성일: </label> ${blist.book_date } <br>
						<label>판매량: </label> ${blist.book_vol } <br>
					</td>
					<td style="width: 100px;">
						<label>가격: ${blist.price }</label>
					</td>
					<td>
						<button>상세보기</button> <br><br>
						<button>구매</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</div>
</div>