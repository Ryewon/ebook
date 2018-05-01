package controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.imageio.ImageWriter;
import javax.servlet.http.HttpServletRequest;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.util.PDFImageWriter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import book.Book;
import book.BookCommand;
import dao.BookDao;
import member.AuthInfo;

@Controller
public class BookController {
	BookDao bookDao;

	public void setBookDao(BookDao bookDao) {
		this.bookDao = bookDao;
	}
	
	@RequestMapping(value = "/upbook")
	public String upBook() {
		return "/main/upBook";
	}
	
	@RequestMapping(value = "/uploadBook", method = RequestMethod.POST)
	public String upladBook(HttpServletRequest request, @RequestParam("file") List<MultipartFile> file) {
		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
		String mid = authInfo.getMid();
		int bid = bookDao.suchBid();
		System.out.println("써치후"+bid);
		String writer = authInfo.getName();
		String cate = request.getParameter("cate");
		String free = request.getParameter("free");
		int price = Integer.parseInt(request.getParameter("price"));
		String title = request.getParameter("title");
		String intro = request.getParameter("intro");
		String con_table = request.getParameter("con_table");
		String cfile = file.get(0).getOriginalFilename();
		String pfile = file.get(1).getOriginalFilename();
		String cpath = request.getParameter("cupdir") + bid + "_" +cfile;
		String ppath = request.getParameter("pupdir") + bid + "_" +pfile;
		String ipath = request.getParameter("iupdir")+ bid +"_";
		
		int pCnt=0;
		PDDocument doc = null;
		
		try {
			File cover_file = new File(cpath);
			file.get(0).transferTo(cover_file);
			File pdf_file = new File(ppath);
			file.get(1).transferTo(pdf_file);
			doc = PDDocument.load(pdf_file);
			
//			pdf -> png 로 변환하는 다른 코드
/*			pCnt = doc.getNumberOfPages();
			PDFImageWriter imgWriter = new PDFImageWriter();
			imgWriter.writeImage(doc, "png", "", 1, pCnt, ipath, BufferedImage.TYPE_INT_RGB, 300);
*/			
			List<PDPage> list = doc.getDocumentCatalog().getAllPages();
			pCnt = list.size();
			for (int i = 1; i <= pCnt; i++) {				
					BufferedImage image = list.get(i-1).convertToImage();
					ImageIO.write(image, "png", new File(ipath + i + ".png"));
			}
			doc.close();
		} catch (IOException e) {
			System.out.println("File 변환 예외발생");
		}
		bookDao.upBook(bid, title, writer, cate, price, con_table, intro, cfile, cpath, pfile, ppath, ipath, mid);
		
		return "";
	}

}