package dao;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import book.BookCommand;

public class BookDao {
	private JdbcTemplate jdbcTemplate;
	
	public BookDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public void upBook(final BookCommand bcmd, int bid) {
		jdbcTemplate.update("insert into book values(?, ?, sysdate, ?, ?, ?, ?, ?, 0, ?, ?, ?, ?, ?)", 
				bid + 1, bcmd.getTitle(), bcmd.getBook_writer(), bcmd.getBook_cate(),
						bcmd.getPrice(), bcmd.getContents_table(), bcmd.getBook_intro(),
						bcmd.getCover_name(), bcmd.getCover_path(), bcmd.getPfile_name(),
						bcmd.getPimg_path(), bcmd.getMid());
	}

	public int suchBid() {
		int bid = jdbcTemplate.queryForObject("select nvl(max(bid), 0) from book", Integer.class);
		return bid;
	}
	
}
