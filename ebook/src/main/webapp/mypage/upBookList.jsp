<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="test">
	<h2>내가 올린 책 목록</h2>
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
						<button>읽기</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>