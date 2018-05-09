<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//mozilla.github.io/pdf.js/build/pdf.js"></script>
<script src="//mozilla.github.io/pdf.js/build/pdf.worker.js"></script>
<script type="text/javascript">
	window.onload = function() {
	var url = '/ebook/puploads/9_클라우드기술동향.pdf';
	
	//Loaded via <script> tag, create shortcut to access PDF.js exports.
	var pdfjsLib = window['pdfjs-dist/build/pdf'];
	
	//The workerSrc property shall be specified.
	pdfjsLib.GlobalWorkerOptions.workerSrc = '//mozilla.github.io/pdf.js/build/pdf.worker.js';
	
	var pdfDoc = null,
	 pageNum = 1,
	 pageRendering = false,
	 pageNumPending = null,
	 scale = 1.5,
	 canvas = document.getElementById('the-canvas'),
	 ctx = canvas.getContext('2d'),
	 zoomed = false;
	
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
	document.getElementById('page_num').textContent = num;
	}
	
	/**
	* If another page rendering in progress, waits until the rendering is
	* finised. Otherwise, executes rendering immediately.
	*/
	function queueRenderPage(num) {
	if (pageRendering) {
	 pageNumPending = num;
	} else {
	 renderPage(num);
	}
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
	}
</script>

<style>
	#the-canvas {
	  border:1px solid black;
	}
</style>

</head>
<body>
	<h1>PDF.js Previous/Next example</h1>

	<div>
	  <button id="prev">Previous</button>
	  <button id="next">Next</button>
	  &nbsp; &nbsp;
	  <span>Page: <span id="page_num"></span> / <span id="page_count"></span></span>
	</div>
	
	<div id="page">
		<canvas id="the-canvas"></canvas>
	</div>
</body>
</html>