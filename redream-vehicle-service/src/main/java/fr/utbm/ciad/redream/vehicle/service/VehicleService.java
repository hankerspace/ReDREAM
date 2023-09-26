package fr.utbm.ciad.redream.vehicle.service;

import fr.utbm.ciad.redream.vehicle.model.Vehicle;
import fr.utbm.ciad.redream.vehicle.model.VehicleRepository;
import fr.utbm.ciad.redream.vehicle.model.VehicleType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import java.util.Optional;

@Service
public class VehicleService {

    @Autowired
    private VehicleRepository vehicleRepository;

    public Optional<Vehicle> getById(Integer id) {
        return vehicleRepository.findById(id);
    }

    public List<Vehicle> getByType(VehicleType type) {
        return vehicleRepository.findByType(type);
    }

    public List<Vehicle> getVehicles() {
        return vehicleRepository.findAll();
    }
}
