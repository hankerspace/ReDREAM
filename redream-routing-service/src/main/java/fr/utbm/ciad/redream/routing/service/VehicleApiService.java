package fr.utbm.ciad.redream.routing.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.EurekaClient;
import com.netflix.discovery.shared.Application;
import fr.utbm.ciad.redream.vehicle.model.Vehicle;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

@Service
@Slf4j
public class VehicleApiService {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private EurekaClient eurekaClient;

    /**
     * Get the vehicle by its id
     * Requests the vehicle service using REST
     * @param auth Token
     * @param vehicleId Id of the vehicle
     * @return Vehicle
     * @throws HttpStatusCodeException the http status code exception
     * @throws JsonProcessingException the json processing exception
     */
    public Vehicle getVehicle(String auth, Integer vehicleId) throws HttpStatusCodeException, JsonProcessingException {
        Application application = eurekaClient.getApplication("vehicle-service");
        if (application.getInstances().size() == 0) {
            log.error("No vehicle service found");
            throw new HttpServerErrorException(HttpStatus.NOT_FOUND, "No vehicle service found");
        }
        InstanceInfo instanceInfo = application.getInstances().get(0);
        String url = "http://" + instanceInfo.getIPAddr() + ":" + instanceInfo.getPort() + "/" + vehicleId;

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", auth);
        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

        ResponseEntity<JSONObject> obj = this.restTemplate.exchange(url, HttpMethod.GET, request, JSONObject.class);
        log.info("HTTP response from vehicle-service : " + obj.getStatusCode());
        ObjectMapper m = new ObjectMapper();
        return m.readValue(obj.getBody().toString(), Vehicle.class);
    }
}
