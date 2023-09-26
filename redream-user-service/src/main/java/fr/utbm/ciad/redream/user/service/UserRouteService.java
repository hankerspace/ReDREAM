package fr.utbm.ciad.redream.user.service;

import fr.utbm.ciad.redream.user.model.UserRoute;
import fr.utbm.ciad.redream.user.model.UserRouteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class UserRouteService {

    @Autowired
    private UserRouteRepository userRouteRepository;

    /**
     * It saves a route to the database.
     *
     * @param userId the user's id
     * @param dateTime the date and time of the route
     * @param vehicleId The id of the vehicle used to travel the route.
     * @param consumptionInWattsHours The consumption of the vehicle in watts hours.
     * @param lengthInMeters The length of the route in meters.
     * @param durationInSeconds The duration of the route in seconds.
     * @param co2inKg The CO2 in Kg of the route
     * @param priceInEuros the price of the route in euros
     * @param correctiveFactor This is the factor that will be used to calculate the CO2 in Kg.
     * @return The id of the saved route.
     */
    public Integer saveRoute(String userId, LocalDateTime dateTime, Integer vehicleId, double consumptionInWattsHours, double lengthInMeters, double durationInSeconds, double co2inKg, double priceInEuros, double correctiveFactor) {
        UserRoute route = new UserRoute(
                userId,
                dateTime,
                vehicleId,
                consumptionInWattsHours,
                lengthInMeters,
                durationInSeconds,
                co2inKg,
                priceInEuros,
                correctiveFactor
        );
        final UserRoute saved = userRouteRepository.save(route);
        return saved.getId();
    }

    /**
     * Get a user route by id
     *
     * @param id The id of the route to be retrieved.
     * @return The route.
     */
    public UserRoute getRoute(Integer id) {
        return userRouteRepository.getById(id);
    }

    /**
     * Find all the routes for a user between two dates
     *
     * @param userId The user's ID
     * @param startDateTime The start date and time of the range of dates and times to search for.
     * @param endDateTime The end date and time of the range of dates and times to search for.
     * @return A list of UserRoute objects.
     */
    public List<UserRoute> getRoutesBetween(String userId, LocalDateTime startDateTime, LocalDateTime endDateTime) {
        return userRouteRepository.findByUserIdAndDateTimeIsBetween(userId, startDateTime, endDateTime);
    }

    /**
     * Given a userId, return a list of all the routes that user has created
     *
     * @param userId The user's ID.
     * @return A list of UserRoute objects.
     */
    public List<UserRoute> getRoutesForUser(String userId) {
        return userRouteRepository.findByUserId(userId);
    }

}
