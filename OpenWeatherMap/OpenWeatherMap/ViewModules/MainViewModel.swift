//
//  MainViewModel.swift
//  OpenWeatherMap
//
//  Created by Daniel Maia dos Passos on 08/04/22.
//

import Foundation
import CoreLocation
import UIKit

class MainViewModel: NSObject {
  var service: WeatherServiceProtocol?
  weak var view: MainViewProtocol?
  private var data = WeatherResponseModel()
  private var locationManager = CLLocationManager()
  private var loaded = false
  
  private enum Strings {
    static let ErrorTitle = "Error"
    static let locationErrorMessage = "You need to authorize OpenWeatherMap to use your location."
    static let locationErrorDoneButton = "Settings"
    static let genericErrorMessage = "An error occourred."
    static let genericErrorDoneButton = "Close"
    static let iconURL = "http://openweathermap.org/img/wn/%@@2x.png"
    static let weatherFormat = "%@°"
    static let dailyFormat = "Low: %@° High: %@°"
    static let windFormat = "Wind: %@ (%@)"
  }
  
  private func configureUI() {
    if data.weather.isEmpty {
      showError()
      return
    }
    
    let dailyValue = String(format: Strings.dailyFormat, String(format: "%.0f", data.main.temp_min), String(format: "%.0f", data.main.temp_max))
    let windValue = String(format: Strings.windFormat, String(format: "%.0f", data.wind.speed), String(format: "%.0f", data.wind.deg))
    
    view?.updateData(field: .city, data: data.name)
    view?.updateData(field: .icon, data: String(format: Strings.iconURL, data.weather[0].icon))
    view?.updateData(field: .weather, data: String(format: Strings.weatherFormat, String(format: "%.0f", data.main.temp)))
    view?.updateData(field: .description, data: data.weather[0].description)
    view?.updateData(field: .daily, data: dailyValue)
    view?.updateData(field: .wind, data: windValue)
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
  
  private func showError() {
    view?.showAlert(title: Strings.ErrorTitle, message: Strings.genericErrorMessage, doneButtonTitle: Strings.genericErrorDoneButton, doneCallback: {
      exit(0) //TODO: Improve
    })
  }
  
  private func showLocationError() {
    view?.showAlert(title: Strings.ErrorTitle, message: Strings.locationErrorMessage, doneButtonTitle: Strings.locationErrorDoneButton, doneCallback: {
      UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:],
                                completionHandler: { _ in
        exit(0) //TODO: Improve
      })
    })
  }
}

extension MainViewModel: MainViewModelProtocol {
  func viewDidLoad() {
    view?.fullScreenLoading(hide: false)
    
    configureLocation()
  }
  
  func viewWillAppear(animated: Bool) {
    if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
      showLocationError()
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
    showError()
  }
}

extension MainViewModel: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if !loaded {
      guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else {
        showError()
        return
      }
      
      service?.getWeather(lat: coordinate.latitude, lon: coordinate.longitude)
      loaded = true
    }
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
      showLocationError()
    }
  }
}
