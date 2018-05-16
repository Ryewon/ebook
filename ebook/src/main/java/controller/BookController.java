package controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import book.Book;
import dao.BookDao;
import member.AuthInfo;

@Controller
public class BookController {
	BookDao bookDao;
	public static String price = "전체";
	public static String sortType = "최신순";

	public void setBookDao(BookDao bookDao) {
		this.bookDao = bookDao;
	}

	@RequestMapping(value = "/upbook")
	public String upBook() {
		return "/main/upBook";
	}

	@RequestMapping(value = "/uploadBook", method = RequestMethod.POST)
	public String upladBook(HttpServletRequest request, @RequestParam("file") List<MultipartFile> file, Model model) {
		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
		String mid = authInfo.getMid();
		int bid = bookDao.suchBid();
		System.out.println("써치후" + bid);
		String writer1 = authInfo.getName();
		String writer2 = writer1.replaceAll(" ", "");
		String cate = request.getParameter("cate");
		String free = request.getParameter("free");
		String pre_price = (String) request.getParameter("price");
		System.out.println("변환전가격:  " + pre_price + "   원");
		int price = 0;
		if (pre_price.isEmpty()) {
			System.out.println("가격0");
			price = 0;
		} else {
			System.out.println("가격 변환");
			price = Integer.parseInt(pre_price);
		}
		String title1 = request.getParameter("title");
		String title2 = title1.replaceAll(" ", "");
		String intro = request.getParameter("intro").replace("\r\n", "<br>");
		String con_table = request.getParameter("con_table").replace("\r\n", "<br>");
		System.out.println("cfile에 넣기");
		String cfile = file.get(0).getOriginalFilename();
		String pfile = file.get(1).getOriginalFilename();
		String cpath = null;
		if (cfile == "") {
			System.out.println("cfile 널 처리1");
			cpath = "";
		} else {
			cpath = request.getParameter("cupdir") + bid + "_" + cfile;
		}
		String ppath = request.getParameter("pupdir") + bid + "_" + pfile;
		// String ipath = request.getParameter("iupdir")+ bid +"_";

		int pCnt = 0;
		PDDocument doc = null;

		try {
			if (cpath != "") {
				System.out.println("cfile 널 처리2");
				File cover_file = new File(cpath);
				file.get(0).transferTo(cover_file);
				System.out.println("cfile 널 처리3");
			}
			File pdf_file = new File(ppath);
			file.get(1).transferTo(pdf_file);
			doc = PDDocument.load(pdf_file);
			pCnt = doc.getPageCount();
			// pdf -> png 로 변환하는 다른 코드
			/*
			 * pCnt = doc.getNumberOfPages(); PDFImageWriter imgWriter = new
			 * PDFImageWriter(); imgWriter.writeImage(doc, "png", "", 1, pCnt, ipath,
			 * BufferedImage.TYPE_INT_RGB, 300);
			 */

			// pdf -> png 로 변환
			/*
			 * List<PDPage> list = doc.getDocumentCatalog().getAllPages(); pCnt =
			 * list.size(); for (int i = 1; i <= pCnt; i++) { BufferedImage image =
			 * list.get(i-1).convertToImage(); ImageIO.write(image, "png", new File(ipath +
			 * i + ".png")); }
			 */
			doc.close();
		} catch (IOException e) {
			System.out.println("File 변환 예외발생");
		}
		// bookDao.upBook(bid, title, writer, cate, price, con_table, intro, cfile,
		// cpath, pfile, pCnt, ppath, ipath, mid);
		bookDao.upBook(bid, title1, title2, writer1, writer2, cate, price, con_table, intro, cfile, cpath, pfile, pCnt,
				ppath, mid);
		return "redirect:./home";
	}

	@RequestMapping(value = "/searchBook")
	public String searchBook(HttpServletRequest request, Model model) {
		int page = 1;
		int limit = 5;
		int listcount = 0;
		int maxpage = 0;
		int startpage = 0;
		int endpage = 0;

		String cate = request.getParameter("cate");
		String rprice = request.getParameter("price");
		String rsortType = request.getParameter("sortType");
		String sorting = request.getParameter("sorting");
		System.out.println("sorting:" + cate);
		List<Book> book = null;
		List<Book> bestBook = null;
		List<Book> newBook = null;
		List<Book> srchBook = null;

		if (cate.equals("전체")) {
			bestBook = bookDao.cateBook1();
			newBook = bookDao.cateBook2();
			model.addAttribute("bestBook", bestBook);
			model.addAttribute("newBook", newBook);
			
		} else {
			if (request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
			}
			
			if (cate.equals("검색")) {
				String selSrch = request.getParameter("selSrch");
				String conSrch = request.getParameter("conSrch").replaceAll(" ", "");
				
				listcount = bookDao.searchBookCnt(selSrch, conSrch);
				srchBook = bookDao.searchBook(page, limit, selSrch, conSrch);	
				model.addAttribute("srchBook", srchBook);
				model.addAttribute("selSrch", selSrch);
				model.addAttribute("conSrch", conSrch);
				
			} else {
				if (rprice != null) {
					price = rprice;
				}
				if (rsortType != null) {
					sortType = rsortType;
				}

				listcount = bookDao.sortedBookCnt(cate, price, sortType);
				book = bookDao.sortedBook(page, limit, cate, price, sortType);
				
				model.addAttribute("sorting", sorting);
				model.addAttribute("book", book);
				model.addAttribute("price", rprice);
				model.addAttribute("sortType", rsortType);
			}
			
			System.out.println("listcount : " + listcount);
			maxpage = (int) ((double) listcount / limit + 0.95);
			startpage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
			endpage = maxpage;
			
			System.out.println("startpage=" + startpage + "/ endpage=" + endpage);

			if (endpage > maxpage) {
				endpage = maxpage;
			}

		}
		
		model.addAttribute("cate", cate);
		
		request.setAttribute("page", page);
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("listcount", listcount);

		return "/home";
	}

	@RequestMapping(value = "/buyCheck")
	public @ResponseBody String buyCheck(String mid, int bid) {
		String buyck = bookDao.buyCheck(mid, bid);
		return buyck;
	}

	@RequestMapping(value = "/buyBook")
	public @ResponseBody String buyBook(String mid, int bid, int cpoint, int ppoint, int apoint) {
		bookDao.buyBook(mid, bid, cpoint, ppoint, apoint);
		return "";
	}

	@RequestMapping(value = "/bookDetail")
	public String bookDetail(HttpServletRequest request, Model model) {
		int bid = Integer.parseInt(request.getParameter("bid"));
		Book book = bookDao.bookInfo(bid);
		model.addAttribute("bookInfo", book);
		return "main/bookDetail";
	}

//	@RequestMapping(value = "/searchBook")
//	public String searchBook(HttpServletRequest request, Model model) {
//		String selSrch = request.getParameter("selSrch");
//		String conSrch = request.getParameter("conSrch").replaceAll(" ", "");
//		System.out.println("써치하러 와써요");
//		System.out.print(conSrch);
//		List<Book> srchBook = bookDao.searchBook(selSrch, conSrch);
//		System.out.println("검색하고와써? 왜안와?");
//		int totalCnt = srchBook.size();
//		String cate = "검색";
//		System.out.println(cate);
//		model.addAttribute("cate", cate);
//		model.addAttribute("totalCnt", totalCnt);
//		model.addAttribute("srchBook", srchBook);
//		return "/home";
//	}

	// @RequestMapping(value = "/bookSort1")
	// public String bookSort1(HttpServletRequest request, Model model) {
	// price = request.getParameter("price");
	//
	// String cate = request.getParameter("cate");
	// String sorting = "sorting"; //소팅 결과가 널일때 main.jsp에서 sorting a 태그 남겨놓기 위함
	//
	// List<Book> book = bookDao.sortedBook(cate, price, sortType);
	// model.addAttribute("sorting", sorting);
	// model.addAttribute("cate", cate);
	// model.addAttribute("book", book);
	// return "/home";
	// }
	//
	// @RequestMapping(value = "/bookSort2")
	// public String bookSort2(HttpServletRequest request, Model model) {
	// sortType = request.getParameter("sortType");
	//
	// String cate = request.getParameter("cate");
	// String sorting = "sorting"; //소팅 결과가 널일때 main.jsp에서 sorting a 태그 남겨놓기 위함
	//
	// List<Book> book = bookDao.sortedBook(cate, price, sortType);
	// model.addAttribute("sorting", sorting);
	// model.addAttribute("cate", cate);
	// model.addAttribute("book", book);
	// return "/home";
	// }

}