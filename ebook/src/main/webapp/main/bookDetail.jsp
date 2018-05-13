<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
	<title>RWeBook</title>
</head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/navbar.css?ver=115" />

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
			$("#buyTitle").html("알림");
			$("#buyCon").html("로그인 후 구매해주세요.");
			$("#closeBtn").html("확인");
			$("#pointCon").hide();
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

<%@ include file="../include/header.jsp" %>
<div style="top: 95px; position: fixed;">
<%@ include file="./navbar.jsp" %>

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

<!-- 상세 내역 -->
<input type="hidden" id="curMid" name="curMid" value="${authInfo.mid }" />
<div style="padding: 20px 23%">
	<div style="width: 600px; padding-left: 100px;">
		<table>
			<tbody>
				<tr>
					<c:choose>
						<c:when test="${!empty bookInfo.cover_name }">							
							<th style="width: 120px;">
								<img style="width: 100px; height: 100px;" src="/ebook/cuploads/${bookInfo.bid }_${bookInfo.cover_name}" />
							</th>							
						</c:when>
						<c:otherwise>							
							<th style="width: 120px;">
								<img style="width: 100px; height: 100px;" src="/ebook/no_image.png" />
							</th>							
						</c:otherwise>
					</c:choose>				
					<td style="width: 200px;">
						<input type="hidden" id="bookId" name="bookId" value="${bookInfo.bid }" /> 
						<label>카테고리: </label>${bookInfo.book_cate } <br> 
						<label>제목: </label> ${bookInfo.title } <br> 
						<label>작가: </label> ${bookInfo.book_writer } <br> 
						<label>작성일: </label> ${bookInfo.book_date } <br> 
						<label>판매량: </label> ${bookInfo.book_vol } 권<br>
						<label>가격: </label> ${bookInfo.price } 원
					</td>
					<td>
						<c:if test="${authInfo.mid != bookInfo.mid }">
							<button onclick="buyCheck('${bookInfo.bid}','${bookInfo.price}');">구매</button>
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div>
		<h4>책 소개</h4>
		<div style="border: solid; border-color: black; width: 600px; height: auto;">
			<c:choose>
				<c:when test="${!empty bookInfo.book_intro }">						
					${bookInfo.book_intro }
				</c:when>
				<c:otherwise>
					책 소개 내용이 없습니다.
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div>
		<h4>목차</h4>
		<div style="border: solid; border-color: black; width: 600px; height: auto;">
			<c:choose>
				<c:when test="${!empty bookInfo.contents_table }">						
					${bookInfo.contents_table }
				</c:when>
				<c:otherwise>
					목차가 없습니다.
				</c:otherwise>
			</c:choose>			
		</div>
	</div>
</div>
</div>