package book;

import java.util.Date;

/**
 * @author intern2
 *
 */
public class BookCommand {
	private int pur_id, bid;
	private Date buy_date;
	private String book_title1, book_title2;
	private Date book_date;
	private String book_writer1, book_writer2, book_cate, contents_table, book_intro;
	private int book_vol, price;
	private String cover_name, cover_path, pfile_name, pfile_path, mid;
	private int lastpage;
	
	public BookCommand(int pur_id, Date buy_date, int bid, String book_title1, Date book_date, String book_writer1,
			 String book_cate, int book_vol, int price, String cover_name, String pfile_name, String mid, int lastpage) {
		super();
		this.pur_id = pur_id;
		this.buy_date = buy_date;
		this.bid = bid;
		this.book_title1 = book_title1;
		this.book_date = book_date;
		this.book_writer1 = book_writer1;
		this.book_cate = book_cate;
		this.book_vol = book_vol;
		this.price = price;
		this.cover_name = cover_name;
		this.pfile_name = pfile_name;
		this.mid = mid;
		this.lastpage = lastpage;
	}
	
	public BookCommand(int bid, String book_title1, Date book_date, String book_writer1, String book_cate, int price, String contents_table, 
			String book_intro, int book_vol, String cover_name, String cover_path, String pfile_name, String pfile_path, String mid,
			int lastpage) {
		super();
		this.bid = bid;
		this.book_title1 = book_title1;
		this.book_date = book_date;
		this.book_writer1 = book_writer1;
		this.book_cate = book_cate;
		this.price = price;
		this.contents_table = contents_table;
		this.book_intro = book_intro;
		this.book_vol = book_vol;
		this.cover_name = cover_name;
		this.cover_path = cover_path;
		this.pfile_name = pfile_name;
		this.pfile_path = pfile_path;
		this.mid = mid;
		this.lastpage = lastpage;
	}

	public int getPur_id() {
		return pur_id;
	}

	public void setPur_id(int pur_id) {
		this.pur_id = pur_id;
	}

	public Date getBuy_date() {
		return buy_date;
	}

	public void setBuy_date(Date buy_date) {
		this.buy_date = buy_date;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public String getBook_title1() {
		return book_title1;
	}

	public void setBook_title1(String book_title1) {
		this.book_title1 = book_title1;
	}

	public String getBook_title2() {
		return book_title2;
	}

	public void setBook_title2(String book_title2) {
		this.book_title2 = book_title2;
	}

	public Date getBook_date() {
		return book_date;
	}

	public void setBook_date(Date book_date) {
		this.book_date = book_date;
	}

	public String getBook_writer1() {
		return book_writer1;
	}

	public void setBook_writer1(String book_writer1) {
		this.book_writer1 = book_writer1;
	}

	public String getBook_writer2() {
		return book_writer2;
	}

	public void setBook_writer2(String book_writer2) {
		this.book_writer2 = book_writer2;
	}

	public String getBook_cate() {
		return book_cate;
	}

	public void setBook_cate(String book_cate) {
		this.book_cate = book_cate;
	}

	public int getBook_vol() {
		return book_vol;
	}

	public void setBook_vol(int book_vol) {
		this.book_vol = book_vol;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCover_name() {
		return cover_name;
	}

	public void setCover_name(String cover_name) {
		this.cover_name = cover_name;
	}

	public String getPfile_name() {
		return pfile_name;
	}

	public void setPfile_name(String pfile_name) {
		this.pfile_name = pfile_name;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public int getLastpage() {
		return lastpage;
	}

	public void setLastpage(int lastpage) {
		this.lastpage = lastpage;
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

	public String getCover_path() {
		return cover_path;
	}

	public void setCover_path(String cover_path) {
		this.cover_path = cover_path;
	}

	public String getPfile_path() {
		return pfile_path;
	}

	public void setPfile_path(String pfile_path) {
		this.pfile_path = pfile_path;
	}
	
}
