package org.project.public_wifi_project.db;


import org.project.public_wifi_project.service.WifiService;

public class DbServiceTest {

    public static void main(String[] args) {

        WifiService wifiService = new WifiService();

        wifiService.prepareService();

        int cnt = wifiService.getTotalDataNum(DbConst.AUTHENTICATION_KEY);

        for (int i = 1; i <= cnt; i = i + 1000) {
            int startPage = i;
            int endPage = Math.min((i + 999), cnt);
            String result1 = wifiService.getJsonToApi(DbConst.AUTHENTICATION_KEY, startPage + "", endPage + "");
            wifiService.parsingJsonToWifi(result1);
        }

        wifiService.endService();
        System.out.println(cnt);


    }

    public void start() {
        WifiService wifiService = new WifiService();

        wifiService.prepareService();

        int cnt = wifiService.getTotalDataNum(DbConst.AUTHENTICATION_KEY);

        for (int i = 1; i <= cnt; i = i + 1000) {
            int startPage = i;
            int endPage = Math.min((i + 999), cnt);
            String result1 = wifiService.getJsonToApi(DbConst.AUTHENTICATION_KEY, startPage + "", endPage + "");
            wifiService.parsingJsonToWifi(result1);
        }

        wifiService.endService();
        System.out.println(cnt);
    }



    /*
    {"TbPublicWifiInfo":{"list_total_count":25162,"RESULT":{"CODE":"INFO-000","MESSAGE":"정상 처리되었습니다"},"row":[{"X_SWIFI_MGR_NO":"-WF171016","X_SWIFI_WRDOFC":"중구","X_SWIFI_MAIN_NM":"다동어린이공원","X_SWIFI_ADRES1":"다동 51-2","X_SWIFI_ADRES2":"을지로 3길 49(다동 51-2, 공-16)","X_SWIFI_INSTL_FLOOR":"","X_SWIFI_INSTL_TY":"3. 공원(하천)","X_SWIFI_INSTL_MBY":"협력형_서울(SKT)","X_SWIFI_SVC_SE":"공공WiFi","X_SWIFI_CMCWR":"자가망U-무선망","X_SWIFI_CNSTC_YEAR":"2017","X_SWIFI_INOUT_DOOR":"실외","X_SWIFI_REMARS3":"","LAT":"37.56817","LNT":"126.98076","WORK_DTTM":"2024-04-01 11:12:46.0"}]}}

     */
}
