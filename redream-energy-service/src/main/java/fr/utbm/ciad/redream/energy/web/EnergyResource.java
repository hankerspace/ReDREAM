package fr.utbm.ciad.redream.energy.web;

import io.micrometer.core.annotation.Timed;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@Slf4j
@Timed("redream.energy")
class EnergyResource {

    @GetMapping("/test")
    public String getTest() {
        return "test"; // TODO FIXME
    }

    @GetMapping("/testProtected")
    public String getTestProtected() {
        return "testProtected"; // TODO FIXME
    }

    @GetMapping("/getKwhEurPrice")
    public Double getKwhEurPrice(@RequestParam Double lat,
                                 @RequestParam Double lon) {
        return 0.22; // TODO FIXME
    }

    @GetMapping("/getPetrolLiterEurPrice")
    public Double getPetrolLiterEurPrice(@RequestParam Double lat,
                                         @RequestParam Double lon) {
        return 2.0; // TODO FIXME
    }

    @GetMapping("/getDieselLiterEurPrice")
    public Double getDieselLiterEurPrice(@RequestParam Double lat,
                                         @RequestParam Double lon) {
        return 1.8; // TODO FIXME
    }
}
