package member;

public class Member {
	private String mid;
	private String pw;
	private String name;
	private String gender;
	private String phone;
	private String hint;
	private String answer;
	private int point;
	
	public Member(String mid, String pw, String name, String gender, String phone, String hint, String answer,
			int point) {
		super();
		this.mid = mid;
		this.pw = pw;
		this.name = name;
		this.gender = gender;
		this.phone = phone;
		this.hint = hint;
		this.answer = answer;
		this.point = point;
	}

	public Member(String mid) {
		this.mid = mid;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
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

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
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
