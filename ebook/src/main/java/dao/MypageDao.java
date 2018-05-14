package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import book.Book;
import book.BookCommand;

public class MypageDao {
	private JdbcTemplate jdbcTemplate;

	public MypageDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public List<Book> myUpBook(String mid) {
		List<Book> book = jdbcTemplate.query("select * from book where mid = ? order by bid desc"
				, new RowMapper<Book>() {
					@Override
					public Book mapRow(ResultSet rs, int rownum) throws SQLException {
						Book mbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getString("book_title2"), rs.getDate("book_date")
								, rs.getString("book_writer1"), rs.getString("book_writer2")
								, rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
								, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
								, rs.getString("pfile_name"), rs.getInt("pfile_page"), rs.getString("pfile_path")
								, rs.getString("mid"));
						return mbook;
					}
				}, mid);
		
		return book.isEmpty()?null:book;
	}
	
	public void updateInfo(String name, String gender, String phone, String hint, String answer, String mid) {
		jdbcTemplate.update("update member set name=?, gender=?, phone=?, hint=?, answer=? where mid = ?"
				, name, gender, phone, hint, answer, mid);
		jdbcTemplate.update("update book set book_writer=? where mid = ?"
				, name, mid);
	}
	
	public String getPasswrod(String mid) {
		String pw = jdbcTemplate.queryForObject("select pw from member where mid=?", String.class, mid);
		return pw;
	}
	
	public void updatePw(String mid, String pw) {
		jdbcTemplate.update("update member set pw=? where mid = ?", pw, mid);
	}
	
//	구매목록 search
	public List<BookCommand> myPurBook(String mid) {
		List<BookCommand> purbook = jdbcTemplate.query("select pur_id, buy_date, p.bid, book_title1, book_date, book_writer1, book_cate, book_vol, price, cover_name, pfile_name, p.mid " + 
				"from purchase p, book b where p.bid = b.bid and p.mid=? order by pur_id desc"
				, new RowMapper<BookCommand>() {
					@Override
					public BookCommand mapRow(ResultSet rs, int rownum) throws SQLException {
						BookCommand buybook = new BookCommand(rs.getInt("pur_id"), rs.getDate("buy_date"), rs.getString("bid")
								,  rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1"), rs.getString("book_cate")
								, rs.getInt("book_vol"), rs.getInt("price"), rs.getString("cover_name"), rs.getString("pfile_name"), rs.getString("mid"));
						return buybook;
					}
				}, mid);
		
		return purbook.isEmpty()?null:purbook;
	}
}
