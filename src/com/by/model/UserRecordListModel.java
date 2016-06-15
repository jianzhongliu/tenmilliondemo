package com.by.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class UserRecordListModel {
	private String identify;
	private String foundsId;
	private String name;
	private String images;
	private String numberString;
	private String time;
	private String ownerIcon;
	private String isOver;
	private String ownerId;
	private String timeid;
	
	public String getIdentify() {
		return identify;
	}


	public void setIdentify(String identify) {
		this.identify = identify;
	}


	public String getFoundsId() {
		return foundsId;
	}


	public void setFoundsId(String foundsId) {
		this.foundsId = foundsId;
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


	public String getNumberString() {
		return numberString;
	}


	public void setNumberString(String numberString) {
		this.numberString = numberString;
	}


	public String getTime() {
		return time;
	}


	public void setTime(String time) {
		this.time = time;
	}



	public String getOwnerIcon() {
		return ownerIcon;
	}


	public void setOwnerIcon(String ownerIcon) {
		this.ownerIcon = ownerIcon;
	}


	public String getIsOver() {
		return isOver;
	}


	public void setIsOver(String isOver) {
		this.isOver = isOver;
	}


	public String getOwnerId() {
		return ownerId;
	}


	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
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
