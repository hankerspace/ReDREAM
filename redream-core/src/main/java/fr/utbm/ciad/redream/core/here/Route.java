package fr.utbm.ciad.redream.core.here;

import java.util.ArrayList;
import java.util.List;

public class Route {
    private String id;
    private Integer vehicleId;
    private String vehicleName;
    private String vehicleDescription;
    private double consumptionInWattsHours;
    private double lengthInMeters;
    private double durationInSeconds;
    private double co2inKg;
    private double priceInEuros;
    private List<Section> sections = new ArrayList<Section>();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    public double getConsumptionInWattsHours() {
        return consumptionInWattsHours;
    }

    public void setConsumptionInWattsHours(double consumptionInWattsHours) {
        this.consumptionInWattsHours = consumptionInWattsHours;
    }

    public double getLengthInMeters() {
        return lengthInMeters;
    }

    public void setLengthInMeters(double lengthInMeters) {
        this.lengthInMeters = lengthInMeters;
    }

    public double getDurationInSeconds() {
        return durationInSeconds;
    }

    public void setDurationInSeconds(double durationInSeconds) {
        this.durationInSeconds = durationInSeconds;
    }

    public double getCo2inKg() {
        return co2inKg;
    }

    public void setCo2inKg(double co2inKg) {
        this.co2inKg = co2inKg;
    }

    public double getPriceInEuros() {
        return priceInEuros;
    }

    public void setPriceInEuros(double priceInEuros) {
        this.priceInEuros = priceInEuros;
    }

    public Integer getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(Integer vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getVehicleName() {
        return vehicleName;
    }

    public void setVehicleName(String vehicleName) {
        this.vehicleName = vehicleName;
    }

    public String getVehicleDescription() {
        return vehicleDescription;
    }

    public void setVehicleDescription(String vehicleDescription) {
        this.vehicleDescription = vehicleDescription;
    }


    public List<Section> getSections() {
        return sections;
    }

    public void setSections(List<Section> sections) {
        this.sections = sections;
    }
}
