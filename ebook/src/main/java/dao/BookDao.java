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
	
	public void upBook(int bid, String title, String writer, String cate, int price, String con_table, 
		String intro, String cfile, String cpath, String pfile, int pCnt, String ppath, String ipath, String mid) {
		jdbcTemplate.update("insert into book values(?, ?, sysdate, ?, ?, ?, ?, ?, 0, ?, ?, ?, ?, ?, ?, ?)", 
				bid, title, writer, cate,
						price, con_table, intro,
						cfile, cpath, pfile, pCnt,
						ppath, ipath, mid);
	}

	public int suchBid() {
		int bid = jdbcTemplate.queryForObject("select nvl(max(bid), 0)+1 from book", Integer.class);
		return bid;
	}
	
	public List<Book> cateBook(String cate) {
		System.out.println(cate);
		if(cate=="") {
			List<Book> book = jdbcTemplate.query("select * from book order by bid desc"
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
					});
			return book.isEmpty()?null:book;
		} else {
			List<Book> book = jdbcTemplate.query("select * from book where book_cate = ? order by bid desc"
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
					}, cate);
			return book.isEmpty()?null:book;
		}
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
	
	public void buyBook(String mid, int bid) {
		System.out.println("구매insert");

		int pur_id = jdbcTemplate.queryForObject("select nvl(max(pur_id), 0)+1 from purchase", Integer.class);
		jdbcTemplate.update("insert into purchase values(?, sysdate, ?, ?)", pur_id, mid, bid);
		jdbcTemplate.update("update book set book_vol=(select book_vol+1 from book where bid=?) where bid=?;", bid, bid);
	}
}
