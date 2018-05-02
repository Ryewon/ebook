package dao;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import book.BookCommand;

public class BookDao {
	private JdbcTemplate jdbcTemplate;
	
	public BookDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public void upBook(int bid, String title, String writer, String cate, int price, String con_table, 
		String intro, String cfile, String cpath, String pfile, int pCnt, String ppath, String ipath, String mid) {
		jdbcTemplate.update("insert into book values(?, ?, sysdate, ?, ?, ?, ?, ?, 0, ?, ?, ?, ?, ?, ?, ?)", 
				bid + 1, title, writer, cate,
						price, con_table, intro,
						cfile, cpath, pfile, pCnt,
						ppath, ipath, mid);
	}

	public int suchBid() {
		int bid = jdbcTemplate.queryForObject("select nvl(max(bid), 0) from book", Integer.class);
		return bid;
	}
	
}
