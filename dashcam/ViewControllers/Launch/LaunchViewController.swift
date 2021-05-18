//
//  LaunchViewController.swift
//  dashcam
//
//  Created by Babu Rajendran on 5/18/21.
//

import UIKit

class LaunchViewController: UIViewController {
    
    private var requestCameraAuthorizationView: RequestCameraAuthorizationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRequestCameraAuthorizationView()
        
    }

}

private extension LaunchViewController {
    func setupRequestCameraAuthorizationView() {
        let requestCameraAuthorizationView = RequestCameraAuthorizationView()
        requestCameraAuthorizationView.translatesAutoresizingMaskIntoConstraints = false
        requestCameraAuthorizationView.delegate = self
        view.addSubview(requestCameraAuthorizationView)
        NSLayoutConstraint.activate([
            requestCameraAuthorizationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            requestCameraAuthorizationView.topAnchor.constraint(equalTo: view.topAnchor),
            requestCameraAuthorizationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            requestCameraAuthorizationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        requestCameraAuthorizationView.configureForDisabledState()
        requestCameraAuthorizationView.animateInViews()
        self.requestCameraAuthorizationView = requestCameraAuthorizationView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            guard let self = self else { return }
            self.removeRequestCameraAuthorizationView()
        }
        
//        Code for animating out
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            requestCameraAuthorizationView.animateOutViews()
//        }
    }
    
    func removeRequestCameraAuthorizationView() {
        guard requestCameraAuthorizationView != nil else { return }
        requestCameraAuthorizationView?.animateOutViews(completionHandler: {
            print("Animation Complete!")
        })
//        requestCameraAuthorizationView?.removeFromSuperview()
    }
}

extension LaunchViewController: RequestCameraAuthorizationViewDelegate {
    func requestCameraAuthorizationTapped() {
        RequestCameraAuthorizationConroller.requestCameraAuthorization() { status in
            switch status {
            case .granted:
                print("granted")
            case .notRequested:
                print("not requested")
            case .unauthorized:
                print("unauthorized")
            }
        }
    }
}
