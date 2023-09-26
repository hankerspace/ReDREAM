package fr.utbm.ciad.redream.core.here;

import java.util.ArrayList;
import java.util.List;

//TODO remvoe root
public class Root {

    private List<Route> routes = new ArrayList<Route>();
    public List<Route> getRoutes() {
        return routes;
    }
    public void setRoutes(List<Route> routes) {
        this.routes = routes;
    }
}
