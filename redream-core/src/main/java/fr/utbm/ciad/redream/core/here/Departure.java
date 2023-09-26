package fr.utbm.ciad.redream.core.here;

public class Departure {
    private String time;
    private Place place;
    private Double charge;
    public String getTime() {
        return time;
    }
    public void setTime(String time) {
        this.time = time;
    }
    public Place getPlace() {
        return place;
    }
    public void setPlace(Place place) {
        this.place = place;
    }
    public Double getCharge() {
        return charge;
    }
    public void setCharge(Double charge) {
        this.charge = charge;
    }
}
