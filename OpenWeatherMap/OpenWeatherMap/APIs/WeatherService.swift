//
//  WeatherService.swift
//  OpenWeatherMap
//
//  Created by Daniel Maia dos Passos on 08/04/22.
//

import Alamofire

protocol WeatherServiceProtocol {
  /**
   * Endpoint: https://api.openweathermap.org/data/2.5/weather?lat=LAT&lon=LON&appid=APPID
   * Type: GET
   */
  func getWeather(lat: Double, lon: Double)
}

protocol WeatherServiceResponseProtocol: AnyObject {
  func getWeatherSuccess(response: WeatherResponseModel)
  func getWeatherError()
}

class WeatherService: WeatherServiceProtocol {
  weak var delegate: WeatherServiceResponseProtocol?
  
  func getWeather(lat: Double, lon: Double) {
    let API_KEY = Constants.API_KEY
    
    AF.request("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(API_KEY)")
      .validate()
      .responseDecodable(of: WeatherResponseModel.self) { response in
        guard let response = response.value else {
          self.delegate?.getWeatherError()
          return
        }
        print(response)
        self.delegate?.getWeatherSuccess(response: response)
      }
  }
}
