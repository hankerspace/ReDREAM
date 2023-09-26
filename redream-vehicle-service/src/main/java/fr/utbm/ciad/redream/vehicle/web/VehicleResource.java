package fr.utbm.ciad.redream.vehicle.web;

import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.EurekaClient;
import com.netflix.discovery.shared.Application;
import feign.Request;
import fr.utbm.ciad.redream.core.here.Route;
import fr.utbm.ciad.redream.vehicle.model.Vehicle;
import fr.utbm.ciad.redream.vehicle.model.VehicleType;
import fr.utbm.ciad.redream.vehicle.model.VehicleRepository;
import fr.utbm.ciad.redream.vehicle.service.VehicleService;
import io.micrometer.core.annotation.Timed;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@RestController
@RequiredArgsConstructor
@Slf4j
@Timed("redream.vehicle")
class VehicleResource {
    private static final Logger LOG = LoggerFactory.getLogger(VehicleResource.class);

    @Autowired
    private final RestTemplate restTemplate;

    @Autowired
    private EurekaClient eurekaClient;

    @Autowired
    private VehicleService vehicleService;

    @GetMapping("/test")
    public String getTest() {
        return "test"; // TODO FIXME
    }

    @GetMapping("/testProtected")
    public String getTestProtected() {
        return "testProtected"; // TODO FIXME
    }

    @GetMapping("/{id}")
    public Vehicle getById(@PathVariable("id") Integer id) {
        return vehicleService.getById(id).get(); // FIXME
    }

    @GetMapping("/type/{type}")
    public List<Vehicle> getByType(@PathVariable("type") VehicleType type) {
        return vehicleService.getByType(type);
    }

    @GetMapping("/kmPrice/{id}")
    public ResponseEntity<?> getKmPriceForId(@RequestHeader("Authorization") String auth, @PathVariable("id") Integer id) {
        log.info("Requesting energy service...");
        Application application = eurekaClient.getApplication("energy-service");
        InstanceInfo instanceInfo = application.getInstances().get(0);
        String url = "http://" + instanceInfo.getIPAddr() + ":" + instanceInfo.getPort() + "/" + "getKwhUsdCost";



        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", auth);
        MultiValueMap<String, String> map= new LinkedMultiValueMap<>();
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

        try {
            ResponseEntity<Double> obj = this.restTemplate.exchange(url, HttpMethod.GET, request, Double.class); // TODO CHANGE
            log.debug("HTTP response from energy-service : " + obj.getStatusCode());
            return ResponseEntity.ok(obj.getBody() * 10.0);
        } catch(HttpStatusCodeException e) {
            log.debug("HTTP Error from energy-service : " + e.getMessage());
            return ResponseEntity.status(e.getRawStatusCode()).headers(e.getResponseHeaders())
                    .body(e.getResponseBodyAsString());
        }
    }

    @GetMapping("/testRouting")
    public Route test() {
        LOG.info("Requesting routing service...");
        Application application = eurekaClient.getApplication("routing-service");
        InstanceInfo instanceInfo = application.getInstances().get(0);
        String url = "http://" + instanceInfo.getIPAddr() + ":" + instanceInfo.getPort() + "/" + "getEvRoute?";
        url += "originLat=47.64089741571929&";
        url += "originLon=6.847322180284904&";
        url += "destinationLat=47.026763231316835&";
        url += "destinationLon=4.839313553297435&";
        Route obj = this.restTemplate.postForObject(url, Request.HttpMethod.POST, Route.class); // TODO CHANGE
        return obj;
    }

    @GetMapping("/")
    public List<Vehicle> getVehicles() {
        return vehicleService.getVehicles();
    }

}
