<%@page import="book.Book"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<%
 String strReferer = request.getHeader("referer");
 
 if(strReferer == null){
%>
 <script language="javascript">
  alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다.\n\n정상적인 경로를 통해 다시 접근해 주십시오.");
  document.location.href="/ebook/logout";
 </script>
<%
  return;
 }
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${param.title } - ${param.writer }</title>
<script src="//mozilla.github.io/pdf.js/build/pdf.js"></script>
<script src="//mozilla.github.io/pdf.js/build/pdf.worker.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	window.onload = function() {
		var pfile = document.getElementById('file_name').value;
		var url = '/ebook/puploads/'+pfile;
		//Loaded via <script> tag, create shortcut to access PDF.js exports.
		var pdfjsLib = window['pdfjs-dist/build/pdf'];
		
		//The workerSrc property shall be specified.
		pdfjsLib.GlobalWorkerOptions.workerSrc = '//mozilla.github.io/pdf.js/build/pdf.worker.js';
		
		var pdfDoc = null,
			pageNum = Number('${param.lastpage}'),
			pageRendering = false,
			pageNumPending = null,
			scale = 2.0,
			canvas = document.getElementById('the-canvas'),
			ctx = canvas.getContext('2d'),
			zoomed = false;
		
		
		$('#scalePlus').click(function () {
			scale += 0.5;
			renderPage(pageNum);
		});
		
		$('#scaleMinus').click(function () {
			scale -= 0.5;
			renderPage(pageNum);
		});
		
		/**
		* Get page info from document, resize canvas accordingly, and render page.
		* @param num Page number.
		*/
		function renderPage(num) {
			pageRendering = true;
			// Using promise to fetch the page
			pdfDoc.getPage(num).then(function(page) {
			var viewport = page.getViewport(scale);
			if (zoomed) {
				scale=pageElement.clientWidth / viewport.width;
				viewport = page.getViewport(scale);
			}
			
			canvas.height = viewport.height;
			canvas.width = viewport.width;
		
			// Render PDF page into canvas context
			var renderContext = {
			 canvasContext: ctx,
			 viewport: viewport
			};
			var renderTask = page.render(renderContext);
			
			// Wait for rendering to finish
			renderTask.promise.then(function() {
				pageRendering = false;
				if (pageNumPending !== null) {
					// New page rendering is pending
					renderPage(pageNumPending);
					pageNumPending = null;
				}
			});
		});
		
		// Update page counters
		document.getElementById('page_num').value = num;
		}
		
		/**
		* If another page rendering in progress, waits until the rendering is
		* finised. Otherwise, executes rendering immediately.
		*/
		function queueRenderPage(num) {
			$('#lastReadPage').val(num);
			if (pageRendering) {
			 	pageNumPending = num;
			} else {
			 	renderPage(num);
			}
			console.log($('#lastReadPage').val());
		}
		
		/**
		* Displays previous page.
		*/
		function onPrevPage() {
			if (pageNum <= 1) {
		 		return;
			}
			pageNum--;
			queueRenderPage(pageNum);
		}
		document.getElementById('prev').addEventListener('click', onPrevPage);
		
		/**
		* Displays next page.
		*/
		function onNextPage() {
			if (pageNum >= pdfDoc.numPages) {
				return;
			}
			pageNum++;
			queueRenderPage(pageNum);
		}
		document.getElementById('next').addEventListener('click', onNextPage);
		
		/**
		* Asynchronously downloads PDF.
		*/
		pdfjsLib.getDocument(url).then(function(pdfDoc_) {
			pdfDoc = pdfDoc_;
			document.getElementById('page_count').textContent = pdfDoc.numPages;
			
			// Initial/first page rendering
			renderPage(pageNum);
		});
		
		document.querySelector('#page_num').addEventListener('keypress', function (e) {
		    var key = e.which || e.keyCode;		  
	    	var inputPage = Number($('#page_num').val()); 
		    if(inputPage <= pdfDoc.numPages) {
			    if (key == 13) { // 13 is enter
			    	if(inputPage==0) {
			    		alert("첫 페이지로 이동합니다.");
				    	$('#page_num').val(1);
				    	pageNum=1;
				    	queueRenderPage(pageNum);
				    } else{			
				    	pageNum=inputPage;
				    	queueRenderPage(pageNum);
					}
			    }
		    } else if(inputPage > pdfDoc.numPages) {
		    	alert("마지막 페이지 보다 큰 페이지 입니다.");
		    	$('#page_num').val($('#lastReadPage').val());
		    } else {
		    	alert("원래페이지로 이동합니다.");
		    	$('#page_num').val($('#lastReadPage').val());
		    }		   
		});
		
		document.onkeydown = UpDownKey;
		function UpDownKey (e) {
			 e = e || window.event;
		    if (e.keyCode == '37') { // 13 is enter
		    	console.log("이전");
		    	onPrevPage();
		    } else if (e.keyCode == '39') { 
		    	console.log("다음");
		    	onNextPage();
		    } 
		}
	}
	
	$(window).bind("beforeunload", function (e) {
		var mid = '${param.mid }';
		var bid = Number('${param.bid }');
		var markPage = $('#lastReadPage').val(); 
		
		$.ajax({
			type: "POST",
			url: "/ebook/bookmark",
			data: "mid=" + mid + "&bid="+ bid + "&lastpage=" + markPage
		}); 
	});
	
	function onlyNumber(obj) {
		$(obj).keyup(function() {
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		})
	}
	
	function opener_reload() {
		opener.location.reload();
	}
	
	
</script>

<style>
	#the-canvas {
	  border:1px solid black;
	}
</style>

</head>
<body onunload="opener_reload()">
	<input type="hidden" id="lastReadPage" name="lastReadPage" />
	<input type="hidden" id="file_name" name="file_name" value="<%= request.getParameter("pfile") %>">
	<div style="padding-left: 400px;">
		<h1>${param.title } - ${param.writer }</h1>
	</div>
	<div style="text-align: center">
		<button class="btn btn-default" aria-label="Left Align" id="prev">
			<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		</button>
		<span>
	  		<input type="text" onkeydown="onlyNumber(this);" id="page_num" style="width: 30px; text-align: right;">&nbsp;/&nbsp;
	  		<span id="page_count"></span>
		</span>
		<button class="btn btn-default" aria-label="Left Align" id="next">
				<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		</button>
		<button id="scalePlus">확대</button>
		<button id="scaleMinus">축소</button>
	</div>
	
	<br>
	
	<div id="page" style="text-align: center">
		<canvas id="the-canvas"></canvas>
	</div>
</body>
</html>