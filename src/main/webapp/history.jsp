<%@ page import="org.project.public_wifi_project.repository.WifiRepository" %>
<%@ page import="org.project.public_wifi_project.domain.LocationHistory" %>
<%@ page import="java.util.List" %>
<%@ page import="org.project.public_wifi_project.repository.WifiRepository" %><%--
  Created by IntelliJ IDEA.
  User: seokhyeong
  Date: 4/2/24
  Time: 11:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        form {
            float: left;
            padding: 2px;
        }
        table {
            font-weight: bold;
            width: 100%;
            text-align: center;
            border-collapse: collapse;
        }
        .top {
            color: white;
            background-color: #3cb371;
        }

        .none {
            padding: 15px;
            border-style: solid;
            border-color: mediumseagreen;
        }

        th, td {
            border: 1px solid darkgrey;
            padding: 5px;
        }
    </style>

</head>
<body>

<script>
    function reloadPage() {

        location.reload(); // 현재 페이지를 새로고침합니다.
    }
</script>

<%
    WifiRepository wifiRepository = new WifiRepository();
    wifiRepository.prepareService();
    List<LocationHistory> histories = wifiRepository.locationHistory();
%>

<h2>위치 히스토리 목록</h2>
<div>
    <a href="index.jsp">홈</a>
    <a>|</a>
    <a href="history.jsp">위치 히스토리 목록</a>
    <a>|</a>
    <a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
</div>
<br/>

<table>
    <tr class="top" >
        <td width="10%">ID</td>
        <td width="25%">X좌표</td>
        <td width="25%">Y좌표</td>
        <td>조회일자</td>
        <td width="10%">비고</td>
    </tr>
    <%
        if (!histories.isEmpty()) {
    %>

        <%
            for (int i = 0; i < histories.size(); i++) {
                LocationHistory history = histories.get(i);
                int userNo = history.getUserNo();
        %>
    <tr align="left" <%if(i % 2 == 1){%> bgcolor="#d3d3d3" <%}%>>
        <td><%=i+1%></td>
        <td><%=history.getXAxis()%></td>
        <td><%=history.getYAxis()%></td>
        <td><%=history.getDate()%></td>
        <td style="align-content: center">
            <input type="button" value="삭제" onclick="location.href='deletelocation.jsp?user_no=<%=userNo%>'" >
        </td>
    </tr>
        <%
            }
        }
    %>


</table>

</body>
</html>
