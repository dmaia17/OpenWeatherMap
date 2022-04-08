//
//  ViewModelInterface.swift
//  OpenWeatherMap
//
//  Created by Daniel Maia dos Passos on 08/04/22.
//

import Foundation

protocol ViewModelInterface: AnyObject {
  func viewDidLoad()
  func viewWillAppear(animated: Bool)
  func viewDidAppear(animated: Bool)
  func viewWillDisappear(animated: Bool)
  func viewDidDisappear(animated: Bool)
}

extension ViewModelInterface {
  func viewDidLoad() {
    fatalError("Implementation pending...")
  }
  
  func viewWillAppear(animated: Bool) {
    fatalError("Implementation pending...")
  }
  
  func viewDidAppear(animated: Bool) {
    fatalError("Implementation pending...")
  }
  
  func viewWillDisappear(animated: Bool) {
    fatalError("Implementation pending...")
  }
  
  func viewDidDisappear(animated: Bool) {
    fatalError("Implementation pending...")
  }
}
