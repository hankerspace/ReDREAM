package fr.utbm.ciad.redream.energy;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@EnableDiscoveryClient
@EnableFeignClients
@SpringBootApplication
public class EnergyServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(EnergyServiceApplication.class, args);
    }
}
