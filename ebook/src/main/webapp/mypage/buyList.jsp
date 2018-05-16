<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="test">
	<h2>구매목록</h2>
	<c:choose>
		<c:when test="${empty purbook}">
			<p>구매하신 책이 없습니다.</p>
		</c:when>
		<c:otherwise>
			<table>
				<tbody>
					<c:forEach var="plist" items="${purbook }">
						<tr>
							<th style="width: 200px;">구매일: ${plist.buy_date }</th>
						</tr>
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
								<label>제목: </label> ${plist.book_title1 } <br> 
								<label>작가: </label> ${plist.book_writer1 } <br> 
								<label>작성일: </label> ${plist.book_date } <br> 
								<label>판매량: </label> ${plist.book_vol } <br>
							</td>
							<td style="width: 100px;">
								<label>가격: ${plist.price }</label>
							</td>
							<td>
								<button style="margin-bottom: 3px;" onclick="location.href='/ebook/bookDetail?bid=${plist.bid }'">상세보기</button><br>
								<button style="margin-bottom: 3px;" onclick="location.href='./viewer.jsp?pfile=${plist.bid}_${plist.pfile_name }'">읽기</button><br>
								<button style="margin-bottom: 3px;">삭제</button><br>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>
</div>