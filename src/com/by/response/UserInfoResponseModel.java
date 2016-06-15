package com.by.response;

import javax.xml.bind.annotation.XmlRootElement;
import com.by.model.User;

@XmlRootElement
public class UserInfoResponseModel {
	private String status;
	private StringBuffer errorMSG;
	private int errorCode;//错误码
	private User userInfo;//中奖用户信息
	
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

	public User getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(User userInfo) {
		this.userInfo = userInfo;
	}

	@Override
	public String toString() {
		return "[errorMSG=" + errorMSG +"]";
	}
}
