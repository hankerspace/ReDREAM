package fr.utbm.ciad.redream.routing.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.EurekaClient;
import com.netflix.discovery.shared.Application;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

@Service
@Slf4j
public class PriceService {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private EurekaClient eurekaClient;

    public Double getPetrolPricePerLiterInEur(String auth, Double lat, Double lon) throws HttpStatusCodeException, JsonProcessingException {
        Application application = eurekaClient.getApplication("energy-service");
        InstanceInfo instanceInfo = application.getInstances().get(0);
        String url = "http://" + instanceInfo.getIPAddr() + ":" + instanceInfo.getPort() + "/" + "getPetrolLiterEurPrice" + "?" + "lat=" + lat + "&lon=" + lon;

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", auth);
        MultiValueMap<String, String> map= new LinkedMultiValueMap<>();
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

        ResponseEntity<Double> obj = this.restTemplate.exchange(url, HttpMethod.GET, request, Double.class);
        log.info("HTTP response from energy-service : " + obj.getStatusCode());
        return obj.getBody();
    }

    public Double getDieselPricePerLiterInEur(String auth, Double lat, Double lon) throws HttpStatusCodeException, JsonProcessingException {
        Application application = eurekaClient.getApplication("energy-service");
        InstanceInfo instanceInfo = application.getInstances().get(0);
        String url = "http://" + instanceInfo.getIPAddr() + ":" + instanceInfo.getPort() + "/" + "getDieselLiterEurPrice" + "?" + "lat=" + lat + "&lon=" + lon;

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", auth);
        MultiValueMap<String, String> map= new LinkedMultiValueMap<>();
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

        ResponseEntity<Double> obj = this.restTemplate.exchange(url, HttpMethod.GET, request, Double.class);
        log.info("HTTP response from energy-service : " + obj.getStatusCode());
        return obj.getBody();
    }

    public Double getKwhPriceInEur(String auth, Double lat, Double lon) throws HttpStatusCodeException, JsonProcessingException {
        Application application = eurekaClient.getApplication("energy-service");
        InstanceInfo instanceInfo = application.getInstances().get(0);
        String url = "http://" + instanceInfo.getIPAddr() + ":" + instanceInfo.getPort() + "/" + "getKwhEurPrice" + "?" + "lat=" + lat + "&lon=" + lon;

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", auth);
        MultiValueMap<String, String> map= new LinkedMultiValueMap<>();
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

        ResponseEntity<Double> obj = this.restTemplate.exchange(url, HttpMethod.GET, request, Double.class);
        log.info("HTTP response from energy-service : " + obj.getStatusCode());
        return obj.getBody();
    }
}
