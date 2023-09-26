package fr.utbm.ciad.redream.user.configuration;

import fr.utbm.ciad.redream.user.model.UserRecord;
import fr.utbm.ciad.redream.user.model.UserRecordRepository;
import fr.utbm.ciad.redream.user.model.UserRouteRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Configuration
public class LoadDatabase {

    final private String USER_ID = "testUser";
    final private Integer VEHICLE_ID = 3;

    @Bean
    public CommandLineRunner initDatabase(UserRecordRepository repository) {
        log.info("Populating database...");
        //Clear test user records
        repository.deleteAll(repository.findByUserId(USER_ID));
        repository.save(new UserRecord(USER_ID, LocalDateTime.now().minusDays(30), VEHICLE_ID, 10000.0));
        repository.save(new UserRecord(USER_ID, LocalDateTime.now().minusDays(20), VEHICLE_ID, 15000.0));
        repository.save(new UserRecord(USER_ID, LocalDateTime.now().minusDays(10), VEHICLE_ID, 18000.0));
        repository.save(new UserRecord(USER_ID, LocalDateTime.now().minusDays(1), VEHICLE_ID, 20000.0));


        return args -> {
            log.info("Preloading done.");
        };

    }
}
