package dao;

import java.awt.List;

import javax.sql.DataSource;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import member.Member;

public class MemberDao {
	private JdbcTemplate jdbcTemplate;

	public MemberDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public int checkID(String mid) {
		String ck = null;
		try {
			ck = jdbcTemplate.queryForObject("select mid from member where mid=?", String.class, mid);
			return 0;
		} catch (Exception e) {
			return 1;
		}
	}

	public void memberJoin(String mid, String pw, String name, int gender, int phone, String hint, String answer) {
		jdbcTemplate.update("insert into member values(?, ?, ?, ?, ?, ?, ?, 0)", mid, pw, name, gender, phone, hint,
				answer);
	}
	
	public String checkLogin(String mid, String pw) {
			System.out.println("�ٿ���");
			String result = null;
			try {
				System.out.println("����������");
				result = jdbcTemplate.queryForObject("select mid from member where mid=? and pw=?", String.class, mid, pw);
				System.out.println("���� ����������");
				return result;
			} catch (Exception e) {
				return "no";
			}
	}
}
