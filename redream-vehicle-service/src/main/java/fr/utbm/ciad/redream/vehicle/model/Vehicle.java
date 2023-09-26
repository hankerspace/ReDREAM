package fr.utbm.ciad.redream.vehicle.model;

import lombok.*;
import org.springframework.web.bind.annotation.RequestParam;

import javax.persistence.*;
import javax.validation.constraints.Size;

@Getter
@Setter
@Entity
@Table(name = "vehicle")
@Builder(builderMethodName = "vehicle")
@NoArgsConstructor
@AllArgsConstructor
public class Vehicle {

    @Id
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "type")
    private VehicleType type;

    @Column(name = "energy")
    private VehicleEnergy energy;

    @Column(name = "maxCharge")
    private Double maxCharge;

    @Column(name = "freeFlowSpeedTable")
    private String freeFlowSpeedTable;

    @Column(name = "traficSpeedTable")
    private String traficSpeedTable;

    @Column(name = "auxiliaryConsumption")
    private Double auxiliaryConsumption;

    @Column(name = "ascent")
    private Double ascent;

    @Column(name = "descent")
    private Double descent;

    @Column(name = "chargingCurve")
    private String chargingCurve;

    @Column(name = "maxChargingVoltage")
    private Double maxChargingVoltage;

    @Column(name = "maxChargingCurrent")
    private Double maxChargingCurrent;

    @Column(name = "chargingSetupDuration")
    private Integer chargingSetupDuration;

    @Column(name = "connectorType")
    private String connectorType;

    @Column(name = "whToLiterFactor")
    private Double whToLiterFactor;

    @Column(name = "literToCO2Factor")
    private Double literToCO2Factor;

    @Column(name = "elsewhereCO2Factor")
    private Double elsewhereCO2Factor;

    @Column(name = "metersToWhFactor")
    private Double metersToWhFactor;

    public Vehicle(Integer id, String name, String description, VehicleType type, VehicleEnergy energy) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.type = type;
        this.energy = energy;
    }
}
