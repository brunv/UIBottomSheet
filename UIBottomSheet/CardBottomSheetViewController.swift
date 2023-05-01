//
//  CardBottomSheetViewController.swift
//  UIBottomSheet
//
//  Created by Bruno Vieira on 01/05/23.
//

import UIKit

class CardBottomSheetViewController: UIViewController {
    var sheetHeight: CGFloat = 200
    var horizontalPadding: CGFloat = 12
    var bottomPadding: CGFloat = 26
    
    private var hasSetOriginPoint = false
    private var originPoint: CGPoint?
    
    // MARK: - Views
    
    let cardView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        // iPhone's screen corner radius are not true circles, they're what we call "continuous curve".
        // In iOS 13 we can set `layer.cornerCurve` to `.continuous`, but we still don't have a way to
        // define the correct `cornerRadius` for each iPhone model.
        // You can get aproximate number from the community. See: https://github.com/kylebshr/ScreenCorners
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 47.33
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame.size.height = sheetHeight + bottomPadding
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        
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
        view.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomPadding),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding)
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
