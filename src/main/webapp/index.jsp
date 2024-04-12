<%@ page import="java.util.List" %>
<%@ page import="org.project.public_wifi_project.domain.Wifi" %>
<%@ page import="org.project.public_wifi_project.service.WifiService" %><%--
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
        text-align: center;
        border-collapse: collapse;
      }
      .top {
        color: white;
        background-color: #00b173;
      }

      .none {
        padding: 15px;
        border-style: solid;
        border-color: #00b173;
      }

      th, td {
        border: 1px solid darkgrey;
        padding: 5px;
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
  <%
    String lat = request.getParameter("lat");
    String lnt = request.getParameter("lnt");
    if (lat == null || lat.equals("")) lat = "";
    if (lnt == null || lnt.equals("")) lnt = "";

  %>

  <body>
  <h2>와이파이 정보 구하기</h2>
  <div>
    <a href="/">홈</a>
    <a>|</a>
    <a href="history.jsp">위치 히스토리 목록</a>
    <a>|</a>
    <a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
  </div>
  <br/>

  <div>
    <form action="" method="get">
      <label>LAT:</label>
      <input name="lat" id="lat" type="text" value="<%=lat.isEmpty()?"0.0":lat%>">
      ,
      <label>LNT:</label>
      <input name="lnt" id="lnt" type="text" value="<%=lnt.isEmpty()?"0.0":lnt%>">


      <input type="button" value="내 위치 가져오기" onclick="userLocation()">

      <button type="submit" onclick="sendLocation()">근처 WIFI 정보 보기 </button>
    </form>
  </div>

  <div>
    <table>
      <tr class="top" style="border-color: white; padding: 20px">
        <td scope="col">거리(Km)</td>
        <td scope="col">관리번호</td>
        <td scope="col">자치구</td>
        <td scope="col" width="7%">와이파이명</td>
        <td scope="col" width="10%">도로명주소</td>
        <td scope="col" width="15%">상세주소</td>
        <td scope="col">설치위치(층)</td>
        <td scope="col" width="7%">설치유형</td>
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

      <%
        if (lat == null || lnt == null || lat.equals("") || lnt.equals("")) {
      %>
      <tr class="none" style="border: 1px darkgrey" >
        <td colspan="17" align="center" style="padding: 20px">
          위치 정보를 입력한 후에 조회해 주세요.
        </td>
      </tr>
        <%
          } else {
            WifiService service = new WifiService();
            List<Wifi> nearWifiInfo = service.getNearWifiInfo(request);

            for (int i = 0; i < nearWifiInfo.size(); i++) {
              Wifi item = nearWifiInfo.get(i);
        %>
      <tr class="detail" <% if(i % 2 == 1){%> bgcolor="#d3d3d3" <%}%> align="left" >

        <td><%=item.getDISTANCE()%></td>
        <td><%=item.getX_SWIFI_MGR_NO()%></td>
        <td><%=item.getX_SWIFI_WRDOFC()%></td>
        <td><%=item.getX_SWIFI_MAIN_NM()%></td>
        <td><%=item.getX_SWIFI_ADRES1()%></td>
        <td><%=item.getX_SWIFI_ADRES2()%></td>
        <td><%=item.getX_SWIFI_INSTL_FLOOR()%></td>
        <td><%=item.getX_SWIFI_INSTL_TY()%></td>
        <td><%=item.getX_SWIFI_INSTL_MBY()%></td>
        <td><%=item.getX_SWIFI_SVC_SE()%></td>
        <td><%=item.getX_SWIFI_CMCWR()%></td>
        <td><%=item.getX_SWIFI_CNSTC_YEAR()%></td>
        <td><%=item.getX_SWIFI_INOUT_DOOR()%></td>
        <td><%=item.getX_SWIFI_REMARS3()%></td>
        <td><%=item.getLAT()%></td>
        <td><%=item.getLNT()%></td>
        <td><%=item.getWORK_DTTM()%></td>
        <%
            }
          }
        %>
      </tr>
    </table>
  </div>



  </body>
</html>
