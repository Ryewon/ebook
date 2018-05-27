package controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import book.Book;
import book.BookCommand;
import dao.BookDao;
import dao.MypageDao;
import member.AuthInfo;

@Controller
public class MypageController {
	MypageDao mypageDao;
	BookDao bookDao;
	
	public void setMypageDao(MypageDao mypageDao) {
		this.mypageDao = mypageDao;
	}
	
	public void setBookDao(BookDao bookDao) {
		this.bookDao = bookDao;
	}

	@RequestMapping(value = "/mypage")
	public String upBook(HttpServletRequest request, Model model) {
		int page = 1;
		int limit = 5;
		int listcount = 0;
		int maxpage = 0;
		int startpage = 0;
		int endpage = 0;
		
		String spot = request.getParameter("spot");
		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
		String mid = authInfo.getMid();
		
		if(spot.equals("infoPw")) {
			String changeInfo = request.getParameter("changeInfo");
			String changePw = request.getParameter("changePw");
			model.addAttribute("changeInfo", changeInfo);
			model.addAttribute("changePw", changePw);
			model.addAttribute("spot", "infoPw");
		} else {
			String delId = request.getParameter("delId");
			System.out.println("delId: "+ delId);
			
			if (request.getParameter("page") != null) {
				System.out.println(request.getParameter("page"));
				page = Integer.parseInt(request.getParameter("page"));
			}
			
			if(spot.equals("upBookList")) {
				if(delId!=null) {
					System.out.println("여기는 내가 올린책 지우기 전");
					int bid = Integer.parseInt(delId);
					mypageDao.DelupBook(mid, bid);
				}
				listcount = mypageDao.myUpBookCnt(mid);
				List<BookCommand> upbook = mypageDao.myUpBook(mid, page, limit);
				model.addAttribute("upbook", upbook);			
			} else {
				if(delId!=null) {
					System.out.println("여기는 내가 산 책 지우기 전");
					int pur_id = Integer.parseInt(delId);
					mypageDao.DelbuyBook(mid, pur_id);
				}
				listcount = mypageDao.myPurBookCnt(mid);
				List<BookCommand> purbook = mypageDao.myPurBook(mid, page, limit);
				model.addAttribute("purbook", purbook);
			}
			maxpage = (int) ((double) listcount / limit + 0.95);
			startpage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
			endpage = maxpage;

			if (endpage > maxpage) {
				endpage = maxpage;
			}

			model.addAttribute("spot", spot);
		}
		request.setAttribute("page", page);
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("listcount", listcount);
		
		return "mypage/mypage";
	}
	
	@RequestMapping(value = "/infoModify")
	public String infoModify(HttpServletRequest request, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		System.out.println("info 컨트롤러");
		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
		String mid = authInfo.getMid();
		String orginPw = authInfo.getPw();
		String inputPw = request.getParameter("pw");
		String name1 = request.getParameter("name");
		String name2 = request.getParameter("name").replaceAll(" ", "");
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		String hint = request.getParameter("hint2").trim();
		String answer = request.getParameter("answer").trim();
		System.out.println("or:" + orginPw);
		System.out.println("in:" + inputPw);
		model.addAttribute("spot","infoPw");
		if(orginPw.equals(inputPw)) {
			System.out.println("쿼리날린다~");
			mypageDao.updateInfo(name1, name2, gender, phone, hint, answer, mid);
			authInfo.setName(name1);
			authInfo.setGender(gender);
			authInfo.setPhone(phone);
			authInfo.setHint(hint);
			authInfo.setAnswer(answer);
			session.setAttribute("authInfo", authInfo);
			System.out.println(authInfo.getName());
			redirectAttributes.addAttribute("spot", "infoPw");
			redirectAttributes.addAttribute("changeInfo", "y");
			return "redirect:mypage";
		} else {
			model.addAttribute("check", "miss");
			return "/mypage/mypage";
		}
	}
	
	@RequestMapping(value = "/passModify")
	public String passModify(HttpServletRequest request, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		System.out.println("비번바꾸는 컨트롤러");
		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
		String mid = authInfo.getMid();
		String cpw = request.getParameter("cur_pw");
		String npw = request.getParameter("new_pw1");
		String pw = mypageDao.getPasswrod(mid);
		System.out.println("현재비번: " + pw);
		model.addAttribute("spot","infoPw");
		if(pw.equals(cpw)) {
			System.out.println("바꿀 쿼리 실행할거임");
			mypageDao.updatePw(mid, npw);
			authInfo.setPw(npw);
			session.setAttribute("authInfo", authInfo);
//			model.addAttribute("changePw", "y");
//			return "redirect:/mypage/{changePw}";
			redirectAttributes.addAttribute("spot", "infoPw");
			redirectAttributes.addAttribute("changePw", "y");
			return "redirect:mypage";
		} else {			
			model.addAttribute("spot","infoPw");
			model.addAttribute("changePw", "n");
			return "/mypage/mypage";
		}
	}
	
/*	//패스워드 변경 성공시 확인 값 던져줌
	@RequestMapping(value = "/mypage/pass") 
	public String pass(@RequestParam(value="changePw") String changePw, Model model) {
		model.addAttribute("changePw", changePw);
		model.addAttribute("spot","infoPw");
		return "/mypage/mypage";
	}*/
	
	//책 수정 페이지로 이동
	@RequestMapping(value = "/modifyBook")
	public String modifyBook(HttpServletRequest request, Model model) {
		int bid = Integer.parseInt(request.getParameter("bid"));
		Book book = bookDao.bookInfo(bid);
		String intro = book.getBook_intro();
		String contable = book.getContents_table();
		System.out.println("intro:" + intro);
		System.out.println("contable:" + contable);
		if(intro!=null ) {			
			intro=book.getBook_intro().replaceAll("<br>", "\r\n");
			book.setBook_intro(intro);
		}
		if(contable!=null) {
			contable = book.getContents_table().replaceAll("<br>", "\r\n");	
			book.setContents_table(contable);
		}
		model.addAttribute("book", book);
		
		return "/mypage/modifyBook";
	}
	
	@RequestMapping(value = "/modifyUpBook")
	public String modifyUpBook(HttpServletRequest request, @RequestParam("file") List<MultipartFile> file, Model model) throws Exception {
		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
		String mid = authInfo.getMid();
		int bid = Integer.parseInt(request.getParameter("bid"));
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
		String intro = request.getParameter("intro").replace(" ", "");
		String con_table = request.getParameter("con_table").replace(" ", "");
		
		//책소개 공백 처리
		if(intro.length()==0) {
			intro=null;
		} else {
			intro = request.getParameter("intro").replace("\r\n", "<br>");
		}
		
		//목차 공백 처리
		if(con_table.length()==0) {
			con_table=null;
		} else {
			con_table = request.getParameter("con_table").replace("\r\n", "<br>");
		}
		System.out.println("cfile에 넣기");
		
		String orgCoverName = request.getParameter("OrgCoverName");
		String orgPfileName = request.getParameter("OrgPfileName");
		String coverName = request.getParameter("coverName");
		String pfileName = request.getParameter("pfileName");
		
		String cfile = null;
		String cpath = null;
		String pfile = null;
		String ppath = null;
		
		if(coverName.equals("")) { //표지 없앴을 때
			if(orgPfileName.equals(pfileName)) { //pdf파일 그대로일 때
				mypageDao.modifyCoverBook(title1, title2, cate, price, con_table, intro, cfile, cpath, bid);
			} else { //pdf파일 바꼈을 때
				pfile = file.get(1).getOriginalFilename();
				ppath = request.getParameter("pupdir") + bid + "_pdfFile";
				try {
					File pdf_file = new File(ppath);
					file.get(1).transferTo(pdf_file);
				} catch (IOException e) {
					System.out.println("File 변환 예외발생");
				}
				//표지, pdf 모두 바꾸는 쿼리
				mypageDao.modifyCoverPdfBook(title1, title2, cate, price, con_table, intro, cfile, cpath, pfile, ppath, mid, bid);
			}
		} else { // 표지 있을 때
			if(orgCoverName.equals(coverName)) { //표지 그대로일 때
				if(orgPfileName.equals(pfileName)) { //pdf파일 그대로일 때
					mypageDao.modifyBook(title1, title2, cate, price, con_table, intro, bid);
				} else { //pdf파일 바꼈을 때
					pfile = file.get(1).getOriginalFilename();
					ppath = request.getParameter("pupdir") + bid + "_pdfFile";
					try {
						File pdf_file = new File(ppath);
						file.get(1).transferTo(pdf_file);
					} catch (IOException e) {
						System.out.println("File 변환 예외발생");
					}
					
					//pdf 파일 바꾸는 쿼리
					mypageDao.modifyPdfBook(title1, title2, cate, price, con_table, intro, pfile, ppath, mid, bid);
				}
			} else { //표지 바꼈을 때
				if(orgPfileName.equals(pfileName)) { //pdf파일 그대로일 때
					cfile = file.get(0).getOriginalFilename();
					cpath = request.getParameter("cupdir") + bid + "_coverFile";
					try {
						File cover_file = new File(cpath);
						file.get(0).transferTo(cover_file);				
					} catch (IOException e) {
						System.out.println("File 변환 예외발생");
					}
					//표지 바꾸는 쿼리
					mypageDao.modifyCoverBook(title1, title2, cate, price, con_table, intro, cfile, cpath, bid);
				} else { //pdf파일 바꿨을 때
					cfile = file.get(0).getOriginalFilename();
					cpath = request.getParameter("cupdir") + bid + "_coverFile";
					pfile = file.get(1).getOriginalFilename();
					ppath = request.getParameter("pupdir") + bid + "_pdfFile";
					try {
						File cover_file = new File(cpath);
						file.get(0).transferTo(cover_file);
						
						File pdf_file = new File(ppath);
						file.get(1).transferTo(pdf_file);
					} catch (IOException e) {
						System.out.println("File 변환 예외발생");
					}
					//표지, pdf 바꾸는 쿼리
					mypageDao.modifyCoverPdfBook(title1, title2, cate, price, con_table, intro, cfile, cpath, pfile, ppath, mid, bid);
				}
			}
		}
//		int page = 1;
//		int limit = 5;
//		int listcount = 0;
//		int maxpage = 0;
//		int startpage = 0;
//		int endpage = 0;
//		
//		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
//		String mid = authInfo.getMid();
//		
//		listcount = mypageDao.myUpBookCnt(mid);
//		List<Book> upbook = mypageDao.myUpBook(mid, page, limit);
//		model.addAttribute("upbook", upbook);		
//		
//		maxpage = (int) ((double) listcount / limit + 0.95);
//		startpage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
//		endpage = maxpage;
//
//		if (endpage > maxpage) {
//			endpage = maxpage;
//		}
//		
//		request.setAttribute("page", page);
//		request.setAttribute("maxpage", maxpage);
//		request.setAttribute("startpage", startpage);
//		request.setAttribute("endpage", endpage);
//		request.setAttribute("listcount", listcount);
		
		model.addAttribute("spot", "upBookList");
		
		return "redirect:/mypage";
	}
	
	@RequestMapping("/bookmark")
	public void bookMark(String mid, String bid, String lastpage) {
		int bookId = Integer.parseInt(bid);
		int lpage = Integer.parseInt(lastpage);
		mypageDao.addBookMark(mid, bookId, lpage);
	}
}
