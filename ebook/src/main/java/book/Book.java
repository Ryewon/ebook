package book;

import java.util.Date;

public class Book {
	private int bid, price, book_vol, pfile_page;
	private String title, book_writer, book_cate, contents_table, book_intro, cover_name, cover_path,
		pfile_name, pfile_path, pimg_path, mid;
	private Date book_date;
	
	public Book(int bid, String title, Date book_date, String book_writer, String book_cate, int price, String contents_table, String book_intro,
			int book_vol, String cover_name, String cover_path, String pfile_name, int pfile_page, String pfile_path, String pimg_path, String mid) {
		super();
		this.bid = bid;
		this.price = price;
		this.book_vol = book_vol;
		this.pfile_page = pfile_page;
		this.mid = mid;
		this.title = title;
		this.book_writer = book_writer;
		this.book_cate = book_cate;
		this.contents_table = contents_table;
		this.book_intro = book_intro;
		this.cover_name = cover_name;
		this.cover_path = cover_path;
		this.pfile_name = pfile_name;
		this.pfile_path = pfile_path;
		this.pimg_path = pimg_path;
		this.book_date = book_date;
	}
	
	

	public Book(int price, int pfile_page, String mid, String title, String book_writer, String book_cate,
			String contents_table, String book_intro, String cover_name, String cover_path, String pfile_name,
			String pfile_path, String pimg_path) {
		super();
		this.price = price;
		this.pfile_page = pfile_page;
		this.mid = mid;
		this.title = title;
		this.book_writer = book_writer;
		this.book_cate = book_cate;
		this.contents_table = contents_table;
		this.book_intro = book_intro;
		this.cover_name = cover_name;
		this.cover_path = cover_path;
		this.pfile_name = pfile_name;
		this.pfile_path = pfile_path;
		this.pimg_path = pimg_path;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getBook_vol() {
		return book_vol;
	}

	public void setBook_vol(int book_vol) {
		this.book_vol = book_vol;
	}

	public int getPfile_page() {
		return pfile_page;
	}

	public void setPfil_page(int pfile_page) {
		this.pfile_page = pfile_page;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getBook_writer() {
		return book_writer;
	}

	public void setBook_writer(String book_writer) {
		this.book_writer = book_writer;
	}

	public String getBook_cate() {
		return book_cate;
	}

	public void setBook_cate(String book_cate) {
		this.book_cate = book_cate;
	}

	public String getContents_table() {
		return contents_table;
	}

	public void setContents_table(String contents_table) {
		this.contents_table = contents_table;
	}

	public String getBook_intro() {
		return book_intro;
	}

	public void setBook_intro(String book_intro) {
		this.book_intro = book_intro;
	}

	public String getCover_name() {
		return cover_name;
	}

	public void setCover_name(String cover_name) {
		this.cover_name = cover_name;
	}

	public String getCover_path() {
		return cover_path;
	}

	public void setCover_path(String cover_path) {
		this.cover_path = cover_path;
	}

	public String getPfile_name() {
		return pfile_name;
	}

	public void setPfile_name(String pfile_name) {
		this.pfile_name = pfile_name;
	}

	public String getPfile_path() {
		return pfile_path;
	}

	public void setPfile_path(String pfile_path) {
		this.pfile_path = pfile_path;
	}

	public String getPimg_path() {
		return pimg_path;
	}

	public void setPimg_path(String pimg_path) {
		this.pimg_path = pimg_path;
	}

	public Date getBook_date() {
		return book_date;
	}

	public void setBook_date(Date book_date) {
		this.book_date = book_date;
	}
	
	
}
