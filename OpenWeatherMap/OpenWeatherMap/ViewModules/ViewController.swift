//
//  ViewController.swift
//  OpenWeatherMap
//
//  Created by Daniel Maia dos Passos on 08/04/22.
//

import UIKit
import SGImageCache

class ViewController: UIViewController {
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var weatherImageView: UIImageView!
  @IBOutlet weak var weatherLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var dailyWeatherLabel: UILabel!
  @IBOutlet weak var windLabel: UILabel!
  
  var viewModel: MainViewModelProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewDidLoad()
  }
}

extension ViewController: MainViewProtocol {
  func updateData(field: MainViewField, data: String) {
    switch field {
    case .city:
      cityLabel.text = data
    case .icon:
      print(data)
      weatherImageView.setImageForURL(data)
    case .weather:
      weatherLabel.text = data
    case .description:
      descriptionLabel.text = data
    case .daily:
      dailyWeatherLabel.text = data
    case .wind:
      windLabel.text = data
    }
  }
}

