<%@ page import="org.project.public_wifi_project.repository.WifiRepository" %>
<%--
  Created by IntelliJ IDEA.
  User: seokhyeong
  Date: 4/5/24
  Time: 12:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>

<%
    int userNo = Integer.parseInt(request.getParameter("user_no"));

    WifiRepository wifiRepository = new WifiRepository();
    wifiRepository.prepareService();
    wifiRepository.deleteLocation(userNo);
    wifiRepository.endService();

%>


<script>
    function refresh() {
        window.location.href="history.jsp";
    }
    refresh();
</script>

</body>
</html>
