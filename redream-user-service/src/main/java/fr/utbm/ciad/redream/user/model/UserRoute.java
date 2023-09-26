package fr.utbm.ciad.redream.user.model;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "user_route")
@Builder(builderMethodName = "user_route")
@NoArgsConstructor
@AllArgsConstructor
public class UserRoute {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    @Column(name = "user_id")
    private String userId;

    @Column(name = "datetime")
    private LocalDateTime dateTime;

    @Column(name = "vehicle_id")
    private Integer vehicleId;

    @Column(name = "consumption")
    private double consumptionInWattsHours;

    @Column(name = "length")
    private double lengthInMeters;

    @Column(name = "duration")
    private double durationInSeconds;

    @Column(name = "co2")
    private double co2inKg;

    @Column(name = "price")
    private double priceInEuros;

    @Column(name = "correctiveFactor")
    private double correctiveFactor;

    public UserRoute(String userId, LocalDateTime dateTime, Integer vehicleId, double consumptionInWattsHours, double lengthInMeters, double durationInSeconds, double co2inKg, double priceInEuros, double correctiveFactor) {
        this.userId = userId;
        this.dateTime = dateTime;
        this.vehicleId = vehicleId;
        this.consumptionInWattsHours = consumptionInWattsHours;
        this.lengthInMeters = lengthInMeters;
        this.durationInSeconds = durationInSeconds;
        this.co2inKg = co2inKg;
        this.priceInEuros = priceInEuros;
        this.correctiveFactor = correctiveFactor;
    }
}
