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
  func updateData(field: MainViewField, data: String)
  func showAlert(title: String, message: String, doneButtonTitle: String, doneCallback: @escaping () -> Void)
}

protocol MainViewModelProtocol: ViewModelInterface {
  
}
