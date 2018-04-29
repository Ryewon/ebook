package book;

import org.springframework.web.multipart.MultipartFile;

public class BookCommand {
	private int price, pfil_page;
	private String mid, title, book_writer, book_cate, contents_table, book_intro, cover_path,
	 pfile_path, pimg_path;
	private MultipartFile cover_name, pfile_name;
	
	public BookCommand(int price, int pfil_page, String mid, String title, String book_writer, String book_cate,
			String contents_table, String book_intro, String cover_path, String pfile_path, String pimg_path,
			MultipartFile cover_name, MultipartFile pfile_name) {
		super();
		this.price = price;
		this.pfil_page = pfil_page;
		this.mid = mid;
		this.title = title;
		this.book_writer = book_writer;
		this.book_cate = book_cate;
		this.contents_table = contents_table;
		this.book_intro = book_intro;
		this.cover_path = cover_path;
		this.pfile_path = pfile_path;
		this.pimg_path = pimg_path;
		this.cover_name = cover_name;
		this.pfile_name = pfile_name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getPfil_page() {
		return pfil_page;
	}

	public void setPfil_page(int pfil_page) {
		this.pfil_page = pfil_page;
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

	public String getPimg_path() {
		return pimg_path;
	}

	public void setPimg_path(String pimg_path) {
		this.pimg_path = pimg_path;
	}

	public MultipartFile getCover_name() {
		return cover_name;
	}

	public void setCover_name(MultipartFile cover_name) {
		this.cover_name = cover_name;
	}

	public MultipartFile getPfile_name() {
		return pfile_name;
	}

	public void setPfile_name(MultipartFile pfile_name) {
		this.pfile_name = pfile_name;
	}
	
	
}
