package com.by.response;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;
import com.by.model.Founds;
import com.by.model.Historyowner;
import com.by.model.UserRecordListModel;

@XmlRootElement
public class UserHistoryRecordResponseModel {
	private String status;
	private StringBuffer errorMSG;
	private int errorCode;//错误码
	private Founds foundsDetail;//活动详情
	private ArrayList<UserRecordListModel> recordList;
	private ArrayList<Historyowner> ownerRecordList;

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

	public ArrayList<UserRecordListModel> getRecordList() {
		return recordList;
	}

	public void setRecordList(ArrayList<UserRecordListModel> recordList) {
		this.recordList = recordList;
	}

	public ArrayList<Historyowner> getOwnerRecordList() {
		return ownerRecordList;
	}

	public void setOwnerRecordList(ArrayList<Historyowner> ownerRecordList) {
		this.ownerRecordList = ownerRecordList;
	}

	@Override
	public String toString() {
		return "[errorMSG=" + errorMSG +"]";
	}
}
