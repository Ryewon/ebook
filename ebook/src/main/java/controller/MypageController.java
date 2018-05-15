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
		List<Book> upbook = mypageDao.myUpBook(mid);
		List<BookCommand> purbook = mypageDao.myPurBook(mid);
		model.addAttribute("upbook", upbook);
		model.addAttribute("purbook", purbook);
		return "/mypage";
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
			return "/mypage";
		}
	}
	
	@RequestMapping(value = "passModify")
	public String passModify(HttpServletRequest request, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		System.out.println("비번바꾸는 컨트롤러");
		AuthInfo authInfo = (AuthInfo) request.getSession().getAttribute("authInfo");
		String mid = authInfo.getMid();
		String cpw = request.getParameter("cur_pw");
		String npw = request.getParameter("new_pw1");
		String pw = mypageDao.getPasswrod(mid);
		System.out.println("현재비번: " + pw);
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
			return "mypage";
		}
	}
	
	//패스워드 변경 성공시 확인 값 던져줌
	@RequestMapping(value = "/mypage/pass") 
	public String pass(@RequestParam(value="changePw") String changePw, Model model) {
		model.addAttribute("changePw", changePw);
		return "mypage";
	}
/*	@RequestMapping(value = "/infoPw") 
	public String infoPw() {
	
		return "mypage/infoPw";
	}*/
}
