package com.by.response;

import javax.xml.bind.annotation.XmlRootElement;
import com.by.model.Historyowner;
import com.by.model.HistoryownerListModel;

import java.util.ArrayList;

@XmlRootElement
public class FoundsHistoryResultResponseModel {
	private String status;
	private StringBuffer errorMSG;
	private int errorCode;//错误码
	private ArrayList<HistoryownerListModel> historyResult;

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


	public ArrayList<HistoryownerListModel> getHistoryResult() {
		return historyResult;
	}

	public void setHistoryResult(ArrayList<HistoryownerListModel> historyResult) {
		this.historyResult = historyResult;
	}

	@Override
	public String toString() {
		return "[errorMSG=" + errorMSG +"]";
	}
}
