<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/navbar.css?ver=22" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css?ver=122" />
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<script>	
	function buyCheck(bid, price) {
		var mid = $('#curMid').val();	
		var cpoint = null;
		var ppoint = price;
		var apoint = null;
		$("#ppoint").val(price);
		cpoint = $('#cpoint').val();
		apoint = Number(cpoint) - Number(ppoint);
		$("#apoint").val(apoint);
		if(mid!='') {
			$.ajax({
				type : "POST",
				url : "/ebook/buyCheck",
				data : "mid=" + mid + "&bid=" + bid,
				success : function(buyck) {
					console.log(buyck);
					$('#buy_modal').hide();
					if(buyck =='already') {
						$("#buyTitle").html("알림");
						$("#buyCon").html("이미 구매하신 책입니다.");
						$("#cbtn").html("확인");
						$("#reloadBtn").hide();
						$("#pointCon").hide();
						$("#buyBtn").hide();
						$('#point_con').hide();
						$('#buyalert').hide();
						$('#buy_modal').show();
					} else {
						$("#buyTitle").html("구매하기");
						$("#buyCon").html("구매하시겠습니까?");
						$("#buyCon").show();
						$("#pointCon").show();
						$("#buyBtn").show();
						$('#buyalert').hide();
						$("#cbtn").html("취소");
						$("#reloadBtn").hide();
						$('#buy_modal').show();
						$('#buyBtn').click(function(e) {		
							if(Number(cpoint)<Number(ppoint)) {
								$('#buyalert').show();
								$("#buyBtn").hide();
								$("#buyCon").hide();
								$("#cbtn").html("확인");
							} else {
								$.ajax({
									type : "POST",
									url : "/ebook/buyBook",
									data : "mid=" + mid + "&bid=" + bid + "&cpoint=" + cpoint + "&ppoint=" + ppoint + "&apoint=" + apoint,
									success : function() {
										$("#buyTitle").html("알림");
										$("#buyCon").html("구매되었습니다.");
										$("#pointCon").hide();
										$("#closeBtn").hide();
										$("#buyBtn").hide();
										$("#reloadBtn").show();
										$('#buy_modal').show();
									}			
								});
							}	
						});
					}			
				}
			});
		}  else {
			$("#buyalert").hide();
			$("#buyTitle").html("알림");
			$("#buyCon").html("로그인 후 구매해주세요.");
			$("#closeBtn").html("확인");
			$("#pointCon").hide();
			$('#reloadBtn').hide();
			$("#buyBtn").hide();
			$('#buy_modal').show();
		}
	}

	function buy_close(flag) {
        $('#buy_modal').hide();
   	}
	
	function reloadMain() {
		location.reload();
	}
</script>

<%
	int listcount = ((Integer)request.getAttribute("listcount")).intValue();
	int nowpage = ((Integer)request.getAttribute("page")).intValue();
	int maxpage = ((Integer)request.getAttribute("maxpage")).intValue();
	int startpage = ((Integer)request.getAttribute("startpage")).intValue();
	int endpage = ((Integer)request.getAttribute("endpage")).intValue();
%>

<!-- 모달 -->
<div id="buy_modal" class="modal">
	<!-- Modal content -->
	<div class="modal-content">
	    <p style="text-align: center;">
	    	<span style="font-size: 14pt;">
	    		<b><span style="font-size: 24pt;" id="buyTitle"></span></b>
	    	</span>
	    </p>
	    <p style="text-align: center; line-height: 1.5;">
			<span id="buyCon"></span><br>
			<div id="pointCon" style="text-align: center;">
				<label for="current_point" style="width: 100px;">보유 포인트 </label> &nbsp;
				<label for="pay_point" style="width: 100px;"> 결제 포인트 </label> &nbsp;
				<label for="after_point" style="width: 100px;"> 예상 포인트</label>&nbsp;&nbsp;&nbsp;<br>
				<input type="text" id="cpoint" name="cpoint" value="${authInfo.point }" readonly style="width: 80px;"/>원 -
				<input type="text" id="ppoint" name="ppoint" readonly style="width: 80px;"/>원 =
				<input type="text" id="apoint" name="apoint" readonly style="width: 80px;"/>원
			</div>
			<span id="buyalert" style="color: red;">포인트 충전 후 이용해주세요.</span>
	    </p>
	    <p><br /></p>
	    <div style="text-align: center;">
		    <span style="cursor:pointer;background-color:#DDDDDD; text-align: center;padding-bottom: 10px;padding-top: 10px; margin: 10px;" id="buyBtn">
				<span class="pop_bt" style="font-size: 13pt;" >구매</span>
		    </span>
			<span style="cursor:pointer;background-color:#DDDDDD; text-align: center;padding-bottom: 10px;padding-top: 10px; margin: 10px;" id="closeBtn" onClick="buy_close();">
				<span class="pop_bt" id="cbtn" style="font-size: 13pt;" >닫기</span>
		    </span>
		    <span style="cursor:pointer;background-color:#DDDDDD; text-align: center;padding-bottom: 10px;padding-top: 10px; margin: 10px;" id="reloadBtn" onClick="reloadMain();">
				<span class="pop_bt" style="font-size: 13pt;" >확인</span>
		    </span>
	    </div>
	</div>
 </div>

<div style="top: 102px; position: fixed;">
<%@ include file="./navbar.jsp" %>
<div id="booklistdiv" style="position: fixed; height: 100%; overflow: auto; width: 100%; margin: 50px auto; background-color: #F6F6F6;">
	<div style="width: 1000px; background-color: white; margin: 0 auto; height: 100%;">
	<div style="height: 800px; overflow: auto;">
	<input type="hidden" id="curMid" name="curMid" value="${authInfo.mid }" />
	<br>
	<c:choose>
		<c:when test="${cate eq '검색'}">
			<div style="margin: 0 auto; width: 700px;">
			<c:choose>
				<c:when test="${empty srchBook}">
					<p>일치하는 검색 결과가 없습니다.</p>
				</c:when>
				<c:otherwise>
				<div>
					<table>
						<tbody>
							<c:forEach var="srblist"  items="${srchBook }">
								<tr style="border-bottom: 1px solid #8C8C8C;">
									<td>
										<c:choose>
											<c:when test="${!empty srblist.cover_path }">
												<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/cuploads/${srblist.bid }_coverFile"/></th>
											</c:when>
											<c:otherwise>
												<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/no_image.png"/></th>
											</c:otherwise>
										</c:choose>
									</td>
									<td style="width: 300px;">
										<input type="hidden" value="${srblist.bid }" />
										<label>카테고리: </label> ${srblist.book_cate } <br>
										<label>제목: </label> ${srblist.book_title1 } <br>
										<label>작가: </label> ${srblist.book_writer1 } <br>
										<label>작성일: </label> ${srblist.book_date } <br>
										<label>판매량: </label> ${srblist.book_vol } <br>
									</td>
									<td style="width: 100px;">
										<label>가격: ${srblist.price }</label>
									</td>
									<td>
										<button class="normalBtn" onclick="location.href='/ebook/bookDetail?bid=${srblist.bid }&cate=${cate }'">상세보기</button> <br/>
										<c:if test="${authInfo.mid != srblist.mid }">
											<button class="buyBtn" onclick="buyCheck('${srblist.bid}','${srblist.price}');">구매</button>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<% if(listcount > 5) { %>
							<tr align="center" height="20">
								<td colspan=7>
									<% if(nowpage<=1){ %>
									[이전]&nbsp;
									<%} else { %>
									<a href="/ebook/searchBook?page=<%= nowpage-1 %>&cate=${cate}&selSrch=${selSrch}&conSrch=${conSrch}">[이전]</a>&nbsp;
									<%} %>
									
									<% for(int a = startpage; a <= endpage; a++) {
										if(a==nowpage){%>
										[<%=a %>]
										<%} else { %>
										<a href="/ebook/searchBook?page=<%= a %>&cate=${cate}&selSrch=${selSrch}&conSrch=${conSrch}">[<%= a %>]</a>&nbsp;
										<%} %>
									<%} %>
									
									<%if(nowpage >= maxpage) {%>
									[다음]
									<%} else { %>
									<a href="/ebook/searchBook?page=<%= nowpage+1 %>&cate=${cate}&selSrch=${selSrch}&conSrch=${conSrch}">[다음]</a>
									<%} %>
								</td>
							</tr> 
							<%} %>
						</tbody>
					</table>
					</div>
				</c:otherwise>
			</c:choose>
			</div>
		</c:when>
		<c:when test="${cate eq '전체'}">
			<div style="margin: 0 auto; width: 700px;">
			<h3><b>Best 도서</b></h3>
			<table>
				<tbody>
					<c:forEach var="bestlist"  items="${bestBook }">
						<tr style="border-bottom: 1px solid #8C8C8C;">
							<td>
								<c:choose>
									<c:when test="${!empty bestlist.cover_path }">
										<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/cuploads/${bestlist.bid }_coverFile"/></th>
									</c:when>
									<c:otherwise>
										<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/no_image.png"/></th>
									</c:otherwise>
								</c:choose>
							</td>
							<td style="width: 300px;">
								<input type="hidden" value="${bestlist.bid }" />
								<label>카테고리: </label> ${bestlist.book_cate } <br>
								<label>제목: </label> ${bestlist.book_title1 } <br>
								<label>작가: </label> ${bestlist.book_writer1 } <br>
								<label>작성일: </label> ${bestlist.book_date } <br>
								<label>판매량: </label> ${bestlist.book_vol } <br>
							</td>
							<td style="width: 100px;">
								<label>가격: ${bestlist.price }</label>
							</td>
							<td>
								<button class="normalBtn" onclick="location.href='/ebook/bookDetail?bid=${bestlist.bid }&cate=${cate }'">상세보기</button> <br/>
								<c:if test="${authInfo.mid != bestlist.mid }">
									<button class="buyBtn" onclick="buyCheck('${bestlist.bid}','${bestlist.price}');">구매</button>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
			<div style="margin: 0 auto; width: 700px;">
			<h3><b>신간 도서</b></h3>
			<table>
				<tbody>
					<c:forEach var="newlist"  items="${newBook }">
						<tr style="border-bottom: 1px solid #8C8C8C;">
							<td>
								<c:choose>
									<c:when test="${!empty newlist.cover_path }">
										<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/cuploads/${newlist.bid }_coverFile"/></th>
									</c:when>
									<c:otherwise>
										<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/no_image.png"/></th>
									</c:otherwise>
								</c:choose>
							</td>
							<td style="width: 300px;">
								<input type="hidden" value="${newlist.bid }" />
								<label>카테고리: </label> ${newlist.book_cate } <br>
								<label>제목: </label> ${newlist.book_title1 } <br>
								<label>작가: </label> ${newlist.book_writer1 } <br>
								<label>작성일: </label> ${newlist.book_date } <br>
								<label>판매량: </label> ${newlist.book_vol } <br>
							</td>
							<td style="width: 100px;">
								<label>가격: ${newlist.price }</label>
							</td>
							<td>
								<button class="normalBtn" onclick="location.href='/ebook/bookDetail?bid=${newlist.bid }&cate=${cate }'">상세보기</button> <br/>
								<c:if test="${authInfo.mid != newlist.mid }">
									<button class="buyBtn" onclick="buyCheck('${newlist.bid}','${newlist.price}');">구매</button>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
		</c:when>
		<c:otherwise>
			<div style="margin: 0 auto; width: 700px;">
			<c:choose>
				<c:when test="${empty book && empty sorting}">
					<p>해당 카테고리의 책 목록을 준비 중에 있습니다.</p>
				</c:when>
				<c:otherwise>
					<div style="float: left;">
						|<a href="/ebook/searchBook?price=전체&cate=${cate }&sorting=y">전체</a>|<a href="/ebook/searchBook?price=유료&cate=${cate }&sorting=y">유료</a>|<a href="/searchBook?price=무료&cate=${cate }&sorting=y">무료</a>|
					</div>
					<div style="float: right;">
						/<a href="/ebook/searchBook?sortType=최신순&cate=${cate }&sorting=y">최신순</a>/<a href="/ebook/searchBook?sortType=인기순&cate=${cate }&sorting=y">인기순</a>/<a href="/searchBook?sortType=가나다순&cate=${cate }&sorting=y">가나다순</a>/
					</div> <br>
					<div style="margin-top: 30px;">
					<table>
						<tbody>
							<c:choose>
								<c:when test="${empty book }">
									해당하는 책이 존재하지 않습니다.
								</c:when>
								<c:otherwise>
									<c:forEach var="blist"  items="${book }">
										<tr style="border-bottom: 1px solid #8C8C8C;">
											<td>
												<c:choose>
													<c:when test="${!empty blist.cover_path }">
														<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/cuploads/${blist.bid }_coverFile"/></th>
													</c:when>
													<c:otherwise>
														<th style="width: 120px;"><img style="width: 100px; height: 100px;" src="/ebook/no_image.png"/></th>
													</c:otherwise>
												</c:choose>
											</td>
											<td style="width: 300px;">
												<input type="hidden" value="${blist.bid }" />
												<label>카테고리: </label> ${blist.book_cate } <br>
												<label>제목: </label> ${blist.book_title1 } <br>
												<label>작가: </label> ${blist.book_writer1 } <br>
												<label>작성일: </label> ${blist.book_date } <br>
												<label>판매량: </label> ${blist.book_vol } <br>
											</td>
											<td style="width: 100px;">
												<label>가격: ${blist.price }</label>
											</td>
											<td>
												<button class="normalBtn" onclick="location.href='/ebook/bookDetail?bid=${blist.bid }&cate=${cate }'">상세보기</button> <br/>
												<c:if test="${authInfo.mid != blist.mid }">
													<button class="buyBtn" onclick="buyCheck('${blist.bid}','${blist.price}');">구매</button>
												</c:if>
											</td>
										</tr>
									</c:forEach>
									<% if(listcount > 5) { %>
									<tr align="center" height="20">
										<td colspan=7>
											<% if(nowpage<=1){ %>
											[이전]&nbsp;
											<%} else { %>
											<a href="/ebook/searchBook?page=<%= nowpage-1 %>&cate=${cate}&price=${price}&sortType=${sortType}&sorting=y">[이전]</a>&nbsp;
											<%} %>
											
											<% for(int a = startpage; a <= endpage; a++) {
												if(a==nowpage){%>
												[<%=a %>]
												<%} else { %>
												<a href="/ebook/searchBook?page=<%= a %>&cate=${cate}&price=${price}&sortType=${sortType}&sorting=y">[<%= a %>]</a>&nbsp;
												<%} %>
											<%} %>
											
											<%if(nowpage >= maxpage) {%>
											[다음]
											<%} else { %>
											<a href="/ebook/searchBook?page=<%= nowpage+1 %>&cate=${cate}&price=${price}&sortType=${sortType}&sorting=y">[다음]</a>
											<%} %>
										</td>
									</tr> 
									<%} %>
								</c:otherwise>
							</c:choose>
							
						</tbody>
					</table>
					</div>
				</c:otherwise>
			</c:choose>
			</div>
		</c:otherwise>		
	</c:choose>
	</div>
	</div>
</div>
</div>