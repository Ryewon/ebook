package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MypageController {

	@RequestMapping(value = "/mypage")
	public String upBook() {
		return "/mypage/mypage";
	}
	
/*	@RequestMapping(value = "/infoPw") 
	public String infoPw() {
	
		return "mypage/infoPw";
	}*/
}
