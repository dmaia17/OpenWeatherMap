//
//  ViewInterface.swift
//  OpenWeatherMap
//
//  Created by Daniel Maia dos Passos on 08/04/22.
//

import Foundation
import UIKit

protocol ViewInterface: AnyObject {
  func fullScreenLoading(hide: Bool)
}

extension ViewInterface where Self: UIViewController {
  func fullScreenLoading(hide: Bool) {
    let tag = 99
    if hide {
      for views in self.view.subviews where views.tag == tag {
        for activity in views.subviews where activity is UIActivityIndicatorView {
          views.removeFromSuperview()
        }
      }
    } else {
      let screenSize = UIScreen.main.bounds
      let screenWidth = screenSize.width
      let screenHeight = screenSize.height
      let view = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
      view.backgroundColor = UIColor.white
      view.tag = tag
      
      let activityIndicator = UIActivityIndicatorView()
      
      activityIndicator.startAnimating()
      view.addSubview(activityIndicator)
      
      activityIndicator.center =  view.center
      
      self.view.addSubview(view)
    }
  }
}
