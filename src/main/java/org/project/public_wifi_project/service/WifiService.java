package org.project.public_wifi_project.service;

import org.project.public_wifi_project.domain.LocationHistory;
import org.project.public_wifi_project.domain.Wifi;
import org.project.public_wifi_project.repository.WifiRepository;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

import static org.project.public_wifi_project.db.DbConst.AUTHENTICATION_KEY;

public class WifiService {

    WifiRepository wifiRepository = new WifiRepository();

    public List<Wifi> getNearWifiInfo(HttpServletRequest request) {

        wifiRepository.prepareService();

        wifiRepository.insertUserInfo(request);

        List<Wifi> list = wifiRepository.nearWifiInfo();
        wifiRepository.endService();

        return list;
    }

    public int getWifiList() {
        int cnt = getTotalWifiCount();

        wifiRepository.prepareService();

        for (int i = 1; i <= cnt; i = i + 1000) {
            int startPage = i;
            int endPage = Math.min((i + 999), cnt);
            String result1 = wifiRepository.getJsonToApi(AUTHENTICATION_KEY, startPage + "", endPage + "");
            wifiRepository.parsingJsonToWifi(result1);
        }

        wifiRepository.endService();

        return cnt;
    }

    private int getTotalWifiCount() {

        int cnt = wifiRepository.getTotalDataNum(AUTHENTICATION_KEY);
        return cnt;
    }

    public List<LocationHistory> getLocationHistory() {
        wifiRepository.prepareService();
        List<LocationHistory> histories = wifiRepository.locationHistory();
        wifiRepository.endService();
        return histories;
    }

    public void deleteLocationHistory(int userNo) {
        WifiRepository wifiRepository = new WifiRepository();
        wifiRepository.prepareService();
        wifiRepository.deleteLocation(userNo);
        wifiRepository.endService();
    }

}
