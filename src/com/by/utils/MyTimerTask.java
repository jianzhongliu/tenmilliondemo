package com.by.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.TimerTask;
import javax.mail.Address;
import javax.mail.AuthenticationFailedException;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import sample.RecordImpl;

import com.by.dao.FoundsManager;
import com.by.dao.OrderCenterManager;
import com.by.dao.UserCenterManager;
import com.by.model.Founds;
import com.by.model.Historyowner;
import com.by.model.Recode;
import com.by.model.User;
import com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;

public class MyTimerTask extends TimerTask {

	@Override
public void run() {
	while (true){
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("startSendEmail");
		if (!MyTimerTask.payFounds()){
			MyTimerTask.swatchMail();
		}
	}
//		MyTimerTask.startSendMailSina();
}
public static void swatchMail() {
	System.out.println("switchEmail");
	MyTimerTask.payFounds();
}

public synchronized static Boolean payFounds(){
			String emailStr = "";
			List<String> emailList=new ArrayList<String>();
			String filePath = "";
			try {
				filePath = MyTimerTask.loaderFindFile("2002.txt");
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (URISyntaxException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			emailList = MyTimerTask.getEmailFromResultFile(filePath);
			FoundsManager foundsManager = new FoundsManager();
			ArrayList<Founds> allFounds = foundsManager.getAllFoundsFromDB();
			
			int i = 0;
			while (i<emailList.size()){
					emailStr = emailList.get(i);
//					UserCenterManager userManager = new UserCenterManager();
//					User userModel = new User();
//					userModel.setIdentify(emailStr);
//					userModel.setName(emailStr.split("@")[0]);
//					userModel.setPhone(emailStr);
//					userModel.setType("1");
//					userModel.setAccount("100000");
//					userManager.insertUserObject(userModel);

					for (int j = 0; j < allFounds.size(); j++) {
						Founds founds = new Founds();
						founds = allFounds.get(j);
						MyTimerTask.payFoundsSystem(founds.getIdentify(), emailStr);
					}					
				i ++;
				if (i>7045) {
					i=0;
				}
			}
			System.out.println("==="+emailStr+"===");
			return true;
		}

private static String loaderFindFile(String relativePath) throws IOException, URISyntaxException {
	ClassLoader loader = MyTimerTask.class.getClassLoader();
	URL u = loader.getResource(relativePath);
	File file = new File(u.getPath());
	System.out.println(u.getPath());
	return u.getPath();
}

public synchronized static List<String> getEmailFromResultFile(String filepath) {
	File file = new File(filepath); 
    List<String> emailList=new ArrayList<String>();
	if(file.exists()){  
		System.out.println("file exist");
        if(file.isFile()){  
        	System.out.println("path is file");
            try{  
                BufferedReader input = new BufferedReader (new FileReader(file));  
                String text; 
                int i=0;
                while((text = input.readLine()) != null) {
                	if (text.length() > 0) {
                    	emailList.add(text);						
					}
                	i ++;
                }
            	System.out.println(text+"==="+i);

            }
            catch(IOException ioException){  
                System.out.println("File Error!");  
            }  
        }  
    }
	return emailList;
}

public static void payFoundsSystem(String foundsId,String userId) {
	String buyNumber = "" + new Random().nextInt(10);
	String date = "" + new Date().getTime();
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:sss");  
    date = sdf.format(new Date().getTime());
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

	orderCenter.insertUserObject(foundsId, userId, numberString,buyNumber,founds.getTimeid(), "1",date);
	/**更新商品当前进度*/
	int foundsNown = Integer.valueOf(founds.getNown()) + Integer.valueOf(buyNumber);
	founds.setNown(""+foundsNown);
	/**判断是否结束，若结束，则进入活动结束的处理*/
	if (Integer.parseInt(founds.getTotaln()) <= foundsNown) {
		// new owner created
		User user = new User();
		Recode recordResult = new Recode();//抽中的record
		ArrayList<Recode> recordes = orderCenter.createNewOwner(foundsId, "0", founds.getTimeid());
		String recordStringTotal = "";
		for (int i = 0; i < recordes.size(); i++) {
			Recode recordItem = recordes.get(i);
			recordStringTotal = recordStringTotal + recordItem.getNumber();
		}
		String[] arrayRecordItem = recordStringTotal.split(",");
		int Num=new Random().nextInt(arrayRecordItem.length)+1 + 10000000;
		
		for (int i = 0; i < recordes.size(); i++) {
			Recode recordItem = recordes.get(i);
			if (recordItem.getNumber().indexOf(""+Num) > 0) {
				recordResult = recordItem;
			}
		}
		UserCenterManager userCenter = new UserCenterManager();
		ArrayList<User> usersList = userCenter.getUserInfoByUserId(recordResult.getUserid());
		if (usersList.size() > 0) {
			user = usersList.get(0);
		}

		/**owner buy this founds history list*/
		ArrayList<Recode> recordList = orderCenter.caculateOwnerBuyNumber(foundsId, userId, founds.getTimeid());
		int buyNumberRecordTotal = 0;
		if (recordList.size() > 0) {
			for (int i = 0; i < recordList.size(); i++) {
				Recode recordItems = recordList.get(i);
				buyNumberRecordTotal = buyNumberRecordTotal + Integer.valueOf(recordItems.getBuyNumber());
			}
		}
		//new history founds
		Historyowner historyModel = new Historyowner();
		historyModel.setIdentify(date);
		historyModel.setFoundsId(founds.getIdentify());
		historyModel.setName(founds.getName());
		historyModel.setOwnerBuyNumber(""+buyNumberRecordTotal);
		historyModel.setImages(founds.getImages());
		historyModel.setTotaln(founds.getTotaln());
		historyModel.setNown(founds.getNown());
		historyModel.setIsover("1");
		historyModel.setOwnerid(user.getIdentify());
		historyModel.setOvertime(date);
		historyModel.setResulttime(date);
		historyModel.setLastid(founds.getLastid());
		historyModel.setType(founds.getType());
		historyModel.setResultnumber(""+Num);
		historyModel.setTimeid(founds.getTimeid());
		historyModel.setUsericon(user.getIcon());
		historyModel.setUsername(user.getName());
		foundsmanager.insertHistoryOwnerObject(historyModel);
		
		/**new founds nown begin from 0 to 1000*/
		founds.setIsover("0");
		founds.setNown("0");
		founds.setLastid(founds.getTimeid());
		int newTimeId = Integer.parseInt(founds.getTimeid()) + 1;
		founds.setTimeid(""+newTimeId);
		founds.setResultnumber(""+Num);
	}
	foundsmanager.updateFoundsWithObject(founds);
}

}

