//
//  ImageSelector.swift
//  Mandala
//
//  Created by ZELIMKHAN MAGAMADOV on 17.08.2020.
//

import UIKit

class ImageSelector: UIControl {
  
  var highLightsColor: [UIColor] = [] {
    didSet {
      highLightView.backgroundColor = highlightColor(forIndex: selectedIndex)
    }
  }
  
  private let highLightView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let selectorStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .center
    stackView.spacing = 12
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private func configureViewHierarchy() {
    addSubview(selectorStackView)
    insertSubview(highLightView, belowSubview: selectorStackView)
    
    NSLayoutConstraint.activate([
      selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      selectorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      selectorStackView.topAnchor.constraint(equalTo: topAnchor),
      selectorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      highLightView.heightAnchor.constraint(equalTo: highLightView.widthAnchor),
      highLightView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
      highLightView.centerYAnchor.constraint(equalTo: selectorStackView.centerYAnchor)
    ])
    
  }
  
  private var highLightViewXConstraint: NSLayoutConstraint! {
    didSet(oldValue) {
      oldValue?.isActive = false
      highLightViewXConstraint.isActive = true
    }
  }
  
  var selectedIndex = 0 {
    didSet {
      if selectedIndex < 0 {
        selectedIndex = 0
      }
      if selectedIndex >= imageButtons.count {
        selectedIndex = imageButtons.count - 1
      }
      highLightView.backgroundColor = highlightColor(forIndex: selectedIndex)
      let imageButton = imageButtons[selectedIndex]
      highLightViewXConstraint = highLightView.centerXAnchor.constraint(equalTo: imageButton.centerXAnchor)
    }
  }
  
  private var imageButtons: [UIButton] = [] {
    didSet {
      oldValue.forEach { $0.removeFromSuperview() }
      imageButtons.forEach { selectorStackView.addArrangedSubview($0) }
    }
  }
  
  var images: [UIImage] = [] {
    didSet {
      imageButtons = images.map { image in
        let imageButton = UIButton()
        imageButton.setImage(image, for: .normal)
        imageButton.imageView?.contentMode = .scaleAspectFit
        imageButton.adjustsImageWhenHighlighted = false
        imageButton.addTarget(self, action: #selector(imageButtonTapped(_:)) , for: .touchUpInside)
        return imageButton
      }
      selectedIndex = 0
    }
  }
  
  private func highlightColor(forIndex index: Int) -> UIColor {
    guard index >= 0 && index < highLightsColor.count else {
      return UIColor.blue.withAlphaComponent(0.6)
    }
    return highLightsColor[index]
  }
  
  @objc private func imageButtonTapped(_ sender: UIButton) {
    guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
      preconditionFailure("This button not yet!")
    }
    
    let selectionAmimator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.6) {
      self.selectedIndex = buttonIndex
      self.layoutIfNeeded()
    }
    
    selectionAmimator.startAnimation()
    sendActions(for: .valueChanged)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    highLightView.layer.cornerRadius = highLightView.bounds.width / 2.0
    print("сработала функция \(#function)")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViewHierarchy()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configureViewHierarchy()
  }
}
