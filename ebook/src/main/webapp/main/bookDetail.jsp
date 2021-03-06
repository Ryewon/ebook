<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 String strReferer = request.getHeader("referer");
 
 if(strReferer == null){
%>
 <script language="javascript">
  alert("비정상적인 방법으로 접근하셨습니다.");
  document.location.href="/home";
 </script>
<%
  return;
 }
%>
<head>
	<title>RWeBook</title>
</head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/navbar.css?ver=1115" />

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
						$("#pointCon").hide();
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
									url : "/buyBook",
									data : "mid=" + mid + "&bid=" + bid + "&cpoint=" + cpoint + "&ppoint=" + ppoint + "&apoint=" + apoint,
									success : function() {
										$("#buyTitle").html("알림");
										$("#buyCon").html("구매되었습니다.");
										$("#closeBtn").hide();
										$("#pointCon").hide();
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
			$("#buyBtn").hide();
			$("#reloadBtn").hide();
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

<div style="top: 102px; position: fixed;">
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
<div style="top:150px; width: 100%; height: 100%; position: fixed; background-color: #F6F6F6;">
	<div style="margin:auto; width: 1000px; height: 100%; background-color: white;">
		<div>
			<br>
			<h2 style="margin: 0 200px;">책 상세보기</h2><br><br>
			<table style="margin: auto;	">
				<tbody>
					<tr>
						<c:choose>
							<c:when test="${!empty bookInfo.cover_name }">							
								<th style="width: 120px;">
									<img style="width: 150px; height: 150px; margin: 10px;" src="/ebook/cuploads/${bookInfo.bid }_coverFile" />
								</th>							
							</c:when>
							<c:otherwise>							
								<th style="width: 120px;">
									<img style="width: 150px; height: 150px; margin: 10px;" src="/ebook/no_image.png" />
								</th>							
							</c:otherwise>
						</c:choose>				
						<td style="width: 200px;">
							<input type="hidden" id="bookId" name="bookId" value="${bookInfo.bid }" /> 
							<label>카테고리: </label>${bookInfo.book_cate } <br> 
							<label>제목: </label> ${bookInfo.book_title1 } <br> 
							<label>작가: </label> ${bookInfo.book_writer1 } <br> 
							<label>작성일: </label> ${bookInfo.book_date } <br> 
							<label>판매량: </label> ${bookInfo.book_vol } 권<br>
							<label>가격: </label> ${bookInfo.price } 원
						</td>
						<td>
							<c:if test="${authInfo.mid != bookInfo.mid }">
								<button class="buyBtn" onclick="buyCheck('${bookInfo.bid}','${bookInfo.price}');">구매</button>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div style="width:600px; margin: 20px auto;">
			<h4>책 소개</h4>
			<div style="border: 1.5px solid; border-color: black; width: 600px; height: 200px; overflow:auto; padding: 15px;">
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
		<div style="width:600px; margin: 20px auto;">
			<h4>목차</h4>
			<div style="border: 1.5px solid; border-color: black; width: 600px; height: 200px; overflow:auto; padding: 15px;">
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
</div>
