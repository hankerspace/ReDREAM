package fr.utbm.ciad.redream.user.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRecordRepository extends JpaRepository<UserRecord, Integer> {
    List<UserRecord> findByUserId(String userId);

    List<UserRecord> findByUserIdAndDateTimeIsBetween(String userId, LocalDateTime dateTimeStart, LocalDateTime dateTimeEnd);

    Optional<UserRecord> findFirstByUserIdAndVehicleIdOrderByIdDesc(String userId, Integer vehicleId);

    List<UserRecord> findByUserIdAndVehicleIdOrderByIdDesc(String userId, Integer vehicleId);



}
