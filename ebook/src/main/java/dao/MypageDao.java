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
	
	public List<Book> myUpBook(String mid, int page, int limit) {
		int startrow = (page -1 ) * 5 + 1;
		int endrow = startrow + limit - 1;
		List<Book> book = jdbcTemplate.query(
				"select a.* from " 
				+ "(select row_number() over(order by book_date desc) rnum, bid, book_title1, book_date, book_writer1, book_cate, price, contents_table, book_intro, book_vol, cover_name, cover_path, pfile_name, pfile_page, pfile_path, mid " 
				+ "from book " 
				+ "where bexist = 'yes' and mid = ?)a where rnum >=? and rnum <=?"
				, new RowMapper<Book>() {
					@Override
					public Book mapRow(ResultSet rs, int rownum) throws SQLException {
						Book mbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date")
								, rs.getString("book_writer1"), rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table")
								, rs.getString("book_intro"), rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
								, rs.getString("pfile_name"), rs.getInt("pfile_page"), rs.getString("pfile_path")
								, rs.getString("mid"));
						return mbook;
					}
				}, mid, startrow, endrow);
		
		return book.isEmpty()?null:book;
	}
	
	public int myUpBookCnt(String mid) {
		int cnt = 0;
		cnt = jdbcTemplate.queryForObject(
				"select count(*) from book where bexist = 'yes' and mid = ? order by book_date desc"
				, Integer.class, mid);
		return cnt;
	}
	
	public void updateInfo(String name1, String name2, String gender, String phone, String hint, String answer, String mid) {
		jdbcTemplate.update("update member set name=?, gender=?, phone=?, hint=?, answer=?, mmod_date=sysdate where mid = ?"
				, name1, gender, phone, hint, answer, mid);
		jdbcTemplate.update("update book set book_writer1=?, book_writer2=? where mid = ?"
				, name1, name2 , mid);
	}
	
	public String getPasswrod(String mid) {
		String pw = jdbcTemplate.queryForObject("select pw from member where mid=?", String.class, mid);
		return pw;
	}
	
	public void updatePw(String mid, String pw) {
		jdbcTemplate.update("update member set pw=?, mmod_date=sysdate where mid = ?", pw, mid);
	}
	
//	구매목록 search
	public List<BookCommand> myPurBook(String mid, int page, int limit) {
		int startrow = (page -1 ) * 5 + 1;
		int endrow = startrow + limit - 1;
		List<BookCommand> purbook = jdbcTemplate.query(
				"select a.* from " 
				+ "(select row_number() over(order by buy_date desc) rnum, pur_id, buy_date, p.bid"
				+ ", book_title1, book_date, book_writer1, book_cate, book_vol, price, cover_name"
				+ ", pfile_name, p.mid " 
				+ "from purchase p, book b where p.bid = b.bid and p.mid=?) a where rnum >= ? and rnum <= ?"
				, new RowMapper<BookCommand>() {
					@Override
					public BookCommand mapRow(ResultSet rs, int rownum) throws SQLException {
						BookCommand buybook = new BookCommand(rs.getInt("pur_id"), rs.getDate("buy_date"), rs.getString("bid")
								,  rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1"), rs.getString("book_cate")
								, rs.getInt("book_vol"), rs.getInt("price"), rs.getString("cover_name"), rs.getString("pfile_name"), rs.getString("mid"));
						return buybook;
					}
				}, mid, startrow, endrow);
		
		return purbook.isEmpty()?null:purbook;
	}
	
	public int myPurBookCnt(String mid) {
		int cnt = 0;
		cnt = jdbcTemplate.queryForObject(
				"select count(*) " + 
				"from purchase p, book b where p.bid = b.bid and p.mid=? order by buy_date desc"
				, Integer.class, mid);
		return cnt;
	}
	
	public void DelupBook(int bid) {
		jdbcTemplate.update("update book set bdel_date=sysdate, bexist='no' where bid=?", bid);
	}
	
	public void DelbuyBook(int pur_id) {
		jdbcTemplate.update("update purchase set pdel_date=sysdate, pexist='no' where pur_id=?", pur_id);
	}
}
