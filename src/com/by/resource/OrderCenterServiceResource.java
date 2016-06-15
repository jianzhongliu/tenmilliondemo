package com.by.resource;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.UriInfo;

import com.by.dao.FoundsManager;
import com.by.dao.OrderCenterManager;
import com.by.dao.UserCenterManager;
import com.by.model.Founds;
import com.by.model.Historyowner;
import com.by.model.Recode;
import com.by.model.User;
import com.by.model.UserRecordListModel;
import com.by.response.HomeResponseModel;
import com.by.response.UserHistoryRecordResponseModel;
import com.by.utils.MD5Util;

@Path("/orderCenter")
public class OrderCenterServiceResource {
	@Context
	UriInfo uriInfo;
	
	@Context
	Request request;
	
	@GET
	@Path("/payOrder")
	@Produces("application/json")
	public HomeResponseModel payOrder(@Context UriInfo info)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, UnsupportedEncodingException {
		HomeResponseModel resp = new HomeResponseModel();
		String foundsId = info.getQueryParameters().getFirst("foundsId");
		String userId = info.getQueryParameters().getFirst("userId");
		String buyNumber = info.getQueryParameters().getFirst("buyNumber");
		String date = info.getQueryParameters().getFirst("timestamp");
		String sign = info.getQueryParameters().getFirst("signature");
		System.out.println("out======="+ sign+"=="+date+"==="+MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"));
		if (sign.equals(MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"))){
			StringBuffer errorMSG = new StringBuffer();
			errorMSG.append("ok");
			resp.setStatus("OK");
			FoundsManager foundsmanager = new FoundsManager();
			Founds founds = foundsmanager.getFoundsById(foundsId).get(0);
			OrderCenterManager orderCenter = new OrderCenterManager();
			/**插入购买记录*/
			String numberString="";
			for (int i = 1; i < Integer.valueOf(buyNumber).intValue() + 1; i++) {
				int newNumber = 10000000 + Integer.valueOf(founds.getNown()) + i ;
				System.out.println("current buynumber of founds============"+ newNumber);
				 numberString = numberString + newNumber + ",";
			}

			orderCenter.insertUserObject(foundsId, userId, numberString,buyNumber,founds.getTimeid(), "1");
			/**更新商品当前进度*/
			int foundsNown = Integer.valueOf(founds.getNown()) + Integer.valueOf(buyNumber);
			founds.setNown(""+foundsNown);
			foundsmanager.updateFoundsWithObject(founds);
			/**判断是否结束，若结束，则进入活动结束的处理*/
			if (Integer.parseInt(founds.getTotaln()) <= foundsNown) {
				// new owner created
				int Num=new Random().nextInt(Integer.parseInt(founds.getNown()))+1 + 10000000;
				for (int i = 0; i < 1000000; i++) {
					Num=new Random().nextInt(Integer.parseInt(founds.getNown()))+1 + 10000000;
					ArrayList<Recode> recordes = orderCenter.createNewOwner(foundsId, ""+Num, founds.getTimeid());
					Recode recode = recordes.get(0);
					String ownerId = recode.getUserid();//result owner id
					UserCenterManager userCenter = new UserCenterManager();
					ArrayList<User> usersList = userCenter.getUserInfoByUserId(ownerId);
					User user = usersList.get(0);
					if (user.getType() == "1") {
						break;
					}
				}
				/**check record info*/
				ArrayList<Recode> recordes = orderCenter.createNewOwner(foundsId, ""+Num, founds.getTimeid());
				Recode recode = recordes.get(0);
				String ownerId = recode.getUserid();//result owner id
				/**owner buy this founds history list*/
				ArrayList<Recode> recordList = orderCenter.caculateOwnerBuyNumber(foundsId, userId, founds.getTimeid());

				//new history founds
				Historyowner historyModel = new Historyowner();
				historyModel.setIdentify(date);
				historyModel.setFoundsId(founds.getIdentify());
				historyModel.setName(founds.getName());
				historyModel.setOwnerBuyNumber(""+recordList.size());
				historyModel.setImages(founds.getImages());
				historyModel.setTotaln(founds.getTotaln());
				historyModel.setNown(founds.getNown());
				historyModel.setIsover("1");
				historyModel.setOwnerid(ownerId);
				historyModel.setOvertime(date);
				historyModel.setResulttime(date);
				historyModel.setLastid(founds.getLastid());
				historyModel.setType(founds.getType());
				historyModel.setResultnumber(""+Num);
				historyModel.setTimeid(founds.getTimeid());
				foundsmanager.insertHistoryOwnerObject(historyModel);
				
				/**new founds nown begin from 0 to 1000*/
				founds.setIsover("0");
				founds.setNown("0");
				founds.setLastid(founds.getTimeid());
				int newTimeId = Integer.parseInt(founds.getTimeid()) + 1;
				founds.setTimeid(""+newTimeId);
				founds.setResultnumber(""+Num);
				foundsmanager.updateFoundsWithObject(founds);			
			}
			resp.setErrorCode(0);
			resp.setErrorMSG(errorMSG);
			return resp;
		}else {
			return resp;
		}
	}

	@GET
	@Path("/getUserRecordList")//购买历史
	@Produces("application/json")
	public UserHistoryRecordResponseModel getUserRecordList(@Context UriInfo info)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, UnsupportedEncodingException {
		UserHistoryRecordResponseModel resp = new UserHistoryRecordResponseModel();
		String userId = info.getQueryParameters().getFirst("userId");
		String date = info.getQueryParameters().getFirst("timestamp");
		String sign = info.getQueryParameters().getFirst("signature");
		System.out.println("out======="+ sign+"=="+date+"==="+MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"));
		if (sign.equals(MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"))){
			StringBuffer errorMSG = new StringBuffer();
			errorMSG.append("ok");
			resp.setStatus("OK");
			ArrayList<UserRecordListModel> recordHistoryList = new ArrayList<UserRecordListModel>();
			FoundsManager foundsmanager = new FoundsManager();
			
			OrderCenterManager orderCenter = new OrderCenterManager();
			ArrayList<Recode> recordList = orderCenter.getUserRecordList(userId);
			for (int i = 0; i < recordList.size(); i++) {
				UserRecordListModel recordModel = new UserRecordListModel();
				Recode recordRecode = recordList.get(i);
				Founds founds = foundsmanager.getFoundsById(recordRecode.getFoundsid()).get(0);
				
				Date dateTime = new Date();  
		        long times = dateTime.getTime(); 
				recordModel.setIdentify(times+"");
				recordModel.setName(founds.getName());
				recordModel.setFoundsId(founds.getIdentify());
				recordModel.setImages(founds.getImages());
				recordModel.setNumberString(recordRecode.getNumber());
				recordModel.setTime(recordRecode.getTime());
				recordModel.setTimeid(recordRecode.getTimeid());
				recordModel.setOwnerId(recordRecode.getUserid());
				recordHistoryList.add(recordModel);
			}
			resp.setRecordList(recordHistoryList);
			resp.setErrorCode(0);
			resp.setErrorMSG(errorMSG);
			return resp;
		}else {
			return resp;
		}
	}
	
	@GET
	@Path("/getUserOwnerFoundsList")//owner history list
	@Produces("application/json")
	public UserHistoryRecordResponseModel getUserOwnerFoundsList(@Context UriInfo info)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, UnsupportedEncodingException {
		UserHistoryRecordResponseModel resp = new UserHistoryRecordResponseModel();
		String userId = info.getQueryParameters().getFirst("userId");
		String date = info.getQueryParameters().getFirst("timestamp");
		String sign = info.getQueryParameters().getFirst("signature");
		System.out.println("out======="+ sign+"=="+date+"==="+MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"));
		if (sign.equals(MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"))){
			StringBuffer errorMSG = new StringBuffer();
			errorMSG.append("ok");
			resp.setStatus("OK");
			FoundsManager orderManager = new FoundsManager();
			ArrayList<Historyowner> userHistoryowners = orderManager.getUserHistoryFoundsResultById(userId);
			resp.setOwnerRecordList(userHistoryowners);
			resp.setErrorCode(0);
			resp.setErrorMSG(errorMSG);
			return resp;
		}else {
			return resp;
		}
	}
	
}
