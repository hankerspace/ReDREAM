package fr.utbm.ciad.redream.user.model;

import com.netflix.discovery.converters.Auto;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

/**
 * This class represents a record of a user's vehicle usage
 */
@Getter
@Setter
@Entity
@Table(name = "user_record")
@Builder(builderMethodName = "user_record")
@NoArgsConstructor
@AllArgsConstructor
public class UserRecord {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    @Column(name = "user_id")
    private String userId;

    @Column(name = "datetime")
    private LocalDateTime dateTime;

    @Column(name = "vehicle_id")
    private Integer vehicleId;

    @Column(name = "kms")
    private double kms;

    public UserRecord(String userId, LocalDateTime dateTime, Integer vehicleId, double kms) {
        this.userId = userId;
        this.dateTime = dateTime;
        this.vehicleId = vehicleId;
        this.kms = kms;
    }
}
