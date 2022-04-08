//
//  WeatherResponseModel.swift
//  OpenWeatherMap
//
//  Created by Daniel Maia dos Passos on 08/04/22.
//

import Foundation

struct WeatherResponseModel: Codable {
  var name: String = ""
  var weather: [WeatherModel] = []
  var main: WeatherMainModel = WeatherMainModel()
  var wind: WeatherWindModel = WeatherWindModel()
}
