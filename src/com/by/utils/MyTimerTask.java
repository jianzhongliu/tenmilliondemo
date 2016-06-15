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
import java.sql.Date;
import java.util.ArrayList;
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

import com.by.dao.FoundsManager;
import com.by.dao.OrderCenterManager;
import com.by.dao.UserCenterManager;
import com.by.model.Founds;
import com.by.model.Historyowner;
import com.by.model.Recode;
import com.by.model.User;

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
	String buyNumber = "5";
	String date = "" + System.currentTimeMillis(); 
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
			if (recordes.size() > 0) {
				Recode recode = recordes.get(0);
				String ownerId = recode.getUserid();//result owner id
				UserCenterManager userCenter = new UserCenterManager();
				ArrayList<User> usersList = userCenter.getUserInfoByUserId(ownerId);
				if (usersList.size() > 0) {
					User user = usersList.get(0);
					if (user.getType() == "1") {
						break;
					}
				}
			}
			if (i>10) {
				break;
			}
		}
		/**check record info*/
		String ownerId="";
		ArrayList<Recode> recordes = orderCenter.createNewOwner(foundsId, ""+Num, founds.getTimeid());
		if (recordes.size() > 0) {
			Recode recode = recordes.get(0);
			ownerId = recode.getUserid();//result owner id
		}

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
}


}

