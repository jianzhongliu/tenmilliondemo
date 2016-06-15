package com.by.resource;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.UriInfo;

import com.by.dao.FoundsManager;
import com.by.response.UserInfoResponseModel;
import com.by.utils.TestTimer;


@Path("/util")
public class UtilsServiceResource {
	@Context
	UriInfo uriInfo;
	
	@Context
	Request request;
	
	@GET
	@Path("/startThread")
	@Produces("application/json")
	public UserInfoResponseModel startThread(@Context UriInfo info)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, UnsupportedEncodingException {
		UserInfoResponseModel resp = new UserInfoResponseModel();
		resp.setErrorCode(0);
		FoundsManager timer = new FoundsManager();
		 timer.startTimer();
		System.out.println("开启线程");
		return resp;
	}
}
