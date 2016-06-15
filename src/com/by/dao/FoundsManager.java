package com.by.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Timer;

import com.by.factory.ConnectionFactory;
import com.by.model.Founds;
import com.by.model.Historyowner;
import com.by.model.User;
import com.by.utils.MyTimerTask;

public class FoundsManager extends ConnectionFactory {
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		FoundsManager manager = new FoundsManager();
		ArrayList<Founds> arrayList =manager.getAllFounds("1",1,20);
		System.out.println(arrayList);
		Founds founds = new Founds();
		founds.setIdentify("1");
		founds.setNown("39");
		if (manager.updateFoundsWithObject(founds)) System.out.println(founds);
		
		String buyNumber = "1";
		String numberString="0";
		for (int i = 0; i < Integer.valueOf(buyNumber).intValue(); i++) {
			 numberString = Integer.valueOf(numberString) + Integer.valueOf(founds.getNown()) + i + 10000000 + ",";
		}
		System.out.println("========="+numberString);
	}
	
	public void startTimer() {
//		while (true){
	        try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
	        Timer timer = new Timer();
	        timer.schedule(new MyTimerTask(), 2000, 300000);
//		}

	}
	
	public ArrayList<Founds> getAllFounds (String type,int index, int pageSize){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Founds> foundsList = null;
		connect = createConnect();
		foundsList = new ArrayList<Founds>();
		String sql = "select * from founds where type ="+type +" order by starttime desc limit "+(index+-1)*pageSize+","+pageSize+"";
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Founds founds = new Founds();
				founds.setIdentify(rs.getString("identify"));
				founds.setName(rs.getString("name"));
				founds.setImages(rs.getString("images"));
				founds.setTotaln(rs.getString("totaln"));
				founds.setNown(rs.getString("nown"));
				founds.setIsover(rs.getString("isover"));
				founds.setOwnerid(rs.getString("ownerid"));
				founds.setOvertime(rs.getString("overtime"));
				founds.setResulttime(rs.getString("resulttime"));
				founds.setLastid(rs.getString("lastid"));
				founds.setType(rs.getString("type"));
				founds.setTimeid(rs.getString("timeid"));
				founds.setResulttime(rs.getString("resultnumber"));
				foundsList.add(founds);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return foundsList;
	}
	
	public ArrayList<Founds> getAllFoundsFromDB (){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Founds> foundsList = null;
		connect = createConnect();
		foundsList = new ArrayList<Founds>();
		String sql = "select * from founds";
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Founds founds = new Founds();
				founds.setIdentify(rs.getString("identify"));
				founds.setName(rs.getString("name"));
				founds.setImages(rs.getString("images"));
				founds.setTotaln(rs.getString("totaln"));
				founds.setNown(rs.getString("nown"));
				founds.setIsover(rs.getString("isover"));
				founds.setOwnerid(rs.getString("ownerid"));
				founds.setOvertime(rs.getString("overtime"));
				founds.setResulttime(rs.getString("resulttime"));
				founds.setLastid(rs.getString("lastid"));
				founds.setType(rs.getString("type"));
				founds.setTimeid(rs.getString("timeid"));
				founds.setResulttime(rs.getString("resultnumber"));
				foundsList.add(founds);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return foundsList;
	}
	public ArrayList<Founds> getAllFoundsByType (String category,int index, int pageSize){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Founds> foundsList = null;
		connect = createConnect();
		foundsList = new ArrayList<Founds>();
		String sql = "select * from founds where categray ="+category  +" order by starttime desc limit "+(index+-1)*pageSize+","+pageSize+"";
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Founds founds = new Founds();
				founds.setIdentify(rs.getString("identify"));
				founds.setName(rs.getString("name"));
				founds.setImages(rs.getString("images"));
				founds.setTotaln(rs.getString("totaln"));
				founds.setNown(rs.getString("nown"));
				founds.setIsover(rs.getString("isover"));
				founds.setOwnerid(rs.getString("ownerid"));
				founds.setOvertime(rs.getString("overtime"));
				founds.setResulttime(rs.getString("resulttime"));
				founds.setLastid(rs.getString("lastid"));
				founds.setType(rs.getString("type"));
				founds.setTimeid(rs.getString("timeid"));
				founds.setResulttime(rs.getString("resultnumber"));
				foundsList.add(founds);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return foundsList;
	}
	
	public ArrayList<Founds> getFoundsById (String identity){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Founds> foundsList = null;
		connect = createConnect();
		foundsList = new ArrayList<Founds>();
		String sql = "select * from founds where identify ="+identity;
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Founds founds = new Founds();
				founds.setIdentify(rs.getString("identify"));
				founds.setName(rs.getString("name"));
				founds.setImages(rs.getString("images"));
				founds.setTotaln(rs.getString("totaln"));
				founds.setNown(rs.getString("nown"));
				founds.setIsover(rs.getString("isover"));
				founds.setOwnerid(rs.getString("ownerid"));
				founds.setOvertime(rs.getString("overtime"));
				founds.setResulttime(rs.getString("resulttime"));
				founds.setLastid(rs.getString("lastid"));
				founds.setType(rs.getString("type"));
				founds.setTimeid(rs.getString("timeid"));
				founds.setResulttime(rs.getString("resultnumber"));
				foundsList.add(founds);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return foundsList;
	}

/***
 * update founds 
 * @param userModel
 * @return
 */
	public Boolean updateFoundsWithObject(Founds founds) {
		Boolean status = true;
		Connection connect = null;
		String sql = "update founds set name = ?,images = ?,totaln = ? ,nown = ?," +
				"isover = ?,ownerid = ?,overtime = ?,resulttime = ?,lastid = ?,type = ?,timeid = ?," +
				"resultnumber = ? where identify = ?";
		PreparedStatement pstmt = null;
		
		System.out.print(sql);
		connect = createConnect();
		ResultSet rs = null;
		try {
			pstmt = connect.prepareStatement(sql);
			pstmt.setString(1, founds.getName()==null?"":founds.getName());
			pstmt.setString(2, founds.getImages()==null?"":founds.getImages());
			pstmt.setString(3, founds.getTotaln()==null?"":founds.getTotaln());
			pstmt.setString(4, founds.getNown()==null?"":founds.getNown());
			pstmt.setString(5, founds.getIsover()==null?"":founds.getIsover());
			pstmt.setString(6, founds.getOwnerid()==null?"":founds.getOwnerid());
			pstmt.setString(7, founds.getOvertime()==null?"":founds.getOvertime());
			pstmt.setString(8, founds.getResulttime()==null?"":founds.getResulttime());
			pstmt.setString(9, founds.getLastid()==null?"":founds.getLastid());
			pstmt.setString(10, founds.getType()==null?"":founds.getType());
			pstmt.setString(11, founds.getTimeid()==null?"":founds.getTimeid());
			pstmt.setString(12, founds.getResultnumber()==null?"":founds.getResultnumber());
			pstmt.setString(13, founds.getIdentify()==null?"":founds.getIdentify());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			status = false;
			System.out.print(e);
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			releaseConnect(connect, pstmt, rs);
		}
		return status;
	}

	public ArrayList<Historyowner> getHistoryFoundsResultById (String identity,String lastid){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Historyowner> foundsList = null;
		connect = createConnect();
		foundsList = new ArrayList<Historyowner>();
		String sql = "select * from historyowner where foundsid ="+identity + " and timeid ="+lastid;
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Historyowner founds = new Historyowner();
				founds.setIdentify(rs.getString("identify"));
				founds.setFoundsId(rs.getString("foundsId"));
				founds.setName(rs.getString("name"));
				founds.setOwnerBuyNumber(rs.getString("ownerBuyNumber"));
				founds.setImages(rs.getString("images"));
				founds.setTotaln(rs.getString("totaln"));
				founds.setNown(rs.getString("nown"));
				founds.setIsover(rs.getString("isover"));
				founds.setOwnerid(rs.getString("ownerid"));
				founds.setOvertime(rs.getString("overtime"));
				founds.setResulttime(rs.getString("resulttime"));
				founds.setLastid(rs.getString("lastid"));
				founds.setType(rs.getString("type"));
				founds.setResultnumber(rs.getString("resultnumber"));
				founds.setTimeid(rs.getString("timeid"));
				foundsList.add(founds);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return foundsList;
	}	

	public ArrayList<Historyowner> getUserHistoryFoundsResultById (String userId){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Historyowner> foundsList = null;
		connect = createConnect();
		foundsList = new ArrayList<Historyowner>();
		String sql = "select * from historyowner where ownerid ="+userId;
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Historyowner founds = new Historyowner();
				founds.setIdentify(rs.getString("identify"));
				founds.setFoundsId(rs.getString("foundsId"));
				founds.setName(rs.getString("name"));
				founds.setOwnerBuyNumber(rs.getString("ownerBuyNumber"));
				founds.setImages(rs.getString("images"));
				founds.setTotaln(rs.getString("totaln"));
				founds.setNown(rs.getString("nown"));
				founds.setIsover(rs.getString("isover"));
				founds.setOwnerid(rs.getString("ownerid"));
				founds.setOvertime(rs.getString("overtime"));
				founds.setResulttime(rs.getString("resulttime"));
				founds.setLastid(rs.getString("lastid"));
				founds.setType(rs.getString("type"));
				founds.setResultnumber(rs.getString("resultnumber"));
				founds.setTimeid(rs.getString("timeid"));
				foundsList.add(founds);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return foundsList;
	}	
	
	public ArrayList<Historyowner> getHistoryFoundsByTimeIdentify (String identify, String timeIdentify){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Historyowner> foundsList = null;
		connect = createConnect();
		foundsList = new ArrayList<Historyowner>();
		String sql = "select * from historyowner where foundsid = "+identify +" AND " + "timeid = "+timeIdentify;
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Historyowner founds = new Historyowner();
				founds.setIdentify(rs.getString("identify"));
				founds.setFoundsId(rs.getString("foundsId"));
				founds.setName(rs.getString("name"));
				founds.setOwnerBuyNumber(rs.getString("ownerBuyNumber"));
				founds.setImages(rs.getString("images"));
				founds.setTotaln(rs.getString("totaln"));
				founds.setNown(rs.getString("nown"));
				founds.setIsover(rs.getString("isover"));
				founds.setOwnerid(rs.getString("ownerid"));
				founds.setOvertime(rs.getString("overtime"));
				founds.setResulttime(rs.getString("resulttime"));
				founds.setLastid(rs.getString("lastid"));
				founds.setType(rs.getString("type"));
				founds.setResultnumber(rs.getString("resultnumber"));
				founds.setTimeid(rs.getString("timeid"));
				foundsList.add(founds);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return foundsList;
	}	
	
	public ArrayList<User> getOwnerInfoById (String identity){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<User> foundsList = null;
		connect = createConnect();
		foundsList = new ArrayList<User>();
		String sql = "select * from user where identify ="+identity;
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				User user = new User();
				user.setIdentify(rs.getString("identify"));
				user.setName(rs.getString("name"));
				user.setIcon(rs.getString("icon"));
				user.setAddress(rs.getString("address"));
				user.setAccount(rs.getString("account"));
				user.setDate(rs.getString("date"));
				user.setPhone(rs.getString("phone"));
				foundsList.add(user);
			}
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return foundsList;
	}
	
/**通过商品id查询该商品所有历史中奖结果*/
	public ArrayList<Historyowner> getHistoryResultByFoundsId (String identity){
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Historyowner> foundsList = null;
		connect = createConnect();
		foundsList = new ArrayList<Historyowner>();
		String sql = "select * from historyowner where foundsId ="+identity;
		System.out.println(sql);
		try {
			pstmt = connect.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Historyowner founds = new Historyowner();
				founds.setIdentify(rs.getString("identify"));
				founds.setFoundsId(rs.getString("foundsId"));
				founds.setName(rs.getString("name"));
				founds.setOwnerBuyNumber(rs.getString("ownerBuyNumber"));
				founds.setImages(rs.getString("images"));
				founds.setTotaln(rs.getString("totaln"));
				founds.setNown(rs.getString("nown"));
				founds.setIsover(rs.getString("isover"));
				founds.setOwnerid(rs.getString("ownerid"));
				founds.setOvertime(rs.getString("overtime"));
				founds.setResulttime(rs.getString("resulttime"));
				founds.setLastid(rs.getString("lastid"));
				founds.setType(rs.getString("type"));
				founds.setResultnumber(rs.getString("resultnumber"));
				founds.setTimeid(rs.getString("timeid"));
				foundsList.add(founds);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return foundsList;
	}	

	public void insertHistoryOwnerObject(Historyowner historyOwner) {
		Connection connect = null;
		
		String sql = "INSERT INTO historyowner(identify,foundsId,name,ownerBuyNumber,images,totaln,nown,isover,ownerid,overtime,resulttime," +
				"lastid,type,resultnumber,timeid) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement pstmt = null;
		System.out.print(sql);
		connect = createConnect();
		ResultSet rs = null;
		try {				
				pstmt =	connect.prepareStatement(sql);
				pstmt.setString(1, historyOwner.getIdentify());
				pstmt.setString(2, historyOwner.getFoundsId());
				pstmt.setString(3, historyOwner.getName());
				pstmt.setString(4, historyOwner.getOwnerBuyNumber());
				pstmt.setString(5, historyOwner.getImages());
				pstmt.setString(6, historyOwner.getTotaln());
				pstmt.setString(7, historyOwner.getNown());
				pstmt.setString(8, historyOwner.getIsover());
				pstmt.setString(9, historyOwner.getOwnerid());
				pstmt.setString(10, historyOwner.getOvertime());
				pstmt.setString(11, historyOwner.getResulttime());
				pstmt.setString(12, historyOwner.getLastid());
				pstmt.setString(13, historyOwner.getType());
				pstmt.setString(14, historyOwner.getResultnumber());
				pstmt.setString(15, historyOwner.getTimeid());
				pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.print(e);
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			releaseConnect(connect, pstmt, rs);
			
		}
	}

}
