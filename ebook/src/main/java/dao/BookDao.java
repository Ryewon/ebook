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

	//책 올리기
	public void upBook(int bid, String title1, String title2, String writer1, String writer2, String cate, int price, String con_table, 
			String intro, String cfile, String cpath, String pfile, String ppath, String mid) {
		jdbcTemplate.update("insert into book(bid, book_title1, book_title2, book_date, book_writer1, book_writer2"
				+ ", book_cate, price, contents_table, book_intro, book_vol, cover_name, cover_path, pfile_name, pfile_path"
				+ ", mid, bexist) "
				+ "values(?, ?, ?, sysdate, ?, ?, ?, ?, ?, ?, 0, ?, ?, ?, ?, ?, 'yes')", 
				bid, title1, title1, writer1, writer2, cate,
						price, con_table, intro,
						cfile, cpath, pfile, 
						ppath, mid);
		jdbcTemplate.update("insert into bookmark(mid, bid) values (?, ?)", mid, bid);
	}
	
	//책테이블에 넣기 전 bid 구하기
	public int suchBid() {
		int bid = jdbcTemplate.queryForObject("select nvl(max(bid), 0)+1 from book", Integer.class);
		return bid;
	}
	
	// 베스트 도서 
	public List<Book> cateBook1() {
		List<Book> bestBook = jdbcTemplate.query(
				"select * "
				+ "from (" 
				+ "select row_number() over(order by book_vol desc, bid desc) as rnum,bid, book_title1, book_date, book_writer1, book_cate, price, "
				+ "contents_table, book_intro, book_vol, cover_name, cover_path, pfile_name, pfile_path, mid "
				+ "from book where bexist = 'yes')  where rnum<=3"
				, new RowMapper<Book>() {
			@Override
			public Book mapRow(ResultSet rs, int rownum) throws SQLException {
				Book bbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1")
						,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
						, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path"), rs.getString("pfile_name")
						, rs.getString("pfile_path"), rs.getString("mid"));
				return bbook;
			}
		});
		return bestBook.isEmpty()?null:bestBook;
	}
	
	//신간 도서
	public List<Book> cateBook2() {
		List<Book> newBook = jdbcTemplate.query(
				"select * "
				+ "from (select row_number() over(order by book_date desc, bid desc) as rnum, bid, book_title1, book_date, book_writer1, book_cate"
				+ ", price, contents_table, book_intro, book_vol, cover_name, cover_path, pfile_name, pfile_path, mid "
				+ "from book where bexist = 'yes') "
				+ "where rnum<=3"
				, new RowMapper<Book>() {
			@Override
			public Book mapRow(ResultSet rs, int rownum) throws SQLException {
				Book nbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1")
						,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
						, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path"), rs.getString("pfile_name")
						, rs.getString("pfile_path"), rs.getString("mid"));
				return nbook;
			}
		});
		return newBook.isEmpty()?null:newBook;
	}
	
	//책 구매 전 구매여부 확인
	public String buyCheck(String mid, int bid) {
		String pur_id = null;
		try {
			pur_id=jdbcTemplate.queryForObject("select pur_id from purchase where mid=? and bid=? and pexist='yes' order by pur_id desc", String.class, mid, bid);		
			System.out.println(pur_id);
			return "already";
		} catch (Exception e) {
			return "ok";
		}		
	}
	
	//책 구매
	public void buyBook(String mid, int bid, int cpoint, int ppoint, int apoint) {
		System.out.println("구매insert");
		System.out.println(bid);
		int pur_id = jdbcTemplate.queryForObject("select nvl(max(pur_id), 0)+1 from purchase", Integer.class);
		jdbcTemplate.update("insert into purchase (pur_id, buy_date, mid, bid, pexist) values(?, sysdate, ?, ?, 'yes')", pur_id, mid, bid);
		jdbcTemplate.update("update book set book_vol=(select book_vol+1 from book where bid=?) where bid=?", bid, bid);
		jdbcTemplate.update("update member set point=? where mid=?", apoint, mid);
		jdbcTemplate.update("insert into point values(?, ?, '구매', sysdate, ?)", ppoint, cpoint, mid);
		jdbcTemplate.update("insert into bookmark(mid, bid) values (?, ?)", mid, bid);
	}
	
	//책 정보
	public Book bookInfo(int bid) {
		Book book = jdbcTemplate.queryForObject(
				"select bid, book_title1, book_date, book_writer1, book_cate, price, contents_table, book_intro, book_vol"
				+ ", cover_name, cover_path, pfile_name, pfile_path, mid "
				+ "from book where bid=? and bexist = 'yes'"
				, new RowMapper<Book>() {
					@Override
					public Book mapRow(ResultSet rs, int rownum) throws SQLException {
						Book mbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date")
								, rs.getString("book_writer1"), rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table")
								, rs.getString("book_intro"), rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
								, rs.getString("pfile_name"), rs.getString("pfile_path"), rs.getString("mid"));
						return mbook;
					}
				}, bid);
		return book;
	}
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	//책 검색
	public List<Book> searchBook(int page, int limit, String selSrch, String searchCon) {
		int startrow = (page -1 ) * 5 + 1;
		int endrow = startrow + limit - 1;
		System.out.println("Dao 와써요");
		List<Book> rsbook = null;
		String strLike = "%" + searchCon + "%";
		System.out.println("                       "+strLike);
		if(selSrch.equals("제목")) { //제목에 따른 검색
			rsbook = jdbcTemplate.query(
					"select a.* from " + 
							"(select row_number() over(order by bid desc) rnum, bid, book_title1, book_date, book_writer1, book_cate, price, contents_table, book_intro, book_vol, "
							+ "cover_name, cover_path, pfile_name, pfile_path, mid " 
							+ "from BOOK where bexist = 'yes' and book_title2 like ?) a " 
							+ "where rnum>=? and rnum<=?"
					, new RowMapper<Book>() {
						@Override
						public Book mapRow(ResultSet rs, int rownum) throws SQLException {
							Book mbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1")
									,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
									, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
									, rs.getString("pfile_name"), rs.getString("pfile_path"), rs.getString("mid"));
							return mbook;
						}
					}, strLike, startrow, endrow);
		} else { // 작가에 따른 검색
			rsbook = jdbcTemplate.query(
					"select a.* from " + 
					"(select row_number() over(order by bid desc) rnum, bid, book_title1, book_date, book_writer1, book_cate, price, contents_table, book_intro, book_vol, "
					+ "cover_name, cover_path, pfile_name, pfile_path, mid " 
					+ "from BOOK where bexist = 'yes' and book_writer2 like ?) a " 
					+ "where rnum>=? and rnum<=?"
					, new RowMapper<Book>() {
						@Override
						public Book mapRow(ResultSet rs, int rownum) throws SQLException {
							Book mbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1")
									,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
									, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
									, rs.getString("pfile_name"), rs.getString("pfile_path"), rs.getString("mid"));
							return mbook;
						}
					}, strLike, startrow, endrow);
		}
		System.out.println(rsbook);
		return rsbook.isEmpty()?null:rsbook;
		
	}
	
	public int searchBookCnt(String selSrch, String searchCon) {
		int cnt = 0;
		String strLike = "%" + searchCon + "%";
		if(selSrch.equals("제목")) {
			cnt = jdbcTemplate.queryForObject(
					"select count(0) from BOOK where bexist = 'yes' and book_title2 like ?"
					, Integer.class, strLike);
		} else {
			cnt = jdbcTemplate.queryForObject(
					"select count(0) from BOOK where bexist = 'yes' and book_writer2 like ?"
					, Integer.class, strLike);
		}
		return cnt;
		
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//책 정렬
	public List<Book> sortedBook(int page, int limit, String cate, String price, String sortType) {
		int startrow = (page -1 ) * 5 + 1;
		int endrow = startrow + limit - 1;
		
		List<Book> book = null;
		String totalQuery = null;
		String orderQuery = null;
		String whereQuery = null;
		
		String stmt1 = "select a.* from (select row_number() over(";
		String stmt2 = ") rnum, bid, book_title1, book_date, book_writer1, book_cate, price, contents_table, book_intro, book_vol, "
				+ "cover_name, cover_path, pfile_name, pfile_path, mid from book where bexist='yes' and book_cate=?";
		String stmt3 = ") a where rnum>=? and rnum<=?";
		if(price.equals("전체")) {
			if(sortType.equals("최신순")) {
				orderQuery = " order by bid desc";
			} else if(sortType.equals("인기순")) {
				orderQuery = " order by book_vol desc, book_title1 asc";
			} else {
				orderQuery = " order by book_title1 asc";
			}
			totalQuery = stmt1 + orderQuery + stmt2 + stmt3;
		} else {
			if(price.equals("유료")) {
				whereQuery = " and price>0";
				if(sortType.equals("최신순")) {
					orderQuery = " order by bid desc";
				} else if(sortType.equals("인기순")) {
					orderQuery = " order by book_vol desc, book_title1 asc";				
				} else {
					orderQuery = " order by book_title1 asc";
				}
			} else {
				whereQuery = " and price=0";
				if(sortType.equals("최신순")) {
					orderQuery = " order by bid desc";
				} else if(sortType.equals("인기순")) {
					orderQuery = " order by book_vol desc, book_title1 asc";
				} else {
					orderQuery = " order by book_title1 asc";
				}
			}
			totalQuery = stmt1 + orderQuery + stmt2 + whereQuery +stmt3;
		}
		book = jdbcTemplate.query(totalQuery, new RowMapper<Book>() {
			@Override
			public Book mapRow(ResultSet rs, int rownum) throws SQLException {
				Book mbook = new Book(rs.getInt("bid"), rs.getString("book_title1"), rs.getDate("book_date"), rs.getString("book_writer1")
						,  rs.getString("book_cate"), rs.getInt("price"), rs.getString("contents_table"), rs.getString("book_intro") 
						, rs.getInt("book_vol"), rs.getString("cover_name"), rs.getString("cover_path")
						, rs.getString("pfile_name"), rs.getString("pfile_path"), rs.getString("mid"));
				return mbook;
			}
		}, cate, startrow, endrow);
		return book.isEmpty()?null:book;
	}
	
	public int sortedBookCnt(String cate, String price, String sortType) {
		int cnt = 0;
		String totalQuery = null;
		String mainQuery = "select count(0) from book";
		String whereQuery = " where bexist = 'yes' and book_cate=?";
		String orderQuery = " order by bid desc";
		if(price.equals("전체")) {
			if(sortType.equals("최신순")) {
				totalQuery = mainQuery + whereQuery + orderQuery;
			} else if(sortType.equals("인기순")) {
				orderQuery = " order by book_vol desc";
				totalQuery = mainQuery + whereQuery + orderQuery;
			} else {
				orderQuery = " order by book_title1 asc";
				totalQuery = mainQuery + whereQuery + orderQuery;
			}
		} else if(price.equals("유료")) {
			whereQuery += " and price>0";
			if(sortType.equals("최신순")) {
				totalQuery = mainQuery + whereQuery + orderQuery;
			} else if(sortType.equals("인기순")) {
				orderQuery = " order by book_vol desc";
				totalQuery = mainQuery + whereQuery + orderQuery;
			} else {
				orderQuery = " order by book_title1 asc";
				totalQuery = mainQuery + whereQuery + orderQuery;
			}
		} else {
			whereQuery += " and price=0";
			if(sortType.equals("최신순")) {
				totalQuery = mainQuery + whereQuery + orderQuery;
			} else if(sortType.equals("인기순")) {
				orderQuery = " order by book_vol desc";
				totalQuery = mainQuery + whereQuery + orderQuery;
			} else {
				orderQuery = " order by book_title1 asc";
				totalQuery = mainQuery + whereQuery + orderQuery;
			}
		}
		cnt = jdbcTemplate.queryForObject(totalQuery, Integer.class, cate);
		return cnt;
	}
}
