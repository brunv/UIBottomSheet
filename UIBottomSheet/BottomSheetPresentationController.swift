//
//  BottomSheetPresentationController.swift
//  UIBottomSheet
//
//  Created by Bruno Vieira on 01/05/23.
//

import UIKit

class BottomSheetPresentationController: UIPresentationController {
    var blurStyle: UIBlurEffect.Style = .dark
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var blurEffectView: UIVisualEffectView!
    
    // MARK: - Init
    
    override init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        self.blurEffectView = setupBlurredView()
    }
    
    // MARK: - Setup
    
    private func setupBlurredView() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = true
        blurEffectView.addGestureRecognizer(tapGestureRecognizer)
        
        return blurEffectView
    }
    
    // MARK: - Presentation
    
    /// Get the frame of the sheet based on the containerView available space.
    override var frameOfPresentedViewInContainerView: CGRect {
        let sheetWidth = containerView!.frame.width
        let sheetHeight = presentedView!.frame.height
        
        return CGRect(
            origin: CGPoint(x: 0, y: containerView!.frame.height - sheetHeight),
            size: CGSize(width: sheetWidth, height: sheetHeight)
        )
    }
    
    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { _ in
                self.blurEffectView.alpha = 0.7
            }
        )
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { _ in
                self.blurEffectView.alpha = 0
            },
            completion: { _ in
                self.blurEffectView.removeFromSuperview()
            }
        )
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        // stub
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
    
    // MARK: - Actions
    
    @objc func dismissController() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
