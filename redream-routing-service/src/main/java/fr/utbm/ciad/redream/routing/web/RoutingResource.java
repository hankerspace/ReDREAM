/*
 * Copyright 2002-2017 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package fr.utbm.ciad.redream.routing.web;

import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.EurekaClient;
import com.netflix.discovery.shared.Application;
import fr.utbm.ciad.redream.core.here.Root;
import fr.utbm.ciad.redream.core.here.Route;
import fr.utbm.ciad.redream.routing.model.OrderCriteria;
import fr.utbm.ciad.redream.routing.service.HereRESTApiService;
import fr.utbm.ciad.redream.routing.service.VehicleApiService;
import fr.utbm.ciad.redream.vehicle.model.Vehicle;
import fr.utbm.ciad.redream.vehicle.model.VehicleEnergy;
import io.micrometer.core.annotation.Timed;
import javafx.scene.media.MediaPlayer;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.*;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

@RestController
@Timed("redream.routing")
@RequiredArgsConstructor
@Slf4j
class RoutingResource {

    @Value("${redream.parameters.pedestrianSpeed}")
    private Integer pedestrianSpeed;

    @Value("${redream.parameters.pedestrianMaxDistance}")
    private Integer pedestrianMaxDistance;

    @Autowired
    private final HereRESTApiService hereRESTApiService;

    @Autowired
    private VehicleApiService vehicleApiService;


    @GetMapping("/test")
    public String getTest() {
        return "test"; // TODO FIXME
    }

    @GetMapping("/testProtected")
    public String getTestProtected() {
        return "testProtected"; // TODO FIXME
    }

//    @PostMapping("/compare")
//    public String compare(
//            @RequestHeader("Authorization") String auth,
//            @RequestParam Double originLat,
//            @RequestParam Double originLon,
//            @RequestParam Double destinationLat,
//            @RequestParam Double destinationLon
//    ) throws IOException {
//        final ResponseEntity<?> evRoute = this.getEvRoute(auth, 1, originLat, originLon, destinationLat, destinationLon, null, null, null, null, null);
//        final ResponseEntity<?> transitRoute = this.getTransitRoute(auth, originLat, originLon, destinationLat, destinationLon, null, null);
//        final ResponseEntity<?> gasRoute208 = this.getRoute(auth, 6, originLat, originLon, destinationLat, destinationLon, null);
//        final ResponseEntity<?> gasRoute2008 = this.getRoute(auth, 7, originLat, originLon, destinationLat, destinationLon, null);
//
//        if(evRoute.getStatusCode() != HttpStatus.OK ||
//                transitRoute.getStatusCode() != HttpStatus.OK ||
//                gasRoute208.getStatusCode() != HttpStatus.OK
//                || gasRoute2008.getStatusCode() != HttpStatus.OK) {
//            return "Error with status codes : " + evRoute.getStatusCode() + " and " + transitRoute.getStatusCode() + " and " + gasRoute208.getStatusCode() + " and " + gasRoute2008.getStatusCode();
//        }
//
//        final Root evRouteJson = (Root) evRoute.getBody();
//        final Root transitRouteJson = (Root) transitRoute.getBody();
//        final Root gasRouteJson = (Root) gasRoute208.getBody();
//        final Root gasRouteJson2 = (Root) gasRoute2008.getBody();
//
//        StringBuilder sb = new StringBuilder();
//        sb.append("<h1>Route with Tesla model 3</h1>");
//        final double evTransitConsumption = hereRESTApiService.getRouteConsumption(evRouteJson.getRoutes().get(0));
//        sb.append("Consumption : ");
//        sb.append(evTransitConsumption);
//        sb.append("Wh<br/>Length : ");
//        sb.append(hereRESTApiService.getRouteLength(evRouteJson.getRoutes().get(0)));
//        sb.append("m<br/>Duration : ");
//        sb.append(hereRESTApiService.getRouteDuration(evRouteJson.getRoutes().get(0)));
//        sb.append("s<br/>CO2 : ");
//        sb.append("?");
//        sb.append("Kg<br/>Price : ");
//        sb.append(evTransitConsumption / 1000d * 0.2d);
//        sb.append("€<br/>");
//
//        sb.append("<h1>Route with public transports</h1>");
//        final double transitRouteConsumption = hereRESTApiService.getRouteConsumption(gasRouteJson.getRoutes().get(0));
//        sb.append("Consumption : ");
//        sb.append(transitRouteConsumption);
//        sb.append("Wh<br/>Length : ");
//        sb.append(hereRESTApiService.getRouteLength(transitRouteJson.getRoutes().get(0)));
//        sb.append("m<br/>Duration : ");
//        sb.append(hereRESTApiService.getRouteDuration(transitRouteJson.getRoutes().get(0)));
//        sb.append("s<br/>CO2 : ");
//        sb.append("?");
//        sb.append("Kg<br/>Price : ");
//        sb.append("?");
//        sb.append("€<br/>");
//
//        sb.append("<h1>Route with Peugeot 208</h1>");
//        final double fuelRouteConsumption = hereRESTApiService.getRouteConsumption(gasRouteJson.getRoutes().get(0));
//        sb.append("Consumption : ");
//        sb.append(fuelRouteConsumption);
//        sb.append("Wh<br/>Length : ");
//        sb.append(hereRESTApiService.getRouteLength(gasRouteJson.getRoutes().get(0)));
//        sb.append("m<br/>Duration : ");
//        sb.append(hereRESTApiService.getRouteDuration(gasRouteJson.getRoutes().get(0)));
//        sb.append("s<br/>CO2 : ");
//        sb.append(fuelRouteConsumption * 0.0003234346 * 2.392);
//        sb.append("kg<br/>Liters : ");
//        sb.append(fuelRouteConsumption * 0.0003234346);
//        sb.append("L<br/>Price : ");
//        sb.append(fuelRouteConsumption * 0.0003234346 * 1.5);
//        sb.append("€");
//
//        sb.append("<h1>Route with Peugeot 2008</h1>");
//        final double fuelRouteConsumption2 = hereRESTApiService.getRouteConsumption(gasRouteJson2.getRoutes().get(0));
//        sb.append("Consumption : ");
//        sb.append(fuelRouteConsumption2);
//        sb.append("Wh<br/>Length : ");
//        sb.append(hereRESTApiService.getRouteLength(gasRouteJson2.getRoutes().get(0)));
//        sb.append("m<br/>Duration : ");
//        sb.append(hereRESTApiService.getRouteDuration(gasRouteJson2.getRoutes().get(0)));
//        sb.append("s<br/>CO2 : ");
//        sb.append(fuelRouteConsumption2 * 0.0003234346 * 2.392);
//        sb.append("kg<br/>Liters : ");
//        sb.append(fuelRouteConsumption2 * 0.0003234346);
//        sb.append("L<br/>Price : ");
//        sb.append(fuelRouteConsumption2 * 0.0003234346 * 1.5);
//        sb.append("€");
//
//        return sb.toString();
//    }


    /**
     * Calculates a route between two points using the HERE Routing API.
     * This endpoint must be used for electric vehicles routing only.
     *
     * @param auth                 Token the authentication token
     * @param vehicleId            Vehicle ID. Must be an electric vehicle.
     * @param originLat            the latitude of the origin point
     * @param originLon            the longitude of the origin point
     * @param destinationLat       the latitude of the destination point
     * @param destinationLon       the longitude of the destination point
     * @param departureTime        the departure time
     * @param initialCharge        the initial charge of the vehicle
     * @param minChargeStation     the minimum charge at station
     * @param maxChargeStation     the maximum charge after the station
     * @param minChargeDestination the minimum charge at the destination
     * @return the route or bad request if the request is invalid (not an electric vehicle)
     * @throws IOException
     */
    @PostMapping("/getEvRoute")
    public ResponseEntity<?> getEvRoute(
            @RequestHeader("Authorization") String auth,
            @RequestParam Integer vehicleId,
            @RequestParam Double originLat,
            @RequestParam Double originLon,
            @RequestParam Double destinationLat,
            @RequestParam Double destinationLon,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime departureTime,
            @RequestParam(required = false) Double initialCharge,
            @RequestParam(required = false) Double minChargeStation,
            @RequestParam(required = false) Double maxChargeStation,
            @RequestParam(required = false) Double minChargeDestination
    ) throws IOException {

        final Vehicle vehicle = vehicleApiService.getVehicle(auth, vehicleId);

        if (vehicle.getEnergy().equals(VehicleEnergy.ELECTRICITY)) {
            log.info("Vehicle is EV. Fine.");
            if(initialCharge == null) initialCharge = vehicle.getMaxCharge();
            if(minChargeStation == null) minChargeStation = 1.0;
            if(maxChargeStation == null) maxChargeStation = vehicle.getMaxCharge();
            if(minChargeDestination == null) minChargeDestination = 1.0;

            Root evRoutes = hereRESTApiService.getEvRoute(auth, vehicle, originLat.toString(),
                    originLon.toString(),
                    destinationLat.toString(),
                    destinationLon.toString(),
                    departureTime,
                    initialCharge.toString(),
                    vehicle.getMaxCharge().toString(),
                    minChargeStation.toString(),
                    maxChargeStation.toString(),
                    minChargeDestination.toString(),
                    vehicle.getFreeFlowSpeedTable(),
                    vehicle.getTraficSpeedTable(),
                    vehicle.getAuxiliaryConsumption().toString(),
                    vehicle.getAscent().toString(),
                    vehicle.getDescent().toString(),
                    vehicle.getChargingCurve(),
                    vehicle.getMaxChargingCurrent().toString(),
                    vehicle.getMaxChargingVoltage().toString(),
                    vehicle.getChargingSetupDuration().toString(),
                    vehicle.getConnectorType());

            return ResponseEntity.ok(evRoutes.getRoutes());
        } else {
            log.info("Vehicle IS NOT EV. Err.");
            return ResponseEntity.badRequest().body("The vehicle Id you provided isn't an electric vehicle. Please use an electric vehicle with this routing function.");
        }

    }

    /**
     * Calculates a route between two points using the HERE Routing API.
     * This endpoint must be used for gas vehicles routing only.
     *
     * @param auth           Token the authentication token
     * @param vehicleId      Vehicle ID. Must be an electric vehicle.
     * @param originLat      the latitude of the origin point
     * @param originLon      the longitude of the origin point
     * @param destinationLat the latitude of the destination point
     * @param destinationLon the longitude of the destination point
     * @param departureTime  the departure time
     * @return the route or bad request if the request is invalid (not an electric vehicle)
     * @throws IOException
     */
    @PostMapping("/getRoute")
    public ResponseEntity<?> getRoute(
            @RequestHeader("Authorization") String auth,
            @RequestParam Integer vehicleId,
            @RequestParam Double originLat,
            @RequestParam Double originLon,
            @RequestParam Double destinationLat,
            @RequestParam Double destinationLon,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime departureTime
    ) throws IOException {

        final Vehicle vehicle = vehicleApiService.getVehicle(auth, vehicleId);

        if (vehicle.getEnergy().equals(VehicleEnergy.PETROL) || vehicle.getEnergy().equals(VehicleEnergy.DIESEL)) {
            log.info("Vehicle is gas. Fine.");

            Root routes = hereRESTApiService.getEvRoute(auth, vehicle, originLat.toString(),
                    originLon.toString(),
                    destinationLat.toString(),
                    destinationLon.toString(),
                    departureTime,
                    "10000",
                    vehicle.getMaxCharge().toString(),
                    "1",
                    "10000",
                    "1",
                    vehicle.getFreeFlowSpeedTable(),
                    vehicle.getTraficSpeedTable(),
                    vehicle.getAuxiliaryConsumption().toString(),
                    vehicle.getAscent().toString(),
                    vehicle.getDescent().toString(),
                    vehicle.getChargingCurve(),
                    vehicle.getMaxChargingCurrent().toString(),
                    vehicle.getMaxChargingVoltage().toString(),
                    vehicle.getChargingSetupDuration().toString(),
                    vehicle.getConnectorType());

            return ResponseEntity.ok(routes.getRoutes());
        } else {
            log.info("Vehicle IS NOT gas. Err.");
            return ResponseEntity.badRequest().body("The vehicle Id you provided isn't an gas vehicle. Please use an gas vehicle with this routing function.");
        }
    }

    /**
     * Calculates a route between two points using the HERE Routing API.
     * This route will use only public transport systems & pedestrian routing.
     *
     * @param auth           Token the authentication token
     * @param originLat      the latitude of the origin point
     * @param originLon      the longitude of the origin point
     * @param destinationLat the latitude of the destination point
     * @param destinationLon the longitude of the destination point
     * @param departureTime  the departure time
     * @return the route or bad request if the request is invalid
     * @throws IOException
     */
    @PostMapping("/getTransitRoute")
    public ResponseEntity<?> getTransitRoute(
            @RequestHeader("Authorization") String auth,
            @RequestParam Double originLat,
            @RequestParam Double originLon,
            @RequestParam Double destinationLat,
            @RequestParam Double destinationLon,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime departureTime,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime arrivalTime
    ) throws IOException {

        Root root = hereRESTApiService.getTransitRoute(originLat.toString(),
                originLon.toString(),
                destinationLat.toString(),
                destinationLon.toString(),
                departureTime,
                arrivalTime,
                pedestrianSpeed.toString(),
                pedestrianMaxDistance.toString());

        return ResponseEntity.ok(root.getRoutes());
    }

    @PostMapping("/getRouteWithAllTravelSolutions")
    public ResponseEntity<?> getRouteWithAllTravelSolutions(
            @RequestHeader("Authorization") String auth,
            @RequestParam Double originLat,
            @RequestParam Double originLon,
            @RequestParam Double destinationLat,
            @RequestParam Double destinationLon
    ) throws IOException {
        //TODO MULTIHTREADING
        final ResponseEntity<?> evRouteModel3 = this.getEvRoute(auth, 22, originLat, originLon, destinationLat, destinationLon, null, null, null, null, null);
        final ResponseEntity<?> transitRoute = this.getTransitRoute(auth, originLat, originLon, destinationLat, destinationLon, null, null);
        final ResponseEntity<?> petrolRoute208 = this.getRoute(auth, 4, originLat, originLon, destinationLat, destinationLon, null);
        final ResponseEntity<?> dieselRoute2008 = this.getRoute(auth, 3, originLat, originLon, destinationLat, destinationLon, null);

        if(evRouteModel3.getStatusCode() != HttpStatus.OK ||
                transitRoute.getStatusCode() != HttpStatus.OK ||
                petrolRoute208.getStatusCode() != HttpStatus.OK
                || dieselRoute2008.getStatusCode() != HttpStatus.OK) {
            return ResponseEntity.internalServerError().body("Error with status codes : " + evRouteModel3.getStatusCode() + " and " + transitRoute.getStatusCode() + " and " + petrolRoute208.getStatusCode() + " and " + dieselRoute2008.getStatusCode());
        }

        final List<Route> routes = new ArrayList<>();
        routes.addAll((List<Route>) Objects.requireNonNull(evRouteModel3.getBody()));
        routes.addAll((List<Route>) Objects.requireNonNull(petrolRoute208.getBody()));
        routes.addAll((List<Route>) Objects.requireNonNull(dieselRoute2008.getBody()));
        routes.addAll((List<Route>) Objects.requireNonNull(transitRoute.getBody()));

        return ResponseEntity.ok(routes);
    }

    @PostMapping("/getBestVehicleForRoute")
    public ResponseEntity<?> getBestVehicleForRoute(
            @RequestHeader("Authorization") String auth,
            @RequestParam Double originLat,
            @RequestParam Double originLon,
            @RequestParam Double destinationLat,
            @RequestParam Double destinationLon,
            @RequestParam OrderCriteria orderCriteria
            ) throws IOException {

        final ResponseEntity<?> allTravelSolutions = this.getRouteWithAllTravelSolutions(auth, originLat, originLon, destinationLat, destinationLon);

        if(allTravelSolutions.getStatusCode() != HttpStatus.OK) {
            return ResponseEntity.internalServerError().body("Error with status codes : " + allTravelSolutions.getStatusCode());
        }

        final List<Route> routes = (List<Route>) allTravelSolutions.getBody();
        final Optional<Route> first = routes.parallelStream().min((o1, o2) -> {
            if (orderCriteria == OrderCriteria.DISTANCE) {
                return Comparator.comparing(Route::getLengthInMeters).compare(o1, o2);
            } else if (orderCriteria == OrderCriteria.PRICE) {
                return Comparator.comparing(Route::getPriceInEuros).compare(o1, o2);
            } else if (orderCriteria == OrderCriteria.TIME) {
                return Comparator.comparing(Route::getDurationInSeconds).compare(o1, o2);
            } else if (orderCriteria == OrderCriteria.CO2) {
                return Comparator.comparing(Route::getCo2inKg).compare(o1, o2);
            } else if (orderCriteria == OrderCriteria.CONSUMPTION) {
                return Comparator.comparing(Route::getConsumptionInWattsHours).compare(o1, o2);
            }
            return 0;
        });

        return first.<ResponseEntity<?>>map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.ok(new Route()));
    }
}
