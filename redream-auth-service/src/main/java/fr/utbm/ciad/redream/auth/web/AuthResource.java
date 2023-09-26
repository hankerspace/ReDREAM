package fr.utbm.ciad.redream.auth.web;

import io.micrometer.core.annotation.Timed;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContext;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequiredArgsConstructor
@Slf4j
@Timed("redream.auth")
class AuthResource {

    @Autowired
    private RestTemplate restTemplate;

    @Value("${keycloak.auth-server-url}")
    private String authServerUrl;
    @Value("${keycloak.realm}")
    private String realm;
    @Value("${keycloak.resource}")
    private String resource;
    @Value("${redream.keycloak.client-secret}")
    private String clientSecret;

    @GetMapping("/test")
    public String getTest() {
        return "test"; // TODO FIXME
    }

    @RequestMapping(value = "/getToken",
            method = {RequestMethod.GET, RequestMethod.POST},
            produces = "application/json"
    )
    public String getToken(@RequestParam String username, @RequestParam String password) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> map= new LinkedMultiValueMap<>();
        map.add("client_id", resource);
        map.add("client_secret", clientSecret);
        map.add("username", username);
        map.add("password", password);
        map.add("grant_type", "password");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

        ResponseEntity<String> response = restTemplate.postForEntity( authServerUrl + "/realms/" + realm + "/protocol/openid-connect/token", request , String.class );
        return response.getBody();
    }

    @RequestMapping(value = "/getUser",
            method = {RequestMethod.GET, RequestMethod.POST},
            produces = "application/json"
    )
    public String getUser(@RequestHeader("Authorization") String auth) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", auth);
        MultiValueMap<String, String> map= new LinkedMultiValueMap<>();

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

        ResponseEntity<String> response = restTemplate.postForEntity( authServerUrl + "/realms/" + realm + "/protocol/openid-connect/userinfo", request , String.class );
        return response.getBody();
    }

}
