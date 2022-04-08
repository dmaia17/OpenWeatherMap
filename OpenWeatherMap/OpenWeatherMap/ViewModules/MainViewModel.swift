//
//  MainViewModel.swift
//  OpenWeatherMap
//
//  Created by Daniel Maia dos Passos on 08/04/22.
//

import Foundation
import CoreLocation

class MainViewModel: NSObject {
  var service: WeatherServiceProtocol?
  weak var view: MainViewProtocol?
  private var data = WeatherResponseModel()
  private var locationManager = CLLocationManager()
  
  private func configureUI() {
    let weather: WeatherModel = data.weather[0]
    
    view?.updateData(field: .city, data: data.name)
    view?.updateData(field: .icon, data: "http://openweathermap.org/img/wn/\(weather.icon)@2x.png")
    view?.updateData(field: .weather, data: String(data.main.temp))
    view?.updateData(field: .description, data: data.weather.description)
    view?.updateData(field: .daily, data: "\(data.main.temp_min) - \(data.main.temp_max)")
    view?.updateData(field: .wind, data: "\(data.wind.speed) - \(data.wind.deg)")
  }
  
  private func configureLocation() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager = CLLocationManager()
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestAlwaysAuthorization()
      locationManager.distanceFilter = 100
      locationManager.startUpdatingLocation()
    }
  }
}

extension MainViewModel: MainViewModelProtocol {
  func viewDidLoad() {
    view?.fullScreenLoading(hide: false)
    
    configureLocation()
    
    if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
      //TODO: Redirect to settings
    }
  }
}

extension MainViewModel: WeatherServiceResponseProtocol {
  func getWeatherSuccess(response: WeatherResponseModel) {
    data = response
    configureUI()
    view?.fullScreenLoading(hide: true)
  }
  
  func getWeatherError() {
    
  }
}

extension MainViewModel: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else { return }

    print(coordinate)
    service?.getWeather(lat: coordinate.latitude, lon: coordinate.longitude)
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    
    if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
      //TODO: Show error
    }
  }
}
