package com.by.response;

import javax.xml.bind.annotation.XmlRootElement;
import com.by.model.Founds;
import com.by.model.Historyowner;
import com.by.model.User;

@XmlRootElement
public class FoundsDetailResponseModel {
	private String status;
	private StringBuffer errorMSG;
	private int errorCode;//错误码
	private Founds foundsDetail;//活动详情
	private Historyowner historyOwner;//往届中奖者揭晓
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


	public Founds getFoundsDetail() {
		return foundsDetail;
	}


	public void setFoundsDetail(Founds foundsDetail) {
		this.foundsDetail = foundsDetail;
	}


	public Historyowner getHistoryOwner() {
		return historyOwner;
	}


	public void setHistoryOwner(Historyowner historyOwner) {
		this.historyOwner = historyOwner;
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
