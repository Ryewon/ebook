package controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
			
		} else {
			String delId = request.getParameter("delId");
			System.out.println("delId: "+ delId);
			
			if (request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
			}
			
			if(spot.equals("upBookList")) {
				if(delId!=null) {
					System.out.println("여기는 내가 올린책 지우기 전");
					int bid = Integer.parseInt(delId);
					mypageDao.DelupBook(bid);
				}
				listcount = mypageDao.myUpBookCnt(mid);
				List<Book> upbook = mypageDao.myUpBook(mid, page, limit);
				model.addAttribute("upbook", upbook);			
			} else {
				if(delId!=null) {
					System.out.println("여기는 내가 산 책 지우기 전");
					int pur_id = Integer.parseInt(delId);
					mypageDao.DelbuyBook(pur_id);
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
		}
		
		request.setAttribute("page", page);
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("listcount", listcount);
		
		model.addAttribute("spot", spot);
		return "mypage/mypage";
	}
	
	@RequestMapping(value = "/infoModify")
	public String infoModify(HttpServletRequest request, HttpSession session, Model model) {
		System.out.println("info 컨트롤러");
		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
		String mid = authInfo.getMid();
		String orginPw = authInfo.getPw();
		String inputPw = request.getParameter("pw");
		String name1 = request.getParameter("name");
		String name2 = request.getParameter("name").replaceAll(" ", "");
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		String hint = request.getParameter("hint2");
		String answer = request.getParameter("answer");
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
			return "redirect:/mypage";
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
			redirectAttributes.addAttribute("changePw", "y");
			return "redirect:/mypage/pass";
		} else {			
			model.addAttribute("changePw", "n");
			return "/mypage/mypage";
		}
	}
	
	//패스워드 변경 성공시 확인 값 던져줌
	@RequestMapping(value = "/mypage/pass") 
	public String pass(@RequestParam(value="changePw") String changePw, Model model) {
		model.addAttribute("changePw", changePw);
		model.addAttribute("spot","infoPw");
		return "/mypage/mypage";
	}
	
	@RequestMapping(value = "/modifyBook")
	public String modifyBook(HttpServletRequest request) {
		int bid = Integer.parseInt(request.getParameter("bid"));
		Book book = bookDao.bookInfo(bid);
		return "/mypage/modifyBook";
	}
/*	@RequestMapping(value = "/infoPw") 
	public String infoPw() {
	
		return "mypage/infoPw";
	}*/
}
