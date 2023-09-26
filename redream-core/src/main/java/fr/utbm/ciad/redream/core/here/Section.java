package fr.utbm.ciad.redream.core.here;

import java.util.ArrayList;
import java.util.List;

public class Section {
    private String id;
    private String type;
    private List<Action> actions = new ArrayList<Action>();
    private List<PostAction> postActions = new ArrayList<PostAction>();
    private Departure departure;
    private Arrival arrival;
    private Summary summary;
    private TravelSummary travelSummary;
    private String polyline;
    private List<Span> spans = new ArrayList<Span>();
    private String language;
    private Transport transport;
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public List<Action> getActions() {
        return actions;
    }
    public void setActions(List<Action> actions) {
        this.actions = actions;
    }
    public List<PostAction> getPostActions() {
        return postActions;
    }
    public void setPostActions(List<PostAction> postActions) {
        this.postActions = postActions;
    }
    public Departure getDeparture() {
        return departure;
    }
    public void setDeparture(Departure departure) {
        this.departure = departure;
    }
    public Arrival getArrival() {
        return arrival;
    }
    public void setArrival(Arrival arrival) {
        this.arrival = arrival;
    }
    public Summary getSummary() {
        return summary;
    }
    public void setSummary(Summary summary) {
        this.summary = summary;
    }
    public TravelSummary getTravelSummary() {
        return travelSummary;
    }
    public void setTravelSummary(TravelSummary travelSummary) {
        this.travelSummary = travelSummary;
    }
    public String getPolyline() {
        return polyline;
    }
    public void setPolyline(String polyline) {
        this.polyline = polyline;
    }
    public List<Span> getSpans() {
        return spans;
    }
    public void setSpans(List<Span> spans) {
        this.spans = spans;
    }
    public String getLanguage() {
        return language;
    }
    public void setLanguage(String language) {
        this.language = language;
    }
    public Transport getTransport() {
        return transport;
    }
    public void setTransport(Transport transport) {
        this.transport = transport;
    }
}
