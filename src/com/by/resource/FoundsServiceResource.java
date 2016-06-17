package com.by.resource;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.UriInfo;

import com.by.dao.FoundsManager;
import com.by.dao.UserCenterManager;
import com.by.model.Founds;
import com.by.model.Historyowner;
import com.by.model.HistoryownerListModel;
import com.by.model.User;
import com.by.response.FoundsDetailResponseModel;
import com.by.response.FoundsHistoryResultResponseModel;
import com.by.response.HomeResponseModel;
import com.by.utils.MD5Util;
import com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;

@Path("/founds")
public class FoundsServiceResource {
	@Context
	UriInfo uriInfo;
	
	@Context
	Request request;
	
	@GET
	@Path("/getHomeFounds")
	@Produces("application/json")
	public HomeResponseModel getHomeFounds(@Context UriInfo info)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, UnsupportedEncodingException {
		HomeResponseModel resp = new HomeResponseModel();
		String date = info.getQueryParameters().getFirst("timestamp");
		String sign = info.getQueryParameters().getFirst("signature");
		String type = info.getQueryParameters().getFirst("type");
		String index = info.getQueryParameters().getFirst("index");
		String limit = info.getQueryParameters().getFirst("limit");
		System.out.println("out======="+ sign+"=="+date+"==="+MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"));
		if (sign.equals(MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"))){
			StringBuffer errorMSG = new StringBuffer();
			errorMSG.append("ok");
//			String   companyNmae = java.net.URLDecoder.decode(name,"utf-8");
			FoundsManager foundsManager = new FoundsManager();
			//over founds list
			ArrayList<Founds> overArray = foundsManager.getAllFounds(type,Integer.valueOf(index), Integer.valueOf(limit));			
			resp.setOverArray(overArray);
			//activity founds list
//			ArrayList<Founds> activityArray = foundsManager.getAllFounds("2");
//			resp.setActivityArray(activityArray);
//			//hot founds list
			ArrayList<Founds> hotArray = foundsManager.getAllFounds("5",1,10);
			resp.setHotArray(hotArray);
//			//all founds list
//			ArrayList<Founds> allArray = foundsManager.getAllFounds("0");
//			resp.setAllArray(allArray);
			
			resp.setErrorMSG(errorMSG);
			return resp;
		}else {
			return resp;
		}
	}
	
	
	@GET
	@Path("/getTypeFounds")
	@Produces("application/json")
	public HomeResponseModel getTypeFounds(@Context UriInfo info)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, UnsupportedEncodingException {
		HomeResponseModel resp = new HomeResponseModel();
		String date = info.getQueryParameters().getFirst("timestamp");
		String sign = info.getQueryParameters().getFirst("signature");
		String category = info.getQueryParameters().getFirst("category");
		String index = info.getQueryParameters().getFirst("index");
		String limit = info.getQueryParameters().getFirst("limit");
		System.out.println("out======="+ sign+"=="+date+"==="+MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"));
		if (sign.equals(MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"))){
			StringBuffer errorMSG = new StringBuffer();
			errorMSG.append("ok");
//			String   companyNmae = java.net.URLDecoder.decode(name,"utf-8");
			FoundsManager foundsManager = new FoundsManager();
			//over founds list
			ArrayList<Founds> overArray = foundsManager.getAllFoundsByType(category,Integer.valueOf(index), Integer.valueOf(limit));			
			resp.setOverArray(overArray);
			//activity founds list
//			ArrayList<Founds> activityArray = foundsManager.getAllFounds("2");
//			resp.setActivityArray(activityArray);
//			//hot founds list
//			ArrayList<Founds> hotArray = foundsManager.getAllFounds("3");
//			resp.setHotArray(hotArray);
//			//all founds list
//			ArrayList<Founds> allArray = foundsManager.getAllFounds("0");
//			resp.setAllArray(allArray);
			
			resp.setErrorMSG(errorMSG);
			return resp;
		}else {
			return resp;
		}
	}
	
	@GET  /**获取商品详情*/
	@Path("/getFoundsDetail")
	@Produces("application/json")
	public FoundsDetailResponseModel getFoundsDetail(@Context UriInfo info)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, UnsupportedEncodingException {
		FoundsDetailResponseModel resp = new FoundsDetailResponseModel();
		String foundsId = info.getQueryParameters().getFirst("foundsId");
		String date = info.getQueryParameters().getFirst("timestamp");
		String sign = info.getQueryParameters().getFirst("signature");
		System.out.println("out======="+ sign+"=="+date+"==="+MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"));
		if (sign.equals(MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"))){
			StringBuffer errorMSG = new StringBuffer();
			errorMSG.append("ok");
//			String   companyNmae = java.net.URLDecoder.decode(name,"utf-8");
			FoundsManager foundsManager = new FoundsManager();
			ArrayList<Founds> founds = foundsManager.getFoundsById(foundsId);
			Founds foundsInfo = founds.get(0);
			resp.setFoundsDetail(foundsInfo);

			ArrayList<Historyowner> history = foundsManager.getHistoryFoundsResultById(foundsInfo.getIdentify(), foundsInfo.getLastid());
			if (history.size() > 0) {
				Historyowner historyOwner = history.get(0);
				ArrayList<User> userInfo = foundsManager.getOwnerInfoById(historyOwner.getOwnerid());
				resp.setHistoryOwner(history.get(0));
				if (userInfo.size()>0) {
					resp.setUserInfo(userInfo.get(0));				
				}
			}
			resp.setErrorMSG(errorMSG);
			return resp;
		}else {
			return resp;
		}
	}

	@GET  /**往期揭晓*/
	@Path("/getHistoryFoundsDetail")
	@Produces("application/json")
	public FoundsDetailResponseModel getHistoryFoundsDetail(@Context UriInfo info)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, UnsupportedEncodingException {
		FoundsDetailResponseModel resp = new FoundsDetailResponseModel();
		String foundsId = info.getQueryParameters().getFirst("foundsId");
		String date = info.getQueryParameters().getFirst("timestamp");
		String sign = info.getQueryParameters().getFirst("signature");
		System.out.println("out======="+ sign+"=="+date+"==="+MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"));
		if (sign.equals(MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"))){
			StringBuffer errorMSG = new StringBuffer();
			errorMSG.append("ok");
//			String   companyNmae = java.net.URLDecoder.decode(name,"utf-8");
			FoundsManager foundsManager = new FoundsManager();
			ArrayList<Founds> founds = foundsManager.getFoundsById(foundsId);
			Founds foundsInfo = founds.get(0);
//			System.out.println("请求商品："+foundsInfo);
			ArrayList<Historyowner> history = foundsManager.getHistoryFoundsResultById(foundsInfo.getIdentify(), foundsInfo.getLastid());
			Historyowner historyOwner = history.get(0);
			ArrayList<User> userInfo = foundsManager.getOwnerInfoById(historyOwner.getOwnerid());
			
			resp.setFoundsDetail(foundsInfo);
			resp.setHistoryOwner(history.get(0));
			resp.setUserInfo(userInfo.get(0));
			
			resp.setErrorMSG(errorMSG);
			return resp;
		}else {
			return resp;
		}
	}

	@GET  /**往期揭晓列表*/
	@Path("/getHistoryFoundsResultList")
	@Produces("application/json")
	public FoundsHistoryResultResponseModel getHistoryFoundsResultList(@Context UriInfo info)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, UnsupportedEncodingException {
		FoundsHistoryResultResponseModel resp = new FoundsHistoryResultResponseModel();
		String foundsId = info.getQueryParameters().getFirst("foundsId");
		String date = info.getQueryParameters().getFirst("timestamp");
		String sign = info.getQueryParameters().getFirst("signature");
		String index = info.getQueryParameters().getFirst("index");
		String limit = info.getQueryParameters().getFirst("limit");
		System.out.println("out======="+ sign+"=="+date+"==="+MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"));
		if (sign.equals(MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"))){
			StringBuffer errorMSG = new StringBuffer();
			errorMSG.append("ok");
//			String   companyNmae = java.net.URLDecoder.decode(name,"utf-8");
			FoundsManager foundsManager = new FoundsManager();
			ArrayList<HistoryownerListModel> historyownerListModels = new ArrayList<HistoryownerListModel>();

			ArrayList<Historyowner> historyFounds = foundsManager.getHistoryResultByFoundsId(foundsId,Integer.valueOf(index), Integer.valueOf(limit));
//			UserCenterManager userCenterManager = new UserCenterManager();
//			for (int i = 0; i < historyFounds.size(); i++) {
//				HistoryownerListModel historyModel = new HistoryownerListModel();
//				Historyowner foundsHistoryowner = historyFounds.get(i);
//				historyModel.setHistoryOwnerFounds(foundsHistoryowner);
//				ArrayList<User> userInfo = userCenterManager.getUserInfoByUserId(foundsHistoryowner.getOwnerid());
//				historyModel.setHistoryOwnerUser(userInfo.get(0));
//				historyownerListModels.add(historyModel);
//			}
			
			resp.setHistoryOwnerFounds(historyFounds);
			resp.setErrorMSG(errorMSG);
			return resp;
		}else {
			return resp;
		}
	}
}
