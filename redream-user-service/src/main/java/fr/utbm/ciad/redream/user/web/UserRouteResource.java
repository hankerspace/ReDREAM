package fr.utbm.ciad.redream.user.web;

import com.netflix.discovery.EurekaClient;
import fr.utbm.ciad.redream.user.model.UserRoute;
import fr.utbm.ciad.redream.user.service.UserRouteService;
import io.micrometer.core.annotation.Timed;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;

@RestController
@RequiredArgsConstructor
@Slf4j
@Timed("redream.vehicle")
class UserRouteResource {
    private static final Logger LOG = LoggerFactory.getLogger(UserRouteResource.class);

    @Autowired
    private final RestTemplate restTemplate;

    @Autowired
    private EurekaClient eurekaClient;

    @Autowired
    private UserRouteService userService;


    /**
     * It saves a route.
     *
     * @param userId                  the id of the user who is saving the route
     * @param vehicleId               The id of the vehicle that the route is associated with.
     * @param consumptionInWattsHours the consumption of the vehicle in watts hours
     * @param lengthInMeters          The length of the route in meters.
     * @param durationInSeconds       The duration of the route in seconds.
     * @param co2inKg                 CO2 emissions in kilograms
     * @param priceInEuros            the price of the route in Euros
     * @param correctiveFactor        the corrective factor of the route
     * @return The route id.
     */
    @Deprecated
    @PostMapping("/saveRoute")
    public Integer saveRoute(
            @RequestParam String userId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateTime,
            @RequestParam Integer vehicleId,
            @RequestParam double consumptionInWattsHours,
            @RequestParam double lengthInMeters,
            @RequestParam double durationInSeconds,
            @RequestParam double co2inKg,
            @RequestParam double priceInEuros,
            @RequestParam(required = false) Double correctiveFactor) {
        if (correctiveFactor == null) correctiveFactor = 1.0;
        return userService.saveRoute(userId, dateTime, vehicleId, consumptionInWattsHours, lengthInMeters, durationInSeconds, co2inKg, priceInEuros, correctiveFactor);
    }

    /**
     * It gets the route with the given id.
     *
     * @param id The id of the route.
     * @return The route.
     */
    @Deprecated
    @GetMapping("/getRoute")
    public UserRoute getRoute(@RequestParam Integer id) {
        return userService.getRoute(id);
    }

    /**
     * It gets the routes of the user with the given id.
     *
     * @param userId The id of the user.
     * @return The routes.
     */
    @Deprecated
    @GetMapping("/getRoutes")
    public Iterable<UserRoute> getRoutes(@RequestParam String userId) {
        return userService.getRoutesForUser(userId);
    }


    /**
     * Get all the routes for a user between two dates
     *
     * @param userId The user's ID
     * @param start The start date/time of the range of routes to return.
     * @param end The end date/time of the range of routes to return.
     * @return A list of UserRoute objects.
     */
    @Deprecated
    @GetMapping("/getRoutesBetween")
    public Iterable<UserRoute> getRoutesBetween(@RequestParam String userId,
                                                @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime start,
                                                @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime end) {
        return userService.getRoutesBetween(userId, start, end);
    }


}
