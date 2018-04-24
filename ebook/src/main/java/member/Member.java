package member;

import java.util.Date;

public class Member {
	private String email;
	private String pw;
	private String name;
	private int gender;
	private int phone;
	private String hint;
	private String answer;
	private int point;
	
	public Member(String email, String pw, String name, int gender, int phone, String hint, String answer, int point) {
		super();
		this.email = email;
		this.pw = pw;
		this.name = name;
		this.gender = gender;
		this.phone = phone;
		this.hint = hint;
		this.answer = answer;
		this.point = point;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public int getPhone() {
		return phone;
	}

	public void setPhone(int phone) {
		this.phone = phone;
	}

	public String getHint() {
		return hint;
	}

	public void setHint(String hint) {
		this.hint = hint;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}
	
	
	
}
