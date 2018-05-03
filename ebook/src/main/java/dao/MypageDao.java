package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import book.Book;

public class MypageDao {
	private JdbcTemplate jdbcTemplate;

	public MypageDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public List<Book> myUpBook(String mid) {
		List<Book> book = jdbcTemplate.query("select * from book where mid = ?"
				, new RowMapper<Book>() {
					@Override
					public Book mapRow(ResultSet rs, int rownum) throws SQLException {
						Book mbook = new Book(rs.getInt("bid"), rs.getString("title"), rs.getDate("book_date"), rs.getString("book_writer")
								,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
								, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
								, rs.getString("pfile_name"), rs.getInt("pfile_page"), rs.getString("pfile_path"), rs.getString("pimg_path")
								, rs.getString("mid"));
						return mbook;
					}
				}, mid);
		
		return book.isEmpty()?null:book;
	}
	
	public void updateInfo(String name, String gender, String phone, String hint, String answer, String mid) {
		jdbcTemplate.update("update member set name=?, gender=?, phone=?, hint=?, answer=? where mid = ?"
				, name, gender, phone, hint, answer, mid);
	}
	
	public String getPasswrod(String mid) {
		String pw = jdbcTemplate.queryForObject("select pw from member where mid=?", String.class, mid);
		return pw;
	}
	
	public void updatePw(String mid, String pw) {
		jdbcTemplate.update("update member set pw=? where mid = ?", pw, mid);
	}
}
