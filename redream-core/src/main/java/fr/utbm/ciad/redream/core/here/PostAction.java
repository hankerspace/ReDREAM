package fr.utbm.ciad.redream.core.here;

public class PostAction {
    private String action;
    private Integer duration;
    private Double consumablePower;
    private Double arrivalCharge;
    private Double targetCharge;
    public String getAction() {
        return action;
    }
    public void setAction(String action) {
        this.action = action;
    }
    public Integer getDuration() {
        return duration;
    }
    public void setDuration(Integer duration) {
        this.duration = duration;
    }
    public Double getConsumablePower() {
        return consumablePower;
    }
    public void setConsumablePower(Double consumablePower) {
        this.consumablePower = consumablePower;
    }
    public Double getArrivalCharge() {
        return arrivalCharge;
    }
    public void setArrivalCharge(Double arrivalCharge) {
        this.arrivalCharge = arrivalCharge;
    }
    public Double getTargetCharge() {
        return targetCharge;
    }
    public void setTargetCharge(Double targetCharge) {
        this.targetCharge = targetCharge;
    }
}
