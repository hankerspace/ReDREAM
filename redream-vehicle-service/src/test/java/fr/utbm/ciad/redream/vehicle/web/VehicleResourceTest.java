package fr.utbm.ciad.redream.vehicle.web;

import com.netflix.discovery.EurekaClient;
import fr.utbm.ciad.redream.vehicle.model.Vehicle;
import fr.utbm.ciad.redream.vehicle.model.VehicleEnergy;
import fr.utbm.ciad.redream.vehicle.model.VehicleType;
import fr.utbm.ciad.redream.vehicle.model.VehicleRepository;
import fr.utbm.ciad.redream.vehicle.service.VehicleService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.client.RestTemplate;


import java.util.Optional;

import static java.util.Arrays.asList;
import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(SpringExtension.class)
@WebMvcTest(VehicleResource.class)
@AutoConfigureMockMvc(addFilters = false) // Disable spring security & keycloak
@ActiveProfiles("test")
class VehicleResourceTest {

    @Autowired
    MockMvc mvc;

    @MockBean
    RestTemplate restTemplate;

    @MockBean
    EurekaClient eurekaClient;

    @MockBean
    VehicleService vehicleService;

    @Test
    void getByType() throws Exception {
        given(vehicleService.getByType(VehicleType.FOOT))
            .willReturn(
                asList(
                        new Vehicle(4, "Walk", "Walk", VehicleType.FOOT, VehicleEnergy.HUMAN_POWERED)
                )
            );

        mvc.perform(get("/type/FOOT"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$[0].id").value(4));
    }

    @Test
    void getById() throws Exception {
        given(vehicleService.getById(4))
                .willReturn(Optional.of(new Vehicle(4, "Walk", "Walk", VehicleType.FOOT, VehicleEnergy.HUMAN_POWERED)));


        mvc.perform(get("/4"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(4));
    }
}
