package member;

import javax.xml.crypto.Data;

public class PurchaseList {
	private int pur_id;
	private Data buy_date;
	private String mid;
	private int bid;
	
	public PurchaseList(int pur_id, Data buy_date, String mid, int bid) {
		super();
		this.pur_id = pur_id;
		this.buy_date = buy_date;
		this.mid = mid;
		this.bid = bid;
	}

	public int getPur_id() {
		return pur_id;
	}

	public void setPur_id(int pur_id) {
		this.pur_id = pur_id;
	}

	public Data getBuy_date() {
		return buy_date;
	}

	public void setBuy_date(Data buy_date) {
		this.buy_date = buy_date;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}
}
