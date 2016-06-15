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

import com.by.dao.UserCenterManager;
import com.by.model.User;
import com.by.response.UserInfoResponseModel;
import com.by.utils.MD5Util;

@Path("/userCenter")
public class UserInfoServiceResource {
	@Context
	UriInfo uriInfo;
	
	@Context
	Request request;
	
	@GET
	@Path("/dologin")
	@Produces("application/json")
	public UserInfoResponseModel dologin(@Context UriInfo info)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, UnsupportedEncodingException {
		UserInfoResponseModel resp = new UserInfoResponseModel();
		String userName = info.getQueryParameters().getFirst("userId");
		String date = info.getQueryParameters().getFirst("timestamp");
		String sign = info.getQueryParameters().getFirst("signature");
		System.out.println("out======="+ sign+"=="+date+"==="+MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"));
		if (sign.equals(MD5Util.MD5(date + "psmtoiyrpyqofhfo7atdofdby4eqc02p"))){
			StringBuffer errorMSG = new StringBuffer();
			errorMSG.append("ok");
			String   userNameString = java.net.URLDecoder.decode(userName,"utf-8");
			UserCenterManager userCenter = new UserCenterManager();
			ArrayList<User> users = userCenter.getUserInfoByUserId(userNameString);
			if (users.size() > 0) {
				resp.setUserInfo(users.get(0));
			} else {
				User userNew = new User();
				userNew.setIdentify(userName);
				userNew.setAccount("20");
				userNew.setName(userName);
				userNew.setDate(date);
				userNew.setPhone(userName);
				userNew.setIcon("");
				userCenter.insertUserObject(userNew);
				ArrayList<User> userInfo = userCenter.getUserInfoByUserId(userNameString);
				resp.setUserInfo(userInfo.get(0));
			}
			resp.setErrorCode(0);
			resp.setErrorMSG(errorMSG);
			return resp;
		}else {
			return resp;
		}
	}

	@GET
	@Path("/updateUserInfo")
	@Produces("application/json")
	public UserInfoResponseModel updateUserInfo(@Context UriInfo info)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, UnsupportedEncodingException {
		UserInfoResponseModel resp = new UserInfoResponseModel();
		String userId = info.getQueryParameters().getFirst("userId");
		String name = info.getQueryParameters().getFirst("name");
		String icon = info.getQueryParameters().getFirst("icon");
		String address = info.getQueryParameters().getFirst("address");
		String date = info.getQueryParameters().getFirst("date");
		String timestamp = info.getQueryParameters().getFirst("timestamp");
		String phone = info.getQueryParameters().getFirst("phone");
		String sign = info.getQueryParameters().getFirst("signature");
		System.out.println("out======="+ sign+"=="+timestamp+"==="+MD5Util.MD5(timestamp + "psmtoiyrpyqofhfo7atdofdby4eqc02p"));
		if (sign.equals(MD5Util.MD5(timestamp + "psmtoiyrpyqofhfo7atdofdby4eqc02p"))){
			StringBuffer errorMSG = new StringBuffer();
			errorMSG.append("ok");
//			String   userNameString = java.net.URLDecoder.decode(userName,"utf-8");
			UserCenterManager userCenter = new UserCenterManager();
			User user = new User();
			user.setIdentify(userId);
			user.setName(name);
			user.setIcon(icon);
			user.setAddress(address);
			user.setDate(date);
			user.setPhone(phone);
			boolean result = userCenter.updateUserWithObject(user);
			if (result == true) {
				resp.setErrorCode(0);
			}else {
				resp.setErrorCode(1);
			}
			ArrayList<User> users = userCenter.getUserInfoByUserId(userId);
			resp.setUserInfo(users.get(0));
			resp.setErrorMSG(errorMSG);
			return resp;
		}else {
			return resp;
		}
	}
}
