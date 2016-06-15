package com.by.response;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import com.by.model.Founds;

@XmlRootElement
public class HomeResponseModel {
	private String status;
	private StringBuffer errorMSG;
	private int errorCode;//错误码
	private ArrayList<Founds> overArray;//即将结束 type = 1
	private ArrayList<Founds> activityArray;//活跃 type = 2
	private ArrayList<Founds> hotArray;//热门 type = 3
	private ArrayList<Founds> allArray;//热门 type = 0
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public StringBuffer getErrorMSG() {
		return errorMSG;
	}
	public void setErrorMSG(StringBuffer errorMSG) {
		this.errorMSG = errorMSG;
	}
	public int getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}
	public ArrayList<Founds> getOverArray() {
		return overArray;
	}
	public void setOverArray(ArrayList<Founds> overArray) {
		this.overArray = overArray;
	}
	public ArrayList<Founds> getActivityArray() {
		return activityArray;
	}
	public void setActivityArray(ArrayList<Founds> activityArray) {
		this.activityArray = activityArray;
	}
	public ArrayList<Founds> getHotArray() {
		return hotArray;
	}
	public void setHotArray(ArrayList<Founds> hotArray) {
		this.hotArray = hotArray;
	}
	public ArrayList<Founds> getAllArray() {
		return allArray;
	}
	public void setAllArray(ArrayList<Founds> allArray) {
		this.allArray = allArray;
	}
	
	@Override
	public String toString() {
		return "[errorMSG=" + errorMSG +"]";
	}
}
