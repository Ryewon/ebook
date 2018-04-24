package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	
	@RequestMapping(value = "/ckEmail")
	public String chEmail() {
		return "";
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoin(HttpServletRequest request) {
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		int gender = Integer.parseInt(request.getParameter("gender"));
		int phone = Integer.parseInt(request.getParameter("phone"));
		String hint = request.getParameter("hint");
		String answer = request.getParameter("answer");

		memberDao.memberJoin(email, pw, name, gender, phone, hint, answer);

		return "";
	}
	
	//@RequestMapping(value = "/joinInfo")
	
}