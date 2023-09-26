package fr.utbm.ciad.redream.user.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.netflix.discovery.EurekaClient;
import fr.utbm.ciad.redream.user.model.KpiResponse;
import fr.utbm.ciad.redream.user.service.UserRecordService;
import fr.utbm.ciad.redream.user.service.VehicleApiService;
import fr.utbm.ciad.redream.vehicle.model.Vehicle;
import io.micrometer.core.annotation.Timed;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;

@RestController
@RequiredArgsConstructor
@Slf4j
@Timed("redream.vehicle")
class UserRecordResource {
    private static final Logger LOG = LoggerFactory.getLogger(UserRecordResource.class);

    @Autowired
    private final RestTemplate restTemplate;

    @Autowired
    private EurekaClient eurekaClient;

    @Autowired
    private UserRecordService userRecordService;

    @Autowired
    private VehicleApiService vehicleApiService;


    /**
     * It saves a route.
     *
     * @param userId    the id of the user who is saving the route
     * @param vehicleId The id of the vehicle that the route is associated with.
     * @param dateTime  The start time of the route. It is a string in the format "yyyy-MM-dd HH:mm:ss"
     * @param kms       The number of kilometers on the user vehicle.
     * @return The route id.
     */
    @PostMapping("/saveKms")
    public KpiResponse saveKms(
            @RequestHeader(value = "Authorization", required = false) String auth,
            @RequestParam String userId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateTime,
            @RequestParam Integer vehicleId,
            @RequestParam double kms) throws JsonProcessingException {
        if (dateTime == null) dateTime = LocalDateTime.now();
        final Vehicle vehicle = vehicleApiService.getVehicle(auth, vehicleId);
        return userRecordService.saveKms(userId, dateTime, vehicle, kms);
    }

    @PostMapping("/getRecords")
    public KpiResponse getRecords(
            @RequestHeader(value = "Authorization", required = false) String auth,
            @RequestParam String userId,
            @RequestParam Integer vehicleId) throws JsonProcessingException {
        final Vehicle vehicle = vehicleApiService.getVehicle(auth, vehicleId);
        return userRecordService.getRecords(userId, vehicle);
    }


}
