package controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
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
	public String upladBook(HttpServletRequest request, @RequestParam("cfile") MultipartFile cfile, @RequestParam("pfile") MultipartFile pfile) {
		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
		String mid = authInfo.getMid();
		System.out.println("써치전");
		int bid = bookDao.suchBid();
		System.out.println("써치후"+bid);
		String writer = authInfo.getName();
		String cate = request.getParameter("cate");
		String free = request.getParameter("free");
		int price = Integer.parseInt(request.getParameter("price"));
		String title = request.getParameter("title");
		String intro = request.getParameter("intro");
		String con_table = request.getParameter("con_table");
		String cpath = request.getParameter("cupdir") + cfile;;
		String ppath = request.getParameter("pupdir") + pfile;
		String ipath = request.getParameter("iupdir")+ bid +"/"+title+"/";
		int pCnt=0;
		
		PDDocument doc = null;
		
		try {
			doc = PDDocument.load(new File(pfile.getOriginalFilename()));
			List<PDPage> list = doc.getDocumentCatalog().getAllPages();
			pCnt = list.size();
			for (PDPage page : list) {
				for(int i = 1; i <= pCnt; i++) {
					BufferedImage image = page.convertToImage();
					ImageIO.write(image, "png", new File(ipath + title + i +".png"));
				}
			}
			doc.close();
		} catch (IOException e) {
			System.out.println("mutlpartFile to File 변환 예외발생");
		}
		BookCommand bcmd = new BookCommand(price, pCnt, mid, title, writer, cate, con_table, intro, cpath, ppath, ipath, cfile, pfile);
		bookDao.upBook(bcmd,bid);
		
		return "";
	}
}