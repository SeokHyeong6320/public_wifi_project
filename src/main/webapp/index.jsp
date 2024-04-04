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
    <style>
      form {
        float: left;
        padding: 2px;
      }
      table {
        width: 100%;
        align-content: center;
        border-style: solid;
      }
      .top {
        color: white;
        background-color: #3cb371;
        border-color: white;
        padding: 10px;
      }
      .bottom {
        border-color: #3cb371;
        border-width: 1px;
        padding: 15px;
        align-content: center;
      }
    </style>
  </head>

  <script language="JavaScript">
    function userLocation() {
      if (navigator.geolocation) {

        function success(position) {
          var LAT = position.coords.latitude;
          var LNT = position.coords.longitude;

          document.getElementById("lnt").value = LNT;
          document.getElementById("lat").value = LAT;
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

  <%
    String lat = request.getParameter("lat");
    String lnt = request.getParameter("lnt");
    if (lat == null || lat.equals("")) lat = "";
    if (lnt == null || lnt.equals("")) lnt = "";

  %>


  <div>
    <form action="" method="get">
      <label>LAT</label>
      <input name="lat" id="lat" type="text" value="<%=lat%>">
      ,
      <label>LNT</label>
      <input name="lnt" id="lnt" type="text" value="<%=lnt%>">


      <input type="button" value="내 위치 가져오기" onclick="userLocation()">

      <button type="submit" onclick="sendLocation()">근처 WIFI 정보 보기 </button>
    </form>
  </div>

  <div>
    <table class="top">
      <tr>
        <td scope="col">거리(Km)</td>
        <td scope="col">관리번호</td>
        <td scope="col">자치구</td>
        <td scope="col">와이파이명</td>
        <td scope="col">도로명주소</td>
        <td scope="col">상세주소</td>
        <td scope="col">설치위치(층)</td>
        <td scope="col">설치유형</td>
        <td scope="col">설치기관</td>
        <td scope="col">서비스구분</td>
        <td scope="col">망종류</td>
        <td scope="col">설치년도</td>
        <td scope="col">실내외구분</td>
        <td scope="col">WIFI접속환경</td>
        <td scope="col">X좌표</td>
        <td scope="col">Y좌표</td>
        <td scope="col">작업일자</td>
      </tr>
    </table>
    <table class="bottom">
      <tr style="border-style: solid" a>
        <%
          if (lat == null && lnt == null || lat.equals("") || lnt.equals("")) {
        %>
        <td colspan="17" align="center">
          위치 정보를 입력한 후에 조회해 주세요.
        </td>
        <%
          } else {
        %>
        <td colspan="17" align="center">
          위치 정보확인.
        </td>
        <%
          }
        %>
      </tr>
    </table>
  </div>



  </body>
</html>
