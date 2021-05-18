//
//  RequestCameraAuthorizationView.swift
//  dashcam
//
//  Created by Babu Rajendran on 5/18/21.
//

import UIKit

protocol RequestCameraAuthorizationViewDelegate: class {
    func requestCameraAuthorizationTapped()
}

class RequestCameraAuthorizationView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var cameraImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    
    weak var delegate: RequestCameraAuthorizationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        let bundle = Bundle.main
        let nibName = String(describing: Self.self)
        bundle.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addActionButtonShadow()
    }
    
    @IBAction func actionButtonHandler(btn: UIButton) {
        delegate?.requestCameraAuthorizationTapped()
    }
    
    private func addActionButtonShadow() {
        actionButton.layer.shadowColor = UIColor.black.cgColor
        actionButton.layer.shadowOpacity = 0.3
        actionButton.layer.shadowRadius = 10
        actionButton.layer.masksToBounds = false
        actionButton.layer.shadowOffset = CGSize(width: 5, height: 10)
        actionButton.layer.cornerRadius = 4
    }
    
    func animateInViews() {
        let viewsToAnimate = [cameraImageView, titleLabel, messageLabel, actionButton]
        for(i, viewToAnimate) in viewsToAnimate.enumerated() {
            guard let view = viewToAnimate else { continue }
            animateInView(view: view, delay: Double(i) * 0.25)
        }
    }
    
    func animateOutViews() {
        let viewsToAnimate = [cameraImageView, titleLabel, messageLabel, actionButton]
        for(i, viewToAnimate) in viewsToAnimate.enumerated() {
            guard let view = viewToAnimate else { continue }
            animateOutView(view: view, delay: Double(i) * 0.25)
        }
    }

}

private extension RequestCameraAuthorizationView {
    func animateInView(view: UIView, delay: TimeInterval) {
        view.alpha = 0
        view.transform = CGAffineTransform(translationX: 0, y: -20)
        let animation = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
            view.alpha = 1
            view.transform = .identity
        }
        animation.startAnimation(afterDelay: delay)
        
    }
    
    func animateOutView(view: UIView, delay: TimeInterval) {
        let animation = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
            view.alpha = 0
            view.transform = CGAffineTransform(translationX: 0, y: -20)
        }
        animation.startAnimation(afterDelay: delay)
        
    }
}
