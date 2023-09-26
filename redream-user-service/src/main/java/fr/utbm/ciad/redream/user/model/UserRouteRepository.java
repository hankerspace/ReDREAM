package fr.utbm.ciad.redream.user.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface UserRouteRepository extends JpaRepository<UserRoute, Integer> {
    List<UserRoute> findByUserId(String userId);

    List<UserRoute> findByUserIdAndDateTimeIsBetween(String userId, LocalDateTime dateTimeStart, LocalDateTime dateTimeEnd);

}
