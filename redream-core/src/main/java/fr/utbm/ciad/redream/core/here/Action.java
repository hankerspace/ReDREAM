package fr.utbm.ciad.redream.core.here;

public class Action {
    private String action;
    private Integer duration;
    private Integer length;
    private String instruction;
    private Integer offset;
    private String direction;
    private String severity;
    private Integer exit;
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
    public Integer getLength() {
        return length;
    }
    public void setLength(Integer length) {
        this.length = length;
    }
    public String getInstruction() {
        return instruction;
    }
    public void setInstruction(String instruction) {
        this.instruction = instruction;
    }
    public Integer getOffset() {
        return offset;
    }
    public void setOffset(Integer offset) {
        this.offset = offset;
    }
    public String getDirection() {
        return direction;
    }
    public void setDirection(String direction) {
        this.direction = direction;
    }
    public String getSeverity() {
        return severity;
    }
    public void setSeverity(String severity) {
        this.severity = severity;
    }
    public Integer getExit() {
        return exit;
    }
    public void setExit(Integer exit) {
        this.exit = exit;
    }
}