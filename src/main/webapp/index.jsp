<%@ page import="org.project.public_wifi_project.db.DbConst" %><%--
  Created by IntelliJ IDEA.
  User: seokhyeong
  Date: 3/31/24
  Time: 4:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
  </head>

  <script language="JavaScript">
    function userLocation() {
      if (navigator.geolocation) {

        function success(position) {
          var LAT = position.coords.latitude;
          var LNT = position.coords.longitude;

          document.getElementById("LNT").value = LNT;
          document.getElementById("LAT").value = LAT;
        }

        function error() {
          alert('위치를 가져올 수 없습니다.');
        }

        navigator.geolocation.getCurrentPosition(success, error);
      } else {
        alert('위치를 가져올 수 없습니다.');
      }
    }
  </script>

  <body>
  <h2>와이파이 정보 구하기</h2>
  <div>
    <a href="/">홈</a>
    <a>|</a>
    <a href="service/history.jsp">위치 히스토리 목록</a>
    <a>|</a>
    <a href="service/load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
  </div>
  <br/>


  <div>
    <form action="service/view-wifi.jsp" method="get">
      <label>LAT</label>
      <input name="LAT" id="LAT" type="text">
      ,
      <label>LNT</label>
      <input name="LNT" id="LNT" type="text">
      <input type="button" value="내 위치 가져오기" onclick="userLocation()">
      <input type="button" value="근처 WIFI 정보 보기">
    </form>
  </div>

  <div>
    <table>
      <td>
        <tr></tr>
      </td>
    </table>
  </div>



  </body>
</html>
