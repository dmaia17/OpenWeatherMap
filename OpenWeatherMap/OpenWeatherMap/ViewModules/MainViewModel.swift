//
//  MainViewModel.swift
//  OpenWeatherMap
//
//  Created by Daniel Maia dos Passos on 08/04/22.
//

import Foundation

class MainViewModel {
  var service: WeatherServiceProtocol?
  weak var view: MainViewProtocol?
  private var data = WeatherResponseModel()
  
  private func configureUI() {
    let weather: WeatherModel = data.weather[0]
    
    view?.updateData(field: .city, data: data.name)
    view?.updateData(field: .icon, data: "http://openweathermap.org/img/wn/\(weather.icon)@2x.png")
    view?.updateData(field: .weather, data: String(data.main.temp))
    view?.updateData(field: .description, data: data.weather.description)
    view?.updateData(field: .daily, data: "\(data.main.temp_min) - \(data.main.temp_max)")
    view?.updateData(field: .wind, data: "\(data.wind.speed) - \(data.wind.deg)")
  }
  
}

extension MainViewModel: MainViewModelProtocol {
  func viewDidLoad() {
    view?.fullScreenLoading(hide: false)
    service?.getWeather(lat: 34.0194704, lon: -118.491227)
  }
}

extension MainViewModel: WeatherServiceResponseProtocol {
  func getWeatherSuccess(response: WeatherResponseModel) {
    data = response
    configureUI()
    view?.fullScreenLoading(hide: true)
  }
  
  func getWaatherError() {
    
  }
}
