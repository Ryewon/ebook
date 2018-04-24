package dao;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import member.Member;

public class MemberDao {
	private JdbcTemplate jdbcTemplate;
	
	public MemberDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public int checkEmail() {
		
		return 0;
	}
	
	public void memberJoin(String email, String pw, String name, int gender, int phone, String hint, String answer) {
		System.out.println("Äõ¸®");
		jdbcTemplate.update("insert into member values(?, ?, ?, ?, ?, ?, ?, 0)",
				email, pw, name, gender, phone, hint, answer);
	}
}
