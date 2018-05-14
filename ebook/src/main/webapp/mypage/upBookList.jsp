<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="test">
	<h2>내가 올린 책 목록</h2>
	<c:choose>
		<c:when test="${empty upbook}">
			<p>작성하신 책이 없습니다.</p>
		</c:when>
		<c:otherwise>
			<table>
				<tbody>
					<c:forEach var="ulist"  items="${upbook }">
						<tr style="border-bottom: 1px solid #8C8C8C;">
							<td>
								<c:choose>
									<c:when test="${!empty blist.cover_path }">
										<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/cuploads/${ulist.bid }_${ulist.cover_name}"/></th>
									</c:when>
									<c:otherwise>
										<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/no_image.png"/></th>
									</c:otherwise>
								</c:choose>
							</td>
							<td style="width: 200px;">
								<input type="hidden" id="bookId" name="bookId" value="${ulist.bid }" />
								<label>카테고리: </label> ${ulist.book_cate } <br>
								<label>제목: </label> ${ulist.book_title1 } <br>
								<label>작가: </label> ${ulist.book_writer1 } <br>
								<label>작성일: </label> ${ulist.book_date } <br>
								<label>판매량: </label> ${ulist.book_vol } <br>
							</td>
							<td style="width: 100px;">
								<label>가격: ${ulist.price }</label>
							</td>
							<td>
								<button>상세보기</button> <br><br>
								<button onclick="window.open('./viewer.jsp?pfile=${ulist.bid }_${ulist.pfile_name }')">읽기</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>
</div>