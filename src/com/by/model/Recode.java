package com.by.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Recode {
	private String identify;
	private String foundsid;
	private String userid;
	private String number;
	private String time;
	private String type;
	private String  buyNumber;
	private String timeid;
	
	public String getIdentify() {
		return identify;
	}
	public void setIdentify(String identify) {
		this.identify = identify;
	}
	public String getFoundsid() {
		return foundsid;
	}
	public void setFoundsid(String foundsid) {
		this.foundsid = foundsid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getBuyNumber() {
		return buyNumber;
	}
	public void setBuyNumber(String buyNumber) {
		this.buyNumber = buyNumber;
	}

	
	
	public String getTimeid() {
		return timeid;
	}
	public void setTimeid(String timeid) {
		this.timeid = timeid;
	}
	@Override
	public String toString() {
		return "[identify=" + this.getIdentify() + "]";
	}
}
