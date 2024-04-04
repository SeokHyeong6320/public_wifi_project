package org.project.public_wifi_project.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class LocationHistory {

    private int userNo;
    private double xAxis;
    private double yAxis;
    private String date;

}
