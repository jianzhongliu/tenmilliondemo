package com.by.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.by.factory.ConnectionFactory;
import com.by.model.User;

public class UserCenterManager extends ConnectionFactory {
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
	}
	public void insertUserObject(User userModel) {
		Connection connect = null;
		String sql = "INSERT INTO user(identify,name,icon,address,account,date,type,phone) VALUES (?,?,?,?,?,?,?,?)";
		PreparedStatement pstmt = null;
		System.out.print(sql);
		connect = createConnect();
		ResultSet rs = null;
		try {				
				pstmt =	connect.prepareStatement(sql);
				pstmt.setString(1, userModel.getIdentify());
				pstmt.setString(2, userModel.getName());
				pstmt.setString(3, userModel.getIcon());
				pstmt.setString(4, userModel.getAddress());
				pstmt.setString(5, userModel.getAccount());
				pstmt.setString(6, userModel.getDate());
				pstmt.setString(7, userModel.getType());
				pstmt.setString(8, userModel.getPhone());
				pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.print(e);
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			releaseConnect(connect, pstmt, rs);
			
		}
	}
	
	public Boolean updateUserWithObject(User userModel) {
		Boolean status = true;
		Connection connect = null;//identify,name,icon,address,account,date,phone
		String sql = "update user set name = ?,icon = ?,address = ?," +
				"date = ?,phone = ? where identify = ?";
		PreparedStatement pstmt = null;
		System.out.print(sql);
		connect = createConnect();
		ResultSet rs = null;
		try {
			pstmt = connect.prepareStatement(sql);
			pstmt.setString(1, userModel.getName());
			pstmt.setString(2, userModel.getIcon());
			pstmt.setString(3, userModel.getAddress());
//			pstmt.setString(4, userModel.getAccount());
			pstmt.setString(4, userModel.getDate());
			pstmt.setString(5, userModel.getPhone());
			pstmt.setString(6, userModel.getIdentify());
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
	
	public ArrayList<User> getUserInfoByUserId (String userId) {
		Connection connect = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<User> userList = null;
		connect = createConnect();
		userList = new ArrayList<User>();
		String sql = "select * from user where identify = '"+userId+"'";
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
				user.setType(rs.getString("type"));
				userList.add(user);
			}		
		} catch (Exception e) {
			System.out.println("Erro ao listar todos os anser: " + e);
			e.printStackTrace();
		} finally {
			releaseConnect(connect, pstmt, rs);
		}
		return userList;
	}	
}
