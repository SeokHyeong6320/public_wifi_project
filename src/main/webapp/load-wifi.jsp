<%@ page import="org.project.public_wifi_project.service.WifiService" %>


<%--
  Created by IntelliJ IDEA.
  User: seokhyeong
  Date: 4/2/24
  Time: 11:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>

<%
    WifiService service = new WifiService();
    int cnt = service.getWifiList();
%>

<h2 style="text-align: center;"><%=cnt%>개의 WIFI 정보를 정상적으로 저장하였습니다</h2>
<p style="text-align: center;">
<a href="index.jsp">홈 으로 가기</a>
</p>
</body>
</html>
