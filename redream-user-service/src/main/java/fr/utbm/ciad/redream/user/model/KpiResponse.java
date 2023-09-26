package fr.utbm.ciad.redream.user.model;

import fr.utbm.ciad.redream.vehicle.model.Vehicle;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class KpiResponse {
    private String userId;
    private Vehicle vehicle;

    private List<KpiRecord> records = new ArrayList<>();

    public KpiResponse(String userId, Vehicle vehicle) {
        this.userId = userId;
        this.vehicle = vehicle;
    }

    public void addRecord(KpiRecord record) {
        records.add(record);
    }
}
