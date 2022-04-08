//
//  WeatherModel.swift
//  OpenWeatherMap
//
//  Created by Daniel Maia dos Passos on 08/04/22.
//

import Foundation

struct WeatherModel: Codable {
  var id: Int = 0
  var main: String = ""
  var description: String = ""
  var icon: String = ""
}
