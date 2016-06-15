<%@ page language="java" import="java.util.*,com.by.utils.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//TestTimer.startTimer(null);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
  <h5>这是个POST请求，必须要用REST的方式请求</h5>
<h6>http://oa.sygpp.com/SACSIS/HOUR/SACSIS/getallsacsis?type=1&startTime=2014-09-26 09:00:00&endTime=2014-09-26 10:00:01以5分钟为单位</h6>
<form action='http://liujianongdembp.lan:8080/yungou/REST/util/startThread' method="GET">
<input type="submit" value="开线程" >
</form>

<h6>http://oa.sygpp.com/SACSIS/HOUR/SACSIS/getallsacsisday?type=1&startTime=2014-09-26 09:00:00&endTime=2014-09-27 10:00:01以天为单位</h6>
<form action='http://oa.sygpp.com/SACSIS/HOUR/SACSIS/getallsacsisday?type=1&startTime=2014-09-22 00:00:00&endTime=2014-09-23 00:00:01' method="POST">
<input type="submit" value="结果测试POST02" >
</form>

<h6>http://oa.sygpp.com/SACSIS/HOUR/SACSIS/getOneMonthDataPost?type=1&startTime=2014-09-26 09:00:00&endTime=2014-09-27 10:00:01以月为单位</h6>
<form action='http://oa.sygpp.com/SACSIS/HOUR/SACSIS/getOneMonthDataPost?type=1&startTime=2014-09-22 00:00:00&endTime=2014-09-23 00:00:01' method="POST">
<input type="submit" value="结果测试POST03" >
</form>getOneMonthDataPost
</br>
<h1 style = "color = red">下面GET请求</h1>
<h5>getAPI 01 ====时间间隔最小5分钟 ====</h5>
<h7 style = "color = yellow">http://oa.sygpp.com/SACSIS/HOUR/SACSIS/getallsacsisforgetparam?type=1&startTime=2014-09-26 09:00:00&endTime=2014-09-26 10:00:01</h7>
<a href = "http://oa.sygpp.com/SACSIS/HOUR/SACSIS/getallsacsisforgetparam?type=1&startTime=2014-09-26 09:00:00&endTime=2014-09-26 10:00:01">结果测试GET01</a>

<h5>getAPI 02 ====时间间隔最小一天 ====</h5>
<h7 style = "color = yellow">http://oa.sygpp.com/SACSIS/HOUR/SACSIS/getDaySacsisData?type=1&startTime=2014-09-26 09:00:00&endTime=2014-09-26 10:00:01</h7>
<a href = "http://oa.sygpp.com/SACSIS/HOUR/SACSIS/getDaySacsisData?type=1&startTime=2014-09-26 09:00:00&endTime=2014-09-26 10:00:01">结果测试GET02</a>

<h5>getAPI 02 ====取一段时间的平均值，可以取单个月的平均值，也可以取到一个季度的平均值 ====</h5>
<h7 style = "color = yellow">localhost:8080/SACSIS/HOUR/SACSIS/getOneMonthData?type=1&startTime=2014-09-26 09:00:00&endTime=2014-09-26 10:00:01</h7>
<a href = "http://oa.sygpp.com/SACSIS/HOUR/SACSIS/getOneMonthData?type=1&startTime=2014-09-26 09:00:00&endTime=2014-09-26 10:00:01">结果测试GET03</a>

  </body>
</html>
