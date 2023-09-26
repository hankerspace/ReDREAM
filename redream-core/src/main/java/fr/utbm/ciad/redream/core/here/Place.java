package fr.utbm.ciad.redream.core.here;

public class Place {
    private String type;
    private Location location;
    private OriginalLocation originalLocation;
    private String id;
    private String name;
    private Attributes attributes;
    private Brand brand;
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public Location getLocation() {
        return location;
    }
    public void setLocation(Location location) {
        this.location = location;
    }
    public OriginalLocation getOriginalLocation() {
        return originalLocation;
    }
    public void setOriginalLocation(OriginalLocation originalLocation) {
        this.originalLocation = originalLocation;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public Attributes getAttributes() {
        return attributes;
    }
    public void setAttributes(Attributes attributes) {
        this.attributes = attributes;
    }
    public Brand getBrand() {
        return brand;
    }
    public void setBrand(Brand brand) {
        this.brand = brand;
    }
}
