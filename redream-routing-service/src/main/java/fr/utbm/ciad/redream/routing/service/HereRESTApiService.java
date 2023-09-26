package fr.utbm.ciad.redream.routing.service;

import com.here.flexpolyline.PolylineEncoderDecoder;
import com.netflix.discovery.converters.Auto;
import fr.utbm.ciad.redream.core.here.Root;
import fr.utbm.ciad.redream.core.here.Route;
import fr.utbm.ciad.redream.core.here.Section;
import fr.utbm.ciad.redream.vehicle.model.Vehicle;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.here.flexpolyline.PolylineEncoderDecoder.decode;

@Service
@Slf4j
public class HereRESTApiService {
    @Value("${redream.here.api-key}")
    private String hereApiKey;

    @Value("${redream.parameters.highSpeedTrainMetersToWattsFactor}")
    private Double highSpeedTrainMetersToWattsFactor;
    @Value("${redream.parameters.regionalTrainMetersToWattsFactor}")
    private Double regionalTrainMetersToWattsFactor;
    @Value("${redream.parameters.cityTrainMetersToWattsFactor}")
    private Double cityTrainMetersToWattsFactor;
    @Value("${redream.parameters.busMetersToWattsFactor}")
    private Double busMetersToWattsFactor;
    @Value("${redream.parameters.ferryMetersToWattsFactor}")
    private Double ferryMetersToWattsFactor;
    @Value("${redream.parameters.monorailMetersToWattsFactor}")
    private Double monorailMetersToWattsFactor;
    @Value("${redream.parameters.highSpeedTrainWattsToLitersFactor}")
    private Double highSpeedTrainWattsToLitersFactor;
    @Value("${redream.parameters.regionalTrainWattsToLitersFactor}")
    private Double regionalTrainWattsToLitersFactor;
    @Value("${redream.parameters.cityTrainWattsToLitersFactor}")
    private Double cityTrainWattsToLitersFactor;
    @Value("${redream.parameters.busWattsToLitersFactor}")
    private Double busWattsToLitersFactor;
    @Value("${redream.parameters.ferryWattsToLitersFactor}")
    private Double ferryWattsToLitersFactor;
    @Value("${redream.parameters.monorailWattsToLitersFactor}")
    private Double monorailWattsToLitersFactor;
    @Value("${redream.parameters.highSpeedTrainLitersToCo2Factor}")
    private Double highSpeedTrainLitersToCo2Factor;
    @Value("${redream.parameters.regionalTrainLitersToCo2Factor}")
    private Double regionalTrainLitersToCo2Factor;
    @Value("${redream.parameters.cityTrainLitersToCo2Factor}")
    private Double cityTrainLitersToCo2Factor;
    @Value("${redream.parameters.busLitersToCo2Factor}")
    private Double busLitersToCo2Factor;
    @Value("${redream.parameters.ferryLitersToCo2Factor}")
    private Double ferryLitersToCo2Factor;
    @Value("${redream.parameters.monorailLitersToCo2Factor}")
    private Double monorailLitersToCo2Factor;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private PriceService priceService;

    private static final String ROUTING_HERE_URL = "https://router.hereapi.com/v8/routes";
    private static final String TRANSIT_HERE_URL = "https://transit.hereapi.com/v8/routes";

    /**
     * Gets a route length in meters
     * @param route the route
     * @return the length in meters
     */
    public static double getRouteLength(Route route) {
        double length = 0;
        for(Section section : route.getSections()) {
            length += section.getTravelSummary().getLength();
        }
        return length;
    }

    public double getRouteLiters(Route route) {
        double liters = 0;
        for(Section section : route.getSections()) {
            switch (section.getTransport().getMode()) {
                case "highSpeedTrain":
                    liters += section.getTravelSummary().getLength() * highSpeedTrainMetersToWattsFactor * highSpeedTrainWattsToLitersFactor; // Meters to Watts
                    break;
                case "interRegionalTrain":
                case "regionalTrain":
                    liters += section.getTravelSummary().getLength() * regionalTrainMetersToWattsFactor * regionalTrainWattsToLitersFactor; // Meters to Watts
                    break;
                case "intercityTrain":
                case "cityTrain":
                    liters += section.getTravelSummary().getLength() * cityTrainMetersToWattsFactor * cityTrainWattsToLitersFactor; // Meters to Watts
                    break;
                case "bus":
                case "privateBus":
                case "busRapid":
                    liters += section.getTravelSummary().getLength() * busMetersToWattsFactor * busWattsToLitersFactor; // Meters to Watts
                    break;
                case "ferry":
                    liters += section.getTravelSummary().getLength() * ferryMetersToWattsFactor * ferryWattsToLitersFactor; // Meters to Watts
                    break;
                case "subway":
                case "lightRail":
                case "monorail":
                    liters += section.getTravelSummary().getLength() * monorailMetersToWattsFactor * monorailWattsToLitersFactor; // Meters to Watts
                    break;
                case "pedestrian":
                    liters += 0d;
                    break;
            }
        }
        return liters;
    }

    public double getRouteCO2(Route route) {
        double co2 = 0;
        for(Section section : route.getSections()) {
            switch (section.getTransport().getMode()) {
                case "highSpeedTrain":
                    co2 += section.getTravelSummary().getLength() * highSpeedTrainMetersToWattsFactor * highSpeedTrainWattsToLitersFactor * highSpeedTrainLitersToCo2Factor; // Meters to Watts
                    break;
                case "interRegionalTrain":
                case "regionalTrain":
                    co2 += section.getTravelSummary().getLength() * regionalTrainMetersToWattsFactor * regionalTrainWattsToLitersFactor * regionalTrainLitersToCo2Factor; // Meters to Watts
                    break;
                case "intercityTrain":
                case "cityTrain":
                    co2 += section.getTravelSummary().getLength() * cityTrainMetersToWattsFactor * cityTrainWattsToLitersFactor * cityTrainLitersToCo2Factor; // Meters to Watts
                    break;
                case "bus":
                case "privateBus":
                case "busRapid":
                    co2 += section.getTravelSummary().getLength() * busMetersToWattsFactor * busWattsToLitersFactor * busLitersToCo2Factor; // Meters to Watts
                    break;
                case "ferry":
                    co2 += section.getTravelSummary().getLength() * ferryMetersToWattsFactor * ferryWattsToLitersFactor * ferryLitersToCo2Factor; // Meters to Watts
                    break;
                case "subway":
                case "lightRail":
                case "monorail":
                    co2 += section.getTravelSummary().getLength() * monorailMetersToWattsFactor * monorailWattsToLitersFactor * monorailLitersToCo2Factor; // Meters to Watts
                    break;
                case "pedestrian":
                    co2 += 0d;
                    break;
            }
        }
        return co2;
    }

    /**
     * Gets a route consumption in Watts hours
     * @param route the route
     * @return the consumption in watts hours
     */
    public double getRouteConsumption(Route route) {
        double consumption = 0;
        for(Section section : route.getSections()) {
            if(section.getTravelSummary().getConsumption() != null) {
                consumption += section.getTravelSummary().getConsumption() * 1000d; // Kw to W
            }
            else {
                switch (section.getTransport().getMode()) {
                    case "highSpeedTrain":
                        consumption += section.getTravelSummary().getLength() * highSpeedTrainMetersToWattsFactor; // Meters to Watts
                        break;
                    case "interRegionalTrain":
                    case "regionalTrain":
                        consumption += section.getTravelSummary().getLength() * regionalTrainMetersToWattsFactor; // Meters to Watts
                        break;
                    case "intercityTrain":
                    case "cityTrain":
                        consumption += section.getTravelSummary().getLength() * cityTrainMetersToWattsFactor; // Meters to Watts
                        break;
                    case "bus":
                    case "privateBus":
                    case "busRapid":
                        consumption += section.getTravelSummary().getLength() * busMetersToWattsFactor; // Meters to Watts
                        break;
                    case "ferry":
                        consumption += section.getTravelSummary().getLength() * ferryMetersToWattsFactor; // Meters to Watts
                        break;
                    case "subway":
                    case "lightRail":
                    case "monorail":
                        consumption += section.getTravelSummary().getLength() * monorailMetersToWattsFactor; // Meters to Watts
                        break;
                    case "pedestrian":
                        consumption += 0d;
                        break;
                }
            }

        }
        return consumption;
    }

    /**
     * Gets a route duration in seconds
     * @param route the route
     * @return the duration in seconds
     */
    public static double getRouteDuration(Route route) {
        double duration = 0;
        for(Section section : route.getSections()) {
            duration += section.getTravelSummary().getDuration();
        }
        return duration;
    }



    /**
     * Calculates a route between two points using the HERE Routing API.
     * This function must be used for electric vehicles routing only.
     * @param originLat the Origin latitude
     * @param originLon the Origin longitude
     * @param destinationLat the Destination latitude
     * @param destinationLon the Destination longitude
     * @param departureTime the departure time
     * @param initialCharge the initial charge of the electric vehicle
     * @param maxCharge the maximum charge of the electric vehicle
     * @param minChargeAtChargingStation the minimum charge at the charging station
     * @param maxChargeAfterChargingStation the maximum charge after the charging station
     * @param minChargeAtDestination the minimum charge at the destination
     * @param freeFlowSpeedTable the free flow speed table
     * @param trafficSpeedTable the traffic speed table
     * @param auxiliaryConsumption Table the auxiliary consumption table
     * @param ascent Rate of energy consumed per meter rise in elevation
     * @param descent Rate of energy recovered per meter fall in elevation
     * @param chargingCurve the charging curve
     * @param maxChargingCurrent the maximum charging current
     * @param maxChargingVoltage the maximum charging voltage
     * @param chargingSetupDuration the charging setup duration
     * @param connectorType the connector type
     * @return the route
     * @throws IOException
     */
    public Root getEvRoute(String auth,
                           Vehicle vehicle,
                           String originLat,
                           String originLon,
                           String destinationLat,
                           String destinationLon,
                           LocalDateTime departureTime,
                           String initialCharge,
                           String maxCharge,
                           String minChargeAtChargingStation,
                           String maxChargeAfterChargingStation,
                           String minChargeAtDestination,
                           String freeFlowSpeedTable,
                           String trafficSpeedTable,
                           String auxiliaryConsumption,
                           String ascent,
                           String descent,
                           String chargingCurve,
                           String maxChargingCurrent,
                           String maxChargingVoltage,
                           String chargingSetupDuration,
                           String connectorType
    ) throws IOException {
        Map<String, String> requestParameters = new HashMap<>();
        requestParameters.put("origin", originLat + "," + originLon);
        requestParameters.put("destination", destinationLat + "," + destinationLon);
        requestParameters.put("departureTime", departureTime == null ? "any" : DateTimeFormatter.ISO_LOCAL_DATE_TIME.format(departureTime));
        requestParameters.put("alternatives", "6");
        requestParameters.put("return", "polyline,summary,travelSummary,elevation");
        requestParameters.put("spans", "consumption,speedLimit,length,functionalClass");
        requestParameters.put("transportMode", "car");
        requestParameters.put("ev[freeFlowSpeedTable]", freeFlowSpeedTable);
        requestParameters.put("ev[trafficSpeedTable]", trafficSpeedTable);
        requestParameters.put("ev[auxiliaryConsumption]", auxiliaryConsumption);
        requestParameters.put("ev[ascent]", ascent);
        requestParameters.put("ev[descent]", descent);
        requestParameters.put("ev[initialCharge]", initialCharge);
        requestParameters.put("ev[maxCharge]", maxCharge);
        requestParameters.put("ev[chargingCurve]", chargingCurve);
        requestParameters.put("ev[maxChargingVoltage]", maxChargingVoltage);
        requestParameters.put("ev[maxChargingCurrent]", maxChargingCurrent);
        requestParameters.put("ev[maxChargeAfterChargingStation]", maxChargeAfterChargingStation);
        requestParameters.put("ev[minChargeAtChargingStation]", minChargeAtChargingStation);
        requestParameters.put("ev[minChargeAtDestination]", minChargeAtDestination);
        requestParameters.put("ev[makeReachable]", "true");
        requestParameters.put("ev[chargingSetupDuration]", chargingSetupDuration);
        requestParameters.put("ev[connectorTypes]", connectorType);
        Root root = doRoutingRequest(requestParameters);


        for (Route route : root.getRoutes()) {
            route.setVehicleId(vehicle.getId());
            route.setVehicleName(vehicle.getName());
            route.setVehicleDescription(vehicle.getDescription());
            final double routeConsumption = getRouteConsumption(route);

            route.setConsumptionInWattsHours(routeConsumption);
            route.setDurationInSeconds(getRouteDuration(route));
            route.setLengthInMeters(getRouteLength(route));

            switch(vehicle.getEnergy()) {
                case HUMAN_POWERED:
                    route.setCo2inKg(0d);
                    route.setPriceInEuros(0d);
                    break;
                case ELECTRICITY:
                    route.setCo2inKg(0d);
                    route.setPriceInEuros(routeConsumption / 1000d * priceService.getKwhPriceInEur(auth, Double.valueOf(originLat), Double.valueOf(originLon)));
                    break;
                case HYBRID:
                case HYDROGEN:
                    break;
                case DIESEL:
                    final double routeLitersDiesel = routeConsumption * vehicle.getWhToLiterFactor();
                    route.setCo2inKg(routeLitersDiesel * vehicle.getLiterToCO2Factor());
                    route.setPriceInEuros(routeLitersDiesel * priceService.getDieselPricePerLiterInEur(auth, Double.valueOf(originLat), Double.valueOf(originLon)));
                    break;
                case PETROL:
                    final double routeLitersPetrol = routeConsumption * vehicle.getWhToLiterFactor();
                    route.setCo2inKg(routeLitersPetrol * vehicle.getLiterToCO2Factor());
                    route.setPriceInEuros(routeLitersPetrol * priceService.getPetrolPricePerLiterInEur(auth, Double.valueOf(originLat), Double.valueOf(originLon)));
                    break;
            }

        }

        return decodePolyline(root);
    }

    /**
     * Calculates a route between two points using the HERE Transit API.
     * @param originLat the Origin latitude
     * @param originLon the Origin longitude
     * @param destinationLat the Destination latitude
     * @param destinationLon the Destination longitude
     * @param departureTime the departure time
     * @param arrivalTime the arrival time
     * @param pedestrianSpeed the pedestrian speed
     * @param pedestrianMaxDistance the pedestrian maximum distance between two points
     * @return the route
     * @throws IOException
     */
    public Root getTransitRoute(String originLat,
                                String originLon,
                                String destinationLat,
                                String destinationLon,
                                LocalDateTime departureTime,
                                LocalDateTime arrivalTime,
                                String pedestrianSpeed,
                                String pedestrianMaxDistance
    ) throws IOException {
        Map<String, String> requestParameters = new HashMap<>();
        requestParameters.put("origin", originLat + "," + originLon);
        requestParameters.put("destination", destinationLat + "," + destinationLon);
        if(departureTime != null)
            requestParameters.put("departureTime", DateTimeFormatter.ISO_LOCAL_DATE_TIME.format(departureTime));
        if(arrivalTime != null)
            requestParameters.put("arrivalTime", DateTimeFormatter.ISO_LOCAL_DATE_TIME.format(arrivalTime));
        requestParameters.put("alternatives", "6");
        requestParameters.put("modes", "-flight,-inclined,-aerial,-spaceship");
        requestParameters.put("return", "polyline,travelSummary,intermediate,fares,bookingLinks");
        requestParameters.put("pedestrian[speed]", pedestrianSpeed);
        requestParameters.put("pedestrian[maxDistance]", pedestrianMaxDistance);
        Root root = doTransitRequest(requestParameters);


        for (Route route : root.getRoutes()) {
            route.setVehicleName("Public transports");
            route.setVehicleDescription("Public transports");
            final double routeConsumption = getRouteConsumption(route);
            route.setConsumptionInWattsHours(routeConsumption);
            route.setDurationInSeconds(getRouteDuration(route));
            final double routeLength = getRouteLength(route);
            route.setLengthInMeters(routeLength);
            route.setCo2inKg(getRouteCO2(route));
            route.setPriceInEuros(routeLength / 1000d * 0.5d); // TODO FIXME?
        }

        return decodePolyline(root);
    }

    private Root doRoutingRequest(Map<String, String> requestParameters) {
        Map<String, String> parameters = new HashMap<>();
        parameters.put("apikey", hereApiKey); // Add api key
        parameters.putAll(requestParameters);
        return restTemplate.getForObject(ROUTING_HERE_URL + "?" + getParamsString(parameters), Root.class);
    }

    private Root doTransitRequest(Map<String, String> requestParameters) {
        Map<String, String> parameters = new HashMap<>();
        parameters.put("apikey", hereApiKey); // Add api key
        parameters.putAll(requestParameters);
        return restTemplate.getForObject(TRANSIT_HERE_URL + "?" + getParamsString(parameters), Root.class);
    }

    private static Root decodePolyline(Root root) {
        // Decode polylines
        for (Route route : root.getRoutes()) {

            for (Section section : route.getSections()) {
                String polylinesStr = "[";
                List<PolylineEncoderDecoder.LatLngZ> decoded = decode(section.getPolyline());
                int count2 = 0;
                for(PolylineEncoderDecoder.LatLngZ point : decoded) {
                    if(count2 != 0) polylinesStr += ",";
                    polylinesStr += "[" + point.lat + ", " + point.lng + "]";
                    count2++;
                }
                polylinesStr += "] ";

                section.setPolyline(polylinesStr);

            }

        }
        return root;
    }

    public static String getParamsString(Map<String, String> params) {
        StringBuilder result = new StringBuilder();

        for (Map.Entry<String, String> entry : params.entrySet()) {
            result.append(entry.getKey());
            result.append("=");
            result.append(entry.getValue());
            result.append("&");
        }

        String resultString = result.toString();
        return resultString.length() > 0
                ? resultString.substring(0, resultString.length() - 1)
                : resultString;
    }

}
