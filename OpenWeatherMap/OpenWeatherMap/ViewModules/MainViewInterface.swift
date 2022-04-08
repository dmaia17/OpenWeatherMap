//
//  MainViewInterface.swift
//  OpenWeatherMap
//
//  Created by Daniel Maia dos Passos on 08/04/22.
//

import Foundation

enum MainViewField {
  case city
  case icon
  case weather
  case description
  case daily
  case wind
}

protocol MainViewProtocol: ViewInterface {
  func updateData(data: MainViewData)
}

protocol MainViewModelProtocol: ViewModelInterface {
  
}
