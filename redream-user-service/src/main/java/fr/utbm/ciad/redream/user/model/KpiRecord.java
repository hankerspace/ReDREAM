package fr.utbm.ciad.redream.user.model;

import fr.utbm.ciad.redream.vehicle.model.Vehicle;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class KpiRecord {

    private double initialKm;
    private double finalKm;
    private LocalDateTime recordDate;
    private double durationBetweenRecordsInSeconds;
    private double kmsBetweenRecords;
    private double averageSpeedInKmPerHour;
    private double co2EmissionInKg;
    private double litersOfFuelConsumed;
    private double wattsHoursConsumed;

    private double trees;

    public KpiRecord(Vehicle vehicle, double durationBetweenRecordsInSeconds, double initialKm, double finalKm, LocalDateTime recordDate) {
        this.initialKm = initialKm;
        this.finalKm = finalKm;
        this.recordDate = recordDate;
        this.durationBetweenRecordsInSeconds = durationBetweenRecordsInSeconds;
        this.kmsBetweenRecords = this.finalKm - this.initialKm;
        this.durationBetweenRecordsInSeconds = durationBetweenRecordsInSeconds;
        this.averageSpeedInKmPerHour = this.kmsBetweenRecords / (durationBetweenRecordsInSeconds / 3600d);
        this.wattsHoursConsumed = vehicle.getMetersToWhFactor() * this.kmsBetweenRecords * 1000d;
        this.litersOfFuelConsumed = vehicle.getWhToLiterFactor() * this.wattsHoursConsumed;
        this.co2EmissionInKg = vehicle.getLiterToCO2Factor() * this.litersOfFuelConsumed;
        this.trees = 0.025d*this.co2EmissionInKg/1000d;
    }


}
