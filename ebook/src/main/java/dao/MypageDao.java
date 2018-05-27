package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

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
	
	public List<BookCommand> myUpBook(String mid, int page, int limit) {
		int startrow = (page -1 ) * 5 + 1;
		int endrow = startrow + limit - 1;
		List<BookCommand> book = jdbcTemplate.query(
				"select a.* from " + 
				"(select row_number() over(order by book_date desc, b.bid desc) rnum, b.bid, book_title1, book_date, book_writer1, book_cate, price, contents_table, book_intro, book_vol, cover_name, cover_path, pfile_name, pfile_path, b.mid, m.lastpage " + 
				"from book  b, bookmark m " + 
				"where b.mid = m.mid and b.bid=m.bid and b.mid=? and bexist = 'yes' ) a where rnum>=? and rnum<=?"
				, new RowMapper<BookCommand>() {
					@Override
					public BookCommand mapRow(ResultSet rs, int rownum) throws SQLException {
						BookCommand mbook = new BookCommand(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date")
								, rs.getString("book_writer1"), rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table")
								, rs.getString("book_intro"), rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
								, rs.getString("pfile_name"), rs.getString("pfile_path")
								, rs.getString("mid"), rs.getInt("lastpage"));
						return mbook;
					}
				}, mid, startrow, endrow);
		
		return book.isEmpty()?null:book;
	}
	
	public int myUpBookCnt(String mid) {
		int cnt = 0;
		cnt = jdbcTemplate.queryForObject(
				"select count(0) from book where bexist = 'yes' and mid = ? order by book_date desc"
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
				"select b.* from" + 
				"(select row_number() over(order by buy_date desc, pur_id desc) rnum, a.*, m.lastpage from " + 
				"(select pur_id, buy_date, p.bid" + 
				", book_title1, book_date, book_writer1, book_cate, book_vol, price, cover_name" + 
				", pfile_name, p.mid " + 
				"from purchase p, book b where p.bid = b.bid and pexist='yes') a, bookmark m " + 
				"where a.bid=m.bid and a.mid=m.mid and a.mid=?) b where rnum >= ? and rnum <= ?"
				, new RowMapper<BookCommand>() {
					@Override
					public BookCommand mapRow(ResultSet rs, int rownum) throws SQLException {
						BookCommand buybook = new BookCommand(rs.getInt("pur_id"), rs.getDate("buy_date"), rs.getInt("bid")
								,  rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1"), rs.getString("book_cate")
								, rs.getInt("book_vol"), rs.getInt("price"), rs.getString("cover_name"), rs.getString("pfile_name")
								, rs.getString("mid"), rs.getInt("lastpage"));
						return buybook;
					}
				}, mid, startrow, endrow);
		
		return purbook.isEmpty()?null:purbook;
	}
	
	public int myPurBookCnt(String mid) {
		int cnt = 0;
		cnt = jdbcTemplate.queryForObject(
				"select count(0) " + 
				"from purchase p, book b where p.bid = b.bid and p.mid=? and pexist='yes' order by buy_date desc"
				, Integer.class, mid);
		return cnt;
	}
	
	public void DelupBook(String mid, int bid) {
		jdbcTemplate.update("update book set bdel_date=sysdate, bexist='no' where bid=?", bid);
		jdbcTemplate.update("delete from bookmark where mid = ? and bid = ?", mid, bid);
	}
	
	public void DelbuyBook(String mid, int pur_id) {
		jdbcTemplate.update("update purchase set pdel_date=sysdate, pexist='no' where pur_id=?", pur_id);
		jdbcTemplate.update("delete from bookmark where mid = ? and bid = (select bid from purchase where pur_id = ?)", mid, pur_id);
	}
	
	public void modifyCoverBook(String title1, String title2, String cate, int price, String con_table, String intro, String cfile, String cpath, int bid) {
		jdbcTemplate.update("update book set book_title1=?, book_title2=?, book_cate=?, price=?, contents_table=?, book_intro=?,"
				+ "cover_name=?, cover_path=?, bmod_date=sysdate where bid=?"
				, title1, title2, cate, price, con_table, intro, cfile, cpath, bid);
	}
	
	public void modifyPdfBook(String title1, String title2, String cate, int price, String con_table, String intro
			, String pfile, String ppath, String mid, int bid) {
		jdbcTemplate.update("update book set book_title1=?, book_title2=?, book_cate=?, price=?, contents_table=?, book_intro=?,"
				+ "pfile_name=?, pfile_path=?, bmod_date=sysdate where bid=?"
				, title1, title2, cate, price, con_table, intro, pfile, ppath, bid);
		jdbcTemplate.update("update bookmark set lastpage=1, lastdate=sysdate where mid=? and bid=?", mid, bid);
	}
	
	public void modifyCoverPdfBook(String title1, String title2, String cate, int price, String con_table, String intro, String cfile, String cpath
			, String pfile, String ppath, String mid, int bid) {
		jdbcTemplate.update("update book set book_title1=?, book_title2=?, book_cate=?, price=?, contents_table=?, book_intro=?,"
				+ "cover_name=?, cover_path=?, pfile_name=?, pfile_path=?, bmod_date=sysdate where bid=?"
				, title1, title2, cate, price, con_table, intro, cfile, cpath, pfile, ppath, bid);
		jdbcTemplate.update("update bookmark set lastpage=1, lastdate=sysdate where mid=? and bid=?", mid, bid);
	}
	
	public void modifyBook(String title1, String title2, String cate, int price, String con_table, String intro, int bid) {
		jdbcTemplate.update("update book set book_title1=?, book_title2=?, book_cate=?, price=?, contents_table=?, book_intro=?,"
				+ "bmod_date=sysdate where bid=?"
				, title1, title2, cate, price, con_table, intro, bid);
	}
	
	public void addBookMark(String mid, int bid, int lastpage) {
		jdbcTemplate.update("update bookmark set lastpage=?, lastdate=sysdate where mid=? and bid=?", lastpage, mid, bid);
	}
}
