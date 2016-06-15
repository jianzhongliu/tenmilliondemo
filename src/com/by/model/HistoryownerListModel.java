package com.by.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class HistoryownerListModel {

	private  Historyowner historyOwnerFounds;
	private  User historyOwnerUser;
	

	public Historyowner getHistoryOwnerFounds() {
		return historyOwnerFounds;
	}


	public void setHistoryOwnerFounds(Historyowner historyOwnerFounds) {
		this.historyOwnerFounds = historyOwnerFounds;
	}


	public User getHistoryOwnerUser() {
		return historyOwnerUser;
	}


	public void setHistoryOwnerUser(User historyOwnerUser) {
		this.historyOwnerUser = historyOwnerUser;
	}


	@Override
	public String toString() {
		return "[name=" + "]";
	}
}
