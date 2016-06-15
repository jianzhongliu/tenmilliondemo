package com.by.factory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


/**
 * 
 * @author liujianzhong
 *
 */
public class ConnectionFactory {

	// Caminho do banco de dados.
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://swweaper5.mysql.rds.aliyuncs.com:3306/yungou";
	private static final String USUARIO = "swweaper5";
	private static final String SENHA = "a051226";
	

	/**
	 * 
	 * @return
	 */
	public Connection createConnect(){

		Connection conexao = null;
		try {
			
			Class.forName(DRIVER);
			conexao = DriverManager.getConnection(URL, USUARIO, SENHA);
			
		} catch (Exception e) {
			System.out.println("Erro: " + URL);
			e.printStackTrace();
		}
		return conexao;
	}
	
	/**
	 * 
	 * @param conexao
	 * @param pstmt
	 * @param rs
	 */
	public void releaseConnect(Connection conexao, PreparedStatement pstmt, ResultSet rs){
		
		try {
			
			if(conexao != null){
				conexao.close();
			}
			if(pstmt != null){
				pstmt.close();
			}
			if(rs != null){
				rs.close();
			}
					
		} catch (Exception e) {
			System.out.println("Erro: " + URL);
		}
	}
}

