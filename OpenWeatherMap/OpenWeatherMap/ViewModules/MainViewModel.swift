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
}

extension MainViewModel: MainViewModelProtocol {
  func viewDidLoad() {
    
  }
}

extension MainViewModel: WeatherServiceResponseProtocol {
  func getWeatherSuccess(response: WeatherResponseModel) {
    
  }
  
  func getWaatherError() {
    
  }
}
