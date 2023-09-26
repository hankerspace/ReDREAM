package fr.utbm.ciad.redream.vehicle.configuration;

import com.fasterxml.jackson.databind.Module;
import com.fasterxml.jackson.datatype.hibernate5.Hibernate5Module;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.web.client.RestTemplate;

import javax.persistence.EntityManagerFactory;

@Configuration
@ComponentScan("fr.utbm.ciad.redream.core")
@EnableAutoConfiguration
public class Config {
    @Bean
    public RestTemplate restTemplate(RestTemplateBuilder builder) {
        // Do any additional configuration here
        return builder.build();
    }

    // Fix 2021-11-08 15:47:31.520  WARN [vehicle-service,0692ec70dd803b57,f1146504548bd1df] 8080 --- [io-8083-exec-12] .w.s.m.s.DefaultHandlerExceptionResolver : Resolved [org.springframework.http.converter.HttpMessageNotWritableException: Could not write JSON: could not initialize proxy [fr.utbm.ciad.redream.vehicle.model.Vehicle#2] - no Session; nested exception is com.fasterxml.jackson.databind.JsonMappingException: could not initialize proxy [fr.utbm.ciad.redream.vehicle.model.Vehicle#2] - no Session (through reference chain: fr.utbm.ciad.redream.vehicle.model.Vehicle$HibernateProxy$2qOtoorK["name"])]
    //https://stackoverflow.com/questions/26957554/jsonmappingexception-could-not-initialize-proxy-no-session
    @Bean
    public Module datatypeHibernateModule() {
        return new Hibernate5Module();
    }
}
