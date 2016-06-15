package com.by.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Timer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

import com.by.factory.ConnectionFactory;
import com.by.model.Founds;


public class TestTimer extends ConnectionFactory {

	/**
	 * @param args
	 * @throws IOException 
	 */
public static void main(String[] args) throws IOException {
//	TestTimer.startSendMailSina();
	System.out.println(System.getProperty("user.dir")); 
	
	TestTimer.startTimer();
//	while(true){
//		TestTimer.startSendMailSina();
//		try {
//			Thread.sleep(300000);
//		} catch (InterruptedException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}

//	TestTimer.readFile("resource\\20001.txt");
//	List<String> emailList=new ArrayList<String>();
//	emailList = TestTimer.getEmailFromResultFile("resource\\20001.txt");
//	 Iterator<String> itr = emailList.iterator();
//	 int i = 0;
//     while (itr.hasNext()) {
//         String nextObj = itr.next().toString()  + "\r\n";
//         System.out.println("����һ��email��"+nextObj);	
//         i ++;
//         FileOutputStream out = null;      
//         try {
//             out = new FileOutputStream(new File("D:/2002.txt"), true);   
//             SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//�������ڸ�ʽ
//             System.out.println(df.format(new Date()));// new Date()Ϊ��ȡ��ǰϵͳʱ��
////             logStr = df.format(new Date()) + "����״̬:" + logStr + "\r\n";
////             logStr = df.format(new Date()) + "����״̬:" + logStr + "\r\n";
//             out.write(nextObj.getBytes());
//             out.close();
//         } catch (Exception e) {
//             e.printStackTrace();
//         }
//         finally {   
//             try {   
//                 out.close();   
//             } catch (Exception e) {   
//                 e.printStackTrace();
//             }   
//
//         }   
//
//     }
//     System.out.println("����һ��email��" + i);
}
	
public static String startTimer() {
//	while (true){
        try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        Timer timer = new Timer();
        timer.schedule(new MyTimerTask(), 2000, 300000);
        return "555";
//	}

}

public static List<String> getAllAddresses(){
		return null;
}
//��filepath���ļ��е�email����resource\\2002.txt��������5w
public static void readFile(String filepath){
	String output = "";
	File file = new File(filepath);  
    
    if(file.exists()){  
        if(file.isFile()){  
            try{  
                BufferedReader input = new BufferedReader (new FileReader(file));  
                StringBuffer buffer = new StringBuffer();
                StringBuffer resuleBuffer = new StringBuffer();
                String text;  
                List<String> emailList=new ArrayList<String>();
                int i = 0;
                while((text = input.readLine()) != null) { //��Դ�ļ�emaiд��buffer
                    buffer.append(text);  
//                    System.out.println(text);
//                	System.out.println("ȡ��һ��email��"+text);	
                }
                emailList = TestTimer.parseEmail(buffer.toString());
                Iterator<String> itr = emailList.iterator();
                while (itr.hasNext()) {
                    String nextObj = itr.next();
                    TestTimer.SaveStringToFile("resource\\2002.txt", nextObj + "\r\n");
                	}
                
            }  
            catch(IOException ioException){  
                System.out.println("File Error!");  
            }  
        }  
    }
	}

public static void SaveStringToFile(String fileName, String towrite) {
	try{
	 File f = new File(fileName);
	   if(f.exists()){
	    System.out.println("�ļ�����");
	   }else{
	    System.out.println("�ļ�������");
	    f.createNewFile();//�������򴴽�
	   }
       FileOutputStream out = null;      
       try {
           out = new FileOutputStream(new File(fileName), true);   
           SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//�������ڸ�ʽ
           System.out.println(df.format(new Date()));// new Date()Ϊ��ȡ��ǰϵͳʱ��
//           logStr = df.format(new Date()) + "����״̬:" + logStr + "\r\n";
//           logStr = df.format(new Date()) + "����״̬:" + logStr + "\r\n";
           out.write(towrite.getBytes());
           out.close();
       } catch (Exception e) {
           e.printStackTrace();
       }
   
	} catch (IOException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	}
} 


/**��Ҫ
 * 
 * ("[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+");   
 * 
 * ʹ�ü�ʱ1ms
 *  ��������ʽ�жϲ���ʾemail ��ַ */  
public static List<String> parseEmail(String line) { 
    Pattern p = Pattern.compile("[\\w[.-]]+@[\\w[.-]]+\\.[\\w]+");    
    List<String> emailList=new ArrayList<String>();
    String[] strarray=line.split(" "); 
    for (int i = 0; i < strarray.length; i++) {
    	Matcher m = p.matcher(line); 
    	int ii = 0;
        while (m.find()) { 
        	String email=m.group(); 
        	System.out.println("ȡ��һ��email��"+email);	
        	emailList.add(email);
        	ii ++;
        	if(ii > 500000){
        		System.out.println("+++++++++++++++number"+ii);
        		return emailList;
        	}
        }  
        System.out.println("+++++++++++++++number"+ii);
    }
    return emailList;
}

public static List<String> getEmailFromResultFile(String filepath) {
	File file = new File(filepath); 
    List<String> emailList=new ArrayList<String>();
	if(file.exists()){  
        if(file.isFile()){  
            try{  
                BufferedReader input = new BufferedReader (new FileReader(file));  
                String text;  
                while((text = input.readLine()) != null) { 
                    String[] strarray=text.split(" "); 
                    for (int ii = 0; ii < 20; ii++) {
                    	if(strarray[ii].toString().trim().length() >3){
                        	emailList.add(strarray[ii]);
                        	System.out.println(strarray[ii]);
                    	}
                    }
                }
            }  
            catch(IOException ioException){  
                System.out.println("File Error!");  
            }  
        }  
    }
	return emailList;
}


public static Boolean startSendMailSina(){

	String emailStr = "";
	Address[] arrayList = new Address[20];
	List<String> emailList=new ArrayList<String>();
	emailList = TestTimer.getSmallEmailFromResultFile("resource\\2002.txt");
	Iterator<String> itr = emailList.iterator();
	int i = 0;
	System.out.println("++++++");
	while (itr.hasNext()){
			System.out.println("]]]]]]"+arrayList[i].toString());
			emailStr =emailStr + arrayList[i].toString();
		i ++;
	}
	System.out.println("=======");
	emailStr =emailStr + "767381290@qq.com";
	try{
		Properties props = new Properties();
		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.host", "smtp.sina.com");
		Session session = Session.getInstance(props,
				new Authenticator()
				{
					protected PasswordAuthentication getPasswordAuthentication()
					{
						return new PasswordAuthentication("jianzhongl@sina.cn","a123456");
					}
				}
		);
		session.setDebug(true);
		Message msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress("jianzhongl@sina.cn"));
		msg.setSubject("��������");
		String email = emailStr.toString();
//		msg.setRecipients(RecipientType.BCC, 
//				InternetAddress.parse(emailStr));
		msg.setRecipients(RecipientType.TO, 
				InternetAddress.parse(email));
		msg.setContent("<span style='color:red'><li><a href='http://shadong.net'>��è�ۿ�</a></li></span>", "text/html;charset=gbk");

//		Pattern p = Pattern.compile("^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\\.([a-zA-Z0-9_-])+)+$");
//		  Matcher m = p.matcher(email);
//		//Mather m = p.matcher("wangxu198709@gmail.com.cn");����Ҳ�ǿ��Եģ�
//		  boolean b = m.matches();
//		  if(!b) return false;
		  Transport.send(msg);
	}catch(AuthenticationFailedException e){
		System.out.print(e);
		return false;
	} catch (AddressException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return false;
	} catch (MessagingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return false;
	}
	return true;
}

public static List<String> getSmallEmailFromResultFile(String filepath) {
	File file = new File(filepath); 
    List<String> emailList=new ArrayList<String>();
	if(file.exists()){  
        if(file.isFile()){  
            try{  
                BufferedReader input = new BufferedReader (new FileReader(file));  
                String text;  
                while((text = input.readLine()) != null) {
                    String[] strarray=text.split("   "); 
                    for (int ii = 0; ii < 20; ii++) {
                		
                    	if(strarray[ii].toString().trim().length() >3){
                       	 java.util.Random r=new java.util.Random();
                       	 int random = r.nextInt(50000);
                       	 if (random > 0 ){
//                       		System.out.println("[[[[[[[[[[[[["+random);
                       		 if (strarray[random].length() > 7){
                              	emailList.add(strarray[random]);   
                            	System.out.println("+++++++email+++++++" + strarray[ii]);
                       		 }

                       	 }
                    	}
                    }
                }
            }  
            catch(IOException ioException){  
                System.out.println("File Error!");  
            }  
        }  
    }
	return emailList;
}


}

