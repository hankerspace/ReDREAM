package fr.utbm.ciad.redream.core.here;

public class Attributes {
    private Double power;
    private Double current;
    private Double voltage;
    private String supplyType;
    private String connectorType;
    public Double getPower() {
        return power;
    }
    public void setPower(Double power) {
        this.power = power;
    }
    public Double getCurrent() {
        return current;
    }
    public void setCurrent(Double current) {
        this.current = current;
    }
    public Double getVoltage() {
        return voltage;
    }
    public void setVoltage(Double voltage) {
        this.voltage = voltage;
    }
    public String getSupplyType() {
        return supplyType;
    }
    public void setSupplyType(String supplyType) {
        this.supplyType = supplyType;
    }
    public String getConnectorType() {
        return connectorType;
    }
    public void setConnectorType(String connectorType) {
        this.connectorType = connectorType;
    }
}
