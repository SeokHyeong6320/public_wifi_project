<%@ page import="java.time.LocalDateTime" %>

<%@ page import="org.project.public_wifi_project.domain.Wifi" %>
<%@ page import="org.project.public_wifi_project.db.DbConst" %>
<%@ page import="org.project.public_wifi_project.repository.WifiRepository" %>
<%@ page import="org.project.public_wifi_project.db.DbServiceTest" %>
<%@ page import="org.project.public_wifi_project.repository.WifiRepository" %>


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
    WifiRepository wifiRepository1 = new WifiRepository();
    int cnt = wifiRepository1.getTotalDataNum(DbConst.AUTHENTICATION_KEY);

    WifiRepository wifiRepository = new WifiRepository();
    wifiRepository.prepareService();

    for (int i = 1; i <= cnt; i = i + 1000) {
        int startPage = i;
        int endPage = Math.min((i + 999), cnt);
        String result1 = wifiRepository.getJsonToApi(DbConst.AUTHENTICATION_KEY, startPage + "", endPage + "");
        wifiRepository.parsingJsonToWifi(result1);
    }

    wifiRepository.endService();

%>




<h2 style="text-align: center;"><%=cnt%>개의 WIFI 정보를 정상적으로 저장하였습니다</h2>
<p style="text-align: center;">
<a href="index.jsp">홈 으로 가기</a>
</p>
</body>
</html>
