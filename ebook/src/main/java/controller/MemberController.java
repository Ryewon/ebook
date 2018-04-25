package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.MemberDao;
import member.Member;
import member.MemberCommand;

/**
 * Handles requests for the application home page.
 */

@Controller
public class MemberController {
	MemberDao memberDao;
	
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	
	@RequestMapping(value = "/home")
	public String home() {
		
		return "home";
	}
	
	@RequestMapping(value = "/login")
	public String login() {
		
		return "/member/login";
	}
	
	@RequestMapping(value = "/join")
	public String join() {
		
		return "/member/join";
	}
	
	@RequestMapping(value = "/ckID")
	@ResponseBody
	public String ckID(String mid) {
		System.out.println(mid);
		int ck = memberDao.checkID(mid);
		System.out.println("zÄõ¸®´Ù³à¿È");
		return String.valueOf(ck);
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoin(HttpServletRequest request) {
		String mid = request.getParameter("mid");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		int gender = Integer.parseInt(request.getParameter("gender"));
		int phone = Integer.parseInt(request.getParameter("phone"));
		String hint = request.getParameter("hint");
		String answer = request.getParameter("answer");

		memberDao.memberJoin(mid, pw, name, gender, phone, hint, answer);

		return "redirect:/home";
	}
	
	@RequestMapping(value = "/ckLogin") 
	public String ckLogin(String mid, String pw, Model model) {
		String rs = memberDao.checkLogin(mid, pw);
		if (rs == "no") {
			model.addAttribute("mck", rs);
			return "member/login";
		} else {
			return "redirect:/home";
		}
	}
	
	//@RequestMapping(value = "/joinInfo")
	
}