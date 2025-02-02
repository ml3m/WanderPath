import SwiftUI
import CoreLocation
import Firebase

struct WeatherView: View {
    @State private var city: String = "Timisoara" // Default city
    @State private var temperature: String = "Loading..."
    @State private var condition: String = "Loading..."
    @State private var locationManager = CLLocationManager()
    @State private var latitude: Double?
    @State private var longitude: Double?
    
    // Create an instance of the coordinator
    private var coordinator: Coordinator?

    
    var body: some View {
        VStack {
            Text("Weather Info")
                .font(.largeTitle)
                .padding()
            
            Text("City: \(city)")
                .font(.title)
            Text("Temperature: \(temperature)°C")
                .font(.title2)
            Text("Condition: \(condition)")
                .font(.title3)
        }
        .padding()
        .navigationTitle("Weather")
        .onAppear {
            // Initialize the coordinator and set the delegate
            self.coordinator = Coordinator(parent: self)
            locationManager.delegate = coordinator
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        .onChange(of: latitude) { _ in
            if let lat = latitude, let lon = longitude {
                fetchWeatherData(latitude: lat, longitude: lon)
            }
        }
    }
    
    // MARK: - Fetch Weather Data from API
    func fetchWeatherData(latitude: Double, longitude: Double) {
        let apiKey = "2b58439122d9f38bdb2a7a027b2bdc65"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                Logger.shared.log("Error fetching weather data: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.temperature = String(format: "%.0f", weatherResponse.main.temp)
                        self.condition = weatherResponse.weather.first?.description ?? "Unknown"
                    }
                } catch {
                    Logger.shared.log("Error decoding weather data: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    // MARK: - Weather API Response Models
    struct WeatherResponse: Codable {
        let weather: [Weather]
        let main: Main
    }

    struct Weather: Codable {
        let description: String
    }

    struct Main: Codable {
        let temp: Double
    }
    
    // MARK: - Coordinator Class
    class Coordinator: NSObject, CLLocationManagerDelegate {
        var parent: WeatherView
        
        init(parent: WeatherView) {
            self.parent = parent
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.first else { return }
            
            parent.latitude = location.coordinate.latitude
            parent.longitude = location.coordinate.longitude
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            Logger.shared.log("Failed to get location: \(error.localizedDescription)")
        }
    }
}
