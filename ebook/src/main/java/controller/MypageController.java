package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import book.Book;
import dao.MypageDao;
import member.AuthInfo;

@Controller
public class MypageController {
	MypageDao mypageDao;

	public void setMypageDao(MypageDao mypageDao) {
		this.mypageDao = mypageDao;
	}

	@RequestMapping(value = "/mypage")
	public String upBook(HttpServletRequest request, Model model) {
		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
		String mid = authInfo.getMid();
		List<Book> book = mypageDao.myUpBook(mid);
		model.addAttribute("book", book);
		return "/mypage/mypage";
	}
	
	@RequestMapping(value = "/infoModify")
	public String infoModify(HttpServletRequest request, HttpSession session) {
		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
		String orginPw = authInfo.getPw();
		String inputPw = request.getParameter("pw");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		String hint = request.getParameter("hint2");
		String answer = request.getParameter("answer");
		if(orginPw == inputPw) {
			System.out.println("쿼리날린다~");
			mypageDao.updateInfo(name, gender, phone, hint, answer);
			session.setAttribute("name", name);
			session.setAttribute("gender", gender);
			session.setAttribute("phone", phone);
			session.setAttribute("hint", hint);
			session.setAttribute("answer", answer);
			return "redirect:/mypage/infoPw";
		} else {
			return "/mypage/infoPw";
		}
	}
	
/*	@RequestMapping(value = "/infoPw") 
	public String infoPw() {
	
		return "mypage/infoPw";
	}*/
}
