package com.by.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class WriteLog {   

    public WriteLog() {   

    }   
    public static void main(String[] args) {
    	WriteLog.WritLog("测试log");
    }
    public synchronized static void WritLog(String logStr){   
        FileOutputStream out = null;      
        try {
            out = new FileOutputStream(new File("resource/test.txt"), true);   
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//�������ڸ�ʽ
            System.out.println(df.format(new Date()));// new Date()Ϊ��ȡ��ǰϵͳʱ��
            logStr = df.format(new Date()) + "事件：" + logStr + "\r\n";
//            logStr = df.format(new Date()) + "����״̬:" + logStr + "\r\n";
            out.write(logStr.getBytes());
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {   
            try {   
                out.close();   
            } catch (Exception e) {   
                e.printStackTrace();
            }   

        }   
    }   

}   