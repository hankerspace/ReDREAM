package fr.utbm.ciad.redream.core.here;

public class Span {
    private Integer offset;
    private Integer length;
    private Integer functionalClass;
    private Double speedLimit;
    private Double consumption;
    public Integer getOffset() {
        return offset;
    }
    public void setOffset(Integer offset) {
        this.offset = offset;
    }
    public Integer getLength() {
        return length;
    }
    public void setLength(Integer length) {
        this.length = length;
    }
    public Integer getFunctionalClass() {
        return functionalClass;
    }
    public void setFunctionalClass(Integer functionalClass) {
        this.functionalClass = functionalClass;
    }
    public Double getSpeedLimit() {
        return speedLimit;
    }
    public void setSpeedLimit(Double speedLimit) {
        this.speedLimit = speedLimit;
    }
    public Double getConsumption() {
        return consumption;
    }
    public void setConsumption(Double consumption) {
        this.consumption = consumption;
    }
}
