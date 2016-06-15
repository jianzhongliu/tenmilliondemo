package com.by.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Founds {
	private String identify;
	private String name;
	private String images;
	private String totaln;
	private String nown;
	private String isover;	
	private String ownerid;
	private String overtime;
	private String resulttime;
	private String lastid;
	private String type;
	private String resultnumber;
	private String timeid;

	public String getIdentify() {
		return identify;
	}
	public void setIdentify(String identify) {
		this.identify = identify;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImages() {
		return images;
	}
	public void setImages(String images) {
		this.images = images;
	}
	public String getTotaln() {
		return totaln;
	}
	public void setTotaln(String totaln) {
		this.totaln = totaln;
	}
	public String getNown() {
		return nown;
	}
	public void setNown(String nown) {
		this.nown = nown;
	}
	public String getIsover() {
		return isover;
	}
	public void setIsover(String isover) {
		this.isover = isover;
	}
	public String getOwnerid() {
		return ownerid;
	}
	public void setOwnerid(String ownerid) {
		this.ownerid = ownerid;
	}
	public String getOvertime() {
		return overtime;
	}
	public void setOvertime(String overtime) {
		this.overtime = overtime;
	}
	public String getResulttime() {
		return resulttime;
	}
	public void setResulttime(String resulttime) {
		this.resulttime = resulttime;
	}
	public String getLastid() {
		return lastid;
	}
	public void setLastid(String lastid) {
		this.lastid = lastid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}	

	public String getResultnumber() {
		return resultnumber;
	}
	public void setResultnumber(String resultnumber) {
		this.resultnumber = resultnumber;
	}
	

	public String getTimeid() {
		return timeid;
	}
	public void setTimeid(String timeid) {
		this.timeid = timeid;
	}
	@Override
	public String toString() {
		return "[name=" + this.getName() + "]";
	}
}
