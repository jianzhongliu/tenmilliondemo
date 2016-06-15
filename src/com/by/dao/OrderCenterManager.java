package com.by.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import com.by.factory.ConnectionFactory;
import com.by.model.Recode;

public class OrderCenterManager extends ConnectionFactory {
	public static void main(String[] args) { 
		OrderCenterManager orderCenter = new OrderCenterManager();
		orderCenter.createNewOwner("392840234805", "10000056", "20160515001");
	}
	/**添加一条购买信息*/
	public void insertUserObject(String foundsid, String userid,String number,String buyNumber,String timeid, String type) {
		Connection connect = null;
		Date date = new Date();
		String identitfy = "" + date.getTime();
		String sql = "INSERT INTO record(identify,foundsid,userid,number,time,type,buyNumber,timeid) VALUES (?,?,?,?,?,?,?,?)";
		PreparedStatement pstmt = null;
		System.out.print(sql);
		connect = createConnect();
		ResultSet rs = null;
		try {				
				pstmt =	connect.prepareStatement(sql);
				pstmt.setString(1, identitfy);
				pstmt.setString(2, foundsid);
				pstmt.setString(3, userid);
				pstmt.setString(4, number);
				pstmt.setString(5, identitfy);
				pstmt.setString(6, type);
				pstmt.setString(7, buyNumber);
				pstmt.setString(8, timeid);
				pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.print(e);
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			releaseConnect(connect, pstmt, rs);			
		}
	}

	public ArrayList<Recode> createNewOwner (String foundsId, String number,String timeId){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Recode> recordList = null;
		connect = createConnect();
		recordList = new ArrayList<Recode>();
		String sql = "select * from record where foundsid = "+foundsId +" and number like '%"+number+"%' and timeid = "+timeId;
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Recode founds = new Recode();
				founds.setIdentify(rs.getString("identify"));
				founds.setFoundsid(rs.getString("foundsid"));
				founds.setUserid(rs.getString("userid"));
				founds.setNumber(rs.getString("number"));
				founds.setTime(rs.getString("time"));
				founds.setType(rs.getString("type"));
				founds.setBuyNumber(rs.getString("buyNumber"));
				founds.setTimeid(rs.getString("timeid"));
				recordList.add(founds);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return recordList;
	}
	
	public ArrayList<Recode> caculateOwnerBuyNumber (String foundsId, String userId, String timeid){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Recode> recordList = null;
		connect = createConnect();
		recordList = new ArrayList<Recode>();
		String sql = "select * from record where foundsid = "+foundsId +" and userid = '"+userId +"' and timeid="+timeid;
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Recode founds = new Recode();
				founds.setIdentify(rs.getString("identify"));
				founds.setFoundsid(rs.getString("foundsid"));
				founds.setUserid(rs.getString("userid"));
				founds.setNumber(rs.getString("number"));
				founds.setTime(rs.getString("time"));
				founds.setType(rs.getString("type"));
				founds.setTimeid(rs.getString("timeid"));
				recordList.add(founds);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return recordList;
	}

	public ArrayList<Recode> getUserRecordList (String userId){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Recode> recordList = null;
		connect = createConnect();
		recordList = new ArrayList<Recode>();
		String sql = "select * from record where userid = " + userId;
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Recode founds = new Recode();
				founds.setIdentify(rs.getString("identify"));
				founds.setFoundsid(rs.getString("foundsid"));
				founds.setUserid(rs.getString("userid"));
				founds.setNumber(rs.getString("number"));
				founds.setTime(rs.getString("time"));
				founds.setType(rs.getString("type"));
				founds.setTimeid(rs.getString("timeid"));
				recordList.add(founds);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return recordList;
	}

}
