package fr.utbm.ciad.redream.user.model;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RoutesSummary {
    private int nbRoutes;
    private double averageConsumptionInWattsHours;
    private double averageLengthInMeters;
    private double averageDurationInSeconds;
    private double averageCo2inKg;
    private double averagePriceInEuros;
    private double averageCorrectiveFactor;
}
