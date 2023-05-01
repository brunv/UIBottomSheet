//
//  BottomSheetViewController.swift
//  UIBottomSheet
//
//  Created by Bruno Vieira on 01/05/23.
//

import UIKit

class BottomSheetViewController: UIViewController {
    var sheetHeight: CGFloat = 400
    var sheetBackgroundColor: UIColor = .white
    var sheetCornerRadius: CGFloat = 22
    
    private var hasSetOriginPoint = false
    private var originPoint: CGPoint?
    
    // MARK: - Views
    
    let handleBar: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame.size.height = sheetHeight
        view.isUserInteractionEnabled = true
        view.backgroundColor = sheetBackgroundColor
        view.roundCorners(corners: [.topLeft, .topRight], radius: sheetCornerRadius)
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetOriginPoint {
            hasSetOriginPoint = true
            originPoint = view.frame.origin
        }
    }
    
    // MARK: - Setup
    
    func setupViews() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        
        view.addGestureRecognizer(panGesture)
        view.addSubview(handleBar)
        
        NSLayoutConstraint.activate([
            handleBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            handleBar.heightAnchor.constraint(equalToConstant: 5),
            handleBar.widthAnchor.constraint(equalToConstant: 35),
            handleBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    // MARK: - Gesture Recognizer
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
          let translation = sender.translation(in: view)

          // Not allowing the user to drag the view upward
          guard translation.y >= 0 else { return }

          view.frame.origin = CGPoint(
            x: 0,
            y: self.originPoint!.y + translation.y
          )

          if sender.state == .ended {
              let dragVelocity = sender.velocity(in: view)
              
              if dragVelocity.y >= 1300 {
                  // Fast enough to dismiss the uiview
                  self.dismiss(animated: true, completion: nil)
              } else {
                  // Set back to bottom sheet original position
                  UIView.animate(withDuration: 0.3) {
                      self.view.frame.origin = self.originPoint ?? CGPoint(x: 0, y: 400)
                  }
              }
          }
      }
}
