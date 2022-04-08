//
//  ViewController.swift
//  OpenWeatherMap
//
//  Created by Daniel Maia dos Passos on 08/04/22.
//

import UIKit
import SGImageCache
import CoreLocation

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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.viewWillAppear(animated: animated)
  }
}

extension ViewController: MainViewProtocol {
  func updateData(field: MainViewField, data: String) {
    switch field {
    case .city:
      cityLabel.text = data
    case .icon:
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
  
  func showAlert(title: String, message: String, doneButtonTitle: String, doneCallback: @escaping () -> Void) {
    let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    refreshAlert.addAction(UIAlertAction(title: doneButtonTitle, style: .default, handler: { (action: UIAlertAction!) in
      doneCallback()
    }))
    
    present(refreshAlert, animated: true, completion: nil)
  }
}

