package org.project.public_wifi_project.service;



import com.google.gson.*;
import org.project.public_wifi_project.db.DbConst;
import org.project.public_wifi_project.db.DbControl;
import org.project.public_wifi_project.domain.Wifi;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;


public class WifiService {

    private Connection connection = null;
    private PreparedStatement preparedStatement = null;

    public void prepareService() {
        DbControl.initDbConnection();
        connection = DbControl.dbConnect();
    }

    public void endService() {
        DbControl.dbDisconnect(connection, preparedStatement, null);
    }


    public int getTotalDataNum(String authenticationKey) {

        String json = getJsonToApi(authenticationKey, "1", "1");

        JsonParser parser = new JsonParser();
        JsonObject jsonObject = (JsonObject) parser.parse(json);
        JsonElement jsonElement = jsonObject.get(DbConst.SERVICE_NAME);
        String numStr = jsonElement.getAsJsonObject().get("list_total_count").getAsString();

        return Integer.parseInt(numStr);
    }



    public String getJsonToApi(String authenticationKey, String startPage, String endPage) {

        BufferedReader rd = null;
        HttpURLConnection urlConnection = null;
        StringBuilder sb = new StringBuilder();

        try {

            StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088");
            /*URL*/
            urlBuilder.append("/" + URLEncoder.encode(authenticationKey, "UTF-8"));
            urlBuilder.append("/" + URLEncoder.encode("json", "UTF-8"));
            urlBuilder.append("/" + URLEncoder.encode(DbConst.SERVICE_NAME, "UTF-8"));
            urlBuilder.append("/" + URLEncoder.encode(startPage, "UTF-8"));
            urlBuilder.append("/" + URLEncoder.encode(endPage, "UTF-8"));


            URL url = new URL(urlBuilder.toString());
            urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.setRequestMethod("GET");
            urlConnection.setRequestProperty("Content-type", "application/xml");

            int responseCode = urlConnection.getResponseCode();
            System.out.println("ResponseCode: " + responseCode);

            if (responseCode >= 200 && responseCode <= 300) {
                rd = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(urlConnection.getErrorStream()));
            }

            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }

        } catch (Exception e) {
            System.out.println("Fail!!5" + e.getMessage());
        }


        try {
            if (rd != null) rd.close();
        } catch (IOException e) {
            System.out.println("Fail!!6" + e.getMessage());
        }

        try {
            if (urlConnection != null) urlConnection.disconnect();
        } catch (NullPointerException e) {
            System.out.println("Fail!!7" + e.getMessage());
        }

        return sb.toString();
    }


    public void parsingJsonToWifi(String wifiList) {

        JsonParser parser = new JsonParser();
        Gson gson = new Gson();
        JsonObject jsonObject = (JsonObject) parser.parse(wifiList);
        JsonElement jsonElement = jsonObject.get(DbConst.SERVICE_NAME);
        JsonArray wifiArray = (JsonArray) jsonElement.getAsJsonObject().get("row");

        try {
            connection.setAutoCommit(false);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        for (int i = 0; i < wifiArray.size(); i++) {
            String string = wifiArray.get(i).toString();
            Wifi wifi = gson.fromJson(string, Wifi.class);

            insertWifiToDb(wifi);
        }

        try {
            connection.commit();
        } catch (SQLException e) {
            System.out.println("Fail commit!" + e.getMessage());
        }
    }


    public void insertWifiToDb(Wifi wifi) {

        String insertWifiSql = "insert into public_wifi_list (X_SWIFI_MGR_NO, X_SWIFI_WRDOFC, X_SWIFI_MAIN_NM, X_SWIFI_ADRES1, X_SWIFI_ADRES2, " +
                "                              X_SWIFI_INSTL_FLOOR, X_SWIFI_INSTL_TY, X_SWIFI_INSTL_MBY, X_SWIFI_SVC_SE, X_SWIFI_CMCWR, " +
                "                              X_SWIFI_CNSTC_YEAR, X_SWIFI_INOUT_DOOR, X_SWIFI_REMARS3, LAT, LNT, WORK_DTTM) " +
                "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";

        try {
            preparedStatement = connection.prepareStatement(insertWifiSql);

            preparedStatement.setString(1, wifi.getX_SWIFI_MGR_NO());
            preparedStatement.setString(2, wifi.getX_SWIFI_WRDOFC());
            preparedStatement.setString(3, wifi.getX_SWIFI_MAIN_NM());
            preparedStatement.setString(4, wifi.getX_SWIFI_ADRES1());
            preparedStatement.setString(5, wifi.getX_SWIFI_ADRES2());
            preparedStatement.setString(6, wifi.getX_SWIFI_INSTL_FLOOR());
            preparedStatement.setString(7, wifi.getX_SWIFI_INSTL_TY());
            preparedStatement.setString(8, wifi.getX_SWIFI_INSTL_MBY());
            preparedStatement.setString(9, wifi.getX_SWIFI_SVC_SE());
            preparedStatement.setString(10, wifi.getX_SWIFI_CMCWR());
            preparedStatement.setString(11, wifi.getX_SWIFI_CNSTC_YEAR());
            preparedStatement.setString(12, wifi.getX_SWIFI_INOUT_DOOR());
            preparedStatement.setString(13, wifi.getX_SWIFI_REMARS3());
            preparedStatement.setDouble(14, wifi.getLAT());
            preparedStatement.setDouble(15, wifi.getLNT());
            preparedStatement.setString(16, wifi.getWORK_DTTM());

            preparedStatement.executeUpdate();

        } catch(SQLException e) {
            System.out.println("Fail insert!!" + e.getMessage());
        }
    }

    public List<Wifi> nearWifiInfo() {
        LinkedList<Wifi> nearWifiList = new LinkedList<>();
        ResultSet rs;

        String nearWifiSql = "select round(d.DISTANCE*10, 4) distance, w.*\n" +
                "from public_wifi_list w\n" +
                "join distance_info d\n" +
                "where d.X_SWIFI_MGR_NO == w.X_SWIFI_MGR_NO\n" +
                "order by DISTANCE\n" +
                "limit 20;";


        try {
            preparedStatement = connection.prepareStatement(nearWifiSql);
            rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Wifi wifi = new Wifi();
                wifi.setX_SWIFI_MGR_NO(rs.getString("X_SWIFI_MGR_NO"));
                wifi.setX_SWIFI_WRDOFC(rs.getString("X_SWIFI_WRDOFC"));
                wifi.setX_SWIFI_MAIN_NM(rs.getString("X_SWIFI_MAIN_NM"));
                wifi.setX_SWIFI_ADRES1(rs.getString("X_SWIFI_ADRES1"));
                wifi.setX_SWIFI_ADRES2(rs.getString("X_SWIFI_ADRES2"));
                wifi.setX_SWIFI_INSTL_FLOOR(rs.getString("X_SWIFI_INSTL_FLOOR"));
                wifi.setX_SWIFI_INSTL_TY(rs.getString("X_SWIFI_INSTL_TY"));
                wifi.setX_SWIFI_INSTL_MBY(rs.getString("X_SWIFI_INSTL_MBY"));
                wifi.setX_SWIFI_SVC_SE(rs.getString("X_SWIFI_SVC_SE"));
                wifi.setX_SWIFI_CMCWR(rs.getString("X_SWIFI_CMCWR"));
                wifi.setX_SWIFI_CNSTC_YEAR(rs.getString("X_SWIFI_CNSTC_YEAR"));
                wifi.setX_SWIFI_INOUT_DOOR(rs.getString("X_SWIFI_INOUT_DOOR"));
                wifi.setX_SWIFI_REMARS3(rs.getString("X_SWIFI_REMARS3"));
                wifi.setLAT(rs.getDouble("LAT"));
                wifi.setLNT(rs.getDouble("LNT"));
                wifi.setWORK_DTTM(rs.getString("WORK_DTTM"));
                wifi.setDISTANCE(rs.getDouble("DISTANCE"));

                nearWifiList.add(wifi);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        return nearWifiList;
    }




}
