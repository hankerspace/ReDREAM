package fr.utbm.ciad.redream.user.service;

import fr.utbm.ciad.redream.user.model.KpiRecord;
import fr.utbm.ciad.redream.user.model.KpiResponse;
import fr.utbm.ciad.redream.user.model.UserRecord;
import fr.utbm.ciad.redream.user.model.UserRecordRepository;
import fr.utbm.ciad.redream.vehicle.model.Vehicle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class UserRecordService {

    @Autowired
    private UserRecordRepository userRecordRepository;

    /**
     * It saves a record to the database.
     *
     * @param userId   the user's id
     * @param vehicle  The the vehicle used to travel the route.
     * @param dateTime the date and time of the route
     * @param kms      the kms on the counter
     * @return The id of the saved route.
     */
    public KpiResponse saveKms(String userId, LocalDateTime dateTime, Vehicle vehicle, double kms) {
        final List<UserRecord> lastRecords = userRecordRepository.findByUserIdAndVehicleIdOrderByIdDesc(userId, vehicle.getId());
        UserRecord userRecord = new UserRecord(userId, dateTime, vehicle.getId(), kms);
        final UserRecord saved = userRecordRepository.save(userRecord);

        final KpiResponse kpiResponse = new KpiResponse(userId, vehicle);

        LocalDateTime previousDateTime = saved.getDateTime();
        double previousKms = saved.getKms();
        if (!lastRecords.isEmpty()) {
            for(UserRecord lastRecord : lastRecords.subList(0, Math.min(lastRecords.size(), 5))){ // 5 last records
                // Create KpiResponse based on last record and saved record
                final double duration = Duration.between(lastRecord.getDateTime(), previousDateTime).toMillis() / 1000d;
                final KpiRecord kpiRecord = new KpiRecord(vehicle, duration, lastRecord.getKms(), previousKms, lastRecord.getDateTime());
                kpiResponse.addRecord(kpiRecord);

                // Update previous values
                previousDateTime = lastRecord.getDateTime();
                previousKms = lastRecord.getKms();
            }
        }
        return kpiResponse;
    }

    public KpiResponse getRecords(String userId,Vehicle vehicle) {
        final KpiResponse kpiResponse = new KpiResponse(userId, vehicle);
        final List<UserRecord> records = userRecordRepository.findByUserIdAndVehicleIdOrderByIdDesc(userId, vehicle.getId());

        LocalDateTime previousDateTime = null;
        double previousKms = 0.0d;
        for(UserRecord lastRecord : records){
            // Create KpiResponse based on last record and saved record
            if(previousDateTime != null) {
                final double duration = Duration.between(lastRecord.getDateTime(), previousDateTime).toMillis() / 1000d;
                final KpiRecord kpiRecord = new KpiRecord(vehicle, duration, lastRecord.getKms(), previousKms, lastRecord.getDateTime());
                kpiResponse.addRecord(kpiRecord);

            }
            // Update previous values
            previousDateTime = lastRecord.getDateTime();
            previousKms = lastRecord.getKms();
        }
        return kpiResponse;
    }


}
