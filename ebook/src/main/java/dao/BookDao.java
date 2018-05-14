package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import book.Book;
import book.BookCommand;

public class BookDao {
	private JdbcTemplate jdbcTemplate;
	
	public BookDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
/*	public void upBook(int bid, String title, String writer, String cate, int price, String con_table, 
		String intro, String cfile, String cpath, String pfile, int pCnt, String ppath, String ipath, String mid) {
		jdbcTemplate.update("insert into book values(?, ?, sysdate, ?, ?, ?, ?, ?, 0, ?, ?, ?, ?, ?, ?, ?)", 
				bid, title, writer, cate,
						price, con_table, intro,
						cfile, cpath, pfile, pCnt,
						ppath, ipath, mid);
	}
*/

	public void upBook(int bid, String title1, String title2, String writer1, String writer2, String cate, int price, String con_table, 
			String intro, String cfile, String cpath, String pfile, int pCnt, String ppath, String mid) {
			jdbcTemplate.update("insert into book values(?, ?, ?, sysdate, ?, ?, ?, ?, ?, ?, 0, ?, ?, ?, ?, ?, ?)", 
					bid, title1, title1, writer1, writer2, cate,
							price, con_table, intro,
							cfile, cpath, pfile, pCnt,
							ppath, mid);
		}
	
	public int suchBid() {
		int bid = jdbcTemplate.queryForObject("select nvl(max(bid), 0)+1 from book", Integer.class);
		return bid;
	}
	
	public List<Book> cateBook1() {
		List<Book> bestBook = jdbcTemplate.query("select * from book where rownum <=3 order by book_vol desc"
				, new RowMapper<Book>() {
			@Override
			public Book mapRow(ResultSet rs, int rownum) throws SQLException {
				Book bbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1")
						,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
						, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
						, rs.getString("pfile_name"), rs.getInt("pfile_page"), rs.getString("pfile_path")
						, rs.getString("mid"));
				return bbook;
			}
		});
		return bestBook.isEmpty()?null:bestBook;
	}
	
	public List<Book> cateBook2() {
		List<Book> newBook = jdbcTemplate.query("select * from book where rownum <=3 order by book_date desc"
				, new RowMapper<Book>() {
			@Override
			public Book mapRow(ResultSet rs, int rownum) throws SQLException {
				Book nbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1")
						,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
						, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
						, rs.getString("pfile_name"), rs.getInt("pfile_page"), rs.getString("pfile_path")
						, rs.getString("mid"));
				return nbook;
			}
		});
		return newBook.isEmpty()?null:newBook;
	}
	
	public List<Book> cateBook3(String cate) {
		System.out.println(cate);
		List<Book> book = jdbcTemplate.query("select * from book where book_cate = ? order by bid desc"
				, new RowMapper<Book>() {
					@Override
					public Book mapRow(ResultSet rs, int rownum) throws SQLException {
						Book mbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1")
								,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
								, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
								, rs.getString("pfile_name"), rs.getInt("pfile_page"), rs.getString("pfile_path")
								, rs.getString("mid"));
						return mbook;
					}
				}, cate);
		return book.isEmpty()?null:book;
	}
	
	public String buyCheck(String mid, int bid) {
		String pur_id = null;
		try {
			pur_id=jdbcTemplate.queryForObject("select pur_id from purchase where mid=? and bid=?", String.class, mid, bid);		
			System.out.println(pur_id);
			return "already";
		} catch (Exception e) {
			return "ok";
		}		
	}
	
	public void buyBook(String mid, int bid, int cpoint, int ppoint, int apoint) {
		System.out.println("구매insert");
		System.out.println(bid);
		int pur_id = jdbcTemplate.queryForObject("select nvl(max(pur_id), 0)+1 from purchase", Integer.class);
		jdbcTemplate.update("insert into purchase values(?, sysdate, ?, ?)", pur_id, mid, bid);
		jdbcTemplate.update("update book set book_vol=(select book_vol+1 from book where bid=?) where bid=?", bid, bid);
		jdbcTemplate.update("update member set point=? where mid=?", apoint, mid);
		jdbcTemplate.update("insert into point values(?, ?, '구매', sysdate, ?)", ppoint, cpoint, mid);
	}
	
	public Book bookInfo(int bid) {
		Book book = jdbcTemplate.queryForObject("select * from book where bid=?"
				, new RowMapper<Book>() {
					@Override
					public Book mapRow(ResultSet rs, int rownum) throws SQLException {
						Book mbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getString("book_title2"), rs.getDate("book_date")
								, rs.getString("book_writer1"), rs.getString("book_writer2")
								,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
								, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
								, rs.getString("pfile_name"), rs.getInt("pfile_page"), rs.getString("pfile_path")
								, rs.getString("mid"));
						return mbook;
					}
				}, bid);
		return book;
	}
	
	public List<Book> searchBook(String selSrch, String searchCon) {
		System.out.println("Dao 와써요");
		List<Book> rsbook = null;
		String strLike = "%" + searchCon + "%";
		System.out.println("                       "+strLike);
		if(selSrch.equals("제목+작가")) {		
			rsbook = jdbcTemplate.query(
					"select bid, book_title1, book_date, book_writer1, book_cate, price, contents_table, book_intro, book_vol, cover_name, cover_path, pfile_name, pfile_page, pfile_path, mid " 
					+ "from " 
					+ "(select bid, book_title1, book_date, book_writer1, book_cate, price, contents_table, book_intro, book_vol, cover_name, cover_path, pfile_name, pfile_page, pfile_path, mid, book_writer2 || book_title2 as A, book_title2 || book_writer2 as B " 
					+ "from BOOK) " 
					+ "where A like ? or B like ?"
					, new RowMapper<Book>() {
						@Override
						public Book mapRow(ResultSet rs, int rownum) throws SQLException {
							Book mbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1")
									,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
									, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
									, rs.getString("pfile_name"), rs.getInt("pfile_page"), rs.getString("pfile_path")
									, rs.getString("mid"));
							return mbook;
						}
					}, strLike, strLike);
		} else if(selSrch.equals("제목")) {
			rsbook = jdbcTemplate.query(
					"select bid, book_title1, book_date, book_writer1, book_cate, price, contents_table, book_intro, book_vol, cover_name, cover_path, pfile_name, pfile_page, pfile_path, mid from BOOK where book_title2 like ?"
					, new RowMapper<Book>() {
						@Override
						public Book mapRow(ResultSet rs, int rownum) throws SQLException {
							Book mbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1")
									,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
									, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
									, rs.getString("pfile_name"), rs.getInt("pfile_page"), rs.getString("pfile_path")
									, rs.getString("mid"));
							return mbook;
						}
					}, strLike);
		} else {
			rsbook = jdbcTemplate.query(
					"select bid, book_title1, book_date, book_writer1, book_cate, price, contents_table, book_intro, book_vol, cover_name, cover_path, pfile_name, pfile_page, pfile_path, mid from BOOK where book_writer2 like ?"
					, new RowMapper<Book>() {
						@Override
						public Book mapRow(ResultSet rs, int rownum) throws SQLException {
							Book mbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1")
									,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
									, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
									, rs.getString("pfile_name"), rs.getInt("pfile_page"), rs.getString("pfile_path")
									, rs.getString("mid"));
							return mbook;
						}
					}, strLike);
		}
		System.out.println(rsbook);
		return rsbook.isEmpty()?null:rsbook;
		
	}
}
