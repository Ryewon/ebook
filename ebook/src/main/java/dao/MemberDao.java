package dao;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import member.Member;

public class MemberDao {
	private JdbcTemplate jdbcTemplate;
	
	public MemberDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public void memberJoin(final Member member) {
//		jdbcTemplate.update("insert into member values(mid_seq.nextval, ?, ?, ?, null, null, 0, sysdate)",
//				member.getMemail(), member.getMname(), member.getMpw());
	}
}
