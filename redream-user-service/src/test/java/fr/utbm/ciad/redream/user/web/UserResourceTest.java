package fr.utbm.ciad.redream.user.web;

import com.netflix.discovery.EurekaClient;
import fr.utbm.ciad.redream.user.service.UserRouteService;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.client.RestTemplate;


import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

@ExtendWith(SpringExtension.class)
@WebMvcTest(UserRouteResource.class)
@AutoConfigureMockMvc(addFilters = false) // Disable spring security & keycloak
@ActiveProfiles("test")
class UserResourceTest {

    @Autowired
    MockMvc mvc;

    @MockBean
    RestTemplate restTemplate;

    @MockBean
    EurekaClient eurekaClient;

    @MockBean
    UserRouteService userService;
//
//    @Test
//    void getByType() throws Exception {
//        given(userService.getByType(VehicleType.FOOT))
//            .willReturn(
//                asList(
//                        new User(4, "Walk", "Walk", VehicleType.FOOT, VehicleEnergy.HUMAN_POWERED)
//                )
//            );
//
//        mvc.perform(get("/type/FOOT"))
//            .andExpect(status().isOk())
//            .andExpect(jsonPath("$[0].id").value(4));
//    }
//
//    @Test
//    void getById() throws Exception {
//        given(userService.getById(4))
//                .willReturn(Optional.of(new User(4, "Walk", "Walk", VehicleType.FOOT, VehicleEnergy.HUMAN_POWERED)));
//
//
//        mvc.perform(get("/4"))
//                .andExpect(status().isOk())
//                .andExpect(jsonPath("$.id").value(4));
//    }
}
