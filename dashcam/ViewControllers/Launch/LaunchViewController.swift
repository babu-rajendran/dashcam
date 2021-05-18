//
//  LaunchViewController.swift
//  dashcam
//
//  Created by Babu Rajendran on 5/18/21.
//

import UIKit

class LaunchViewController: UIViewController {
    
    private var requestCameraAuthorizationView: RequestCameraAuthorizationView?
    
    private var cameraAuthorizationStatus = RequestCameraAuthorizationConroller.getCameraAuthorizationStatus() {
        didSet {
            setupViewForNextAuthorizationRequest()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewForNextAuthorizationRequest()
        
    }

}

private extension LaunchViewController {
    func setupViewForNextAuthorizationRequest() {
        
        guard cameraAuthorizationStatus == .granted else {
            setupRequestCameraAuthorizationView()
            return
        }
        
        if let _ = requestCameraAuthorizationView {
            removeRequestCameraAuthorizationView()
            return
        }
        
    }
    
    func setupRequestCameraAuthorizationView() {
        guard requestCameraAuthorizationView == nil else {
            return
        }
        let requestCameraAuthorizationView = RequestCameraAuthorizationView()
        requestCameraAuthorizationView.translatesAutoresizingMaskIntoConstraints = false
        requestCameraAuthorizationView.delegate = self
        view.addSubview(requestCameraAuthorizationView)
        NSLayoutConstraint.activate([
            requestCameraAuthorizationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            requestCameraAuthorizationView.topAnchor.constraint(equalTo: view.topAnchor),
            requestCameraAuthorizationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            requestCameraAuthorizationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        requestCameraAuthorizationView.animateInViews()
        self.requestCameraAuthorizationView = requestCameraAuthorizationView
        
//        Test Code for authorization
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
//            guard let self = self else { return }
//            self.removeRequestCameraAuthorizationView()
//        }
        
//        Code for animating out
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            requestCameraAuthorizationView.animateOutViews()
//        }
    }
    
    func removeRequestCameraAuthorizationView() {
        guard let requestCameraAuthorizationView = requestCameraAuthorizationView else { return }
        requestCameraAuthorizationView.animateOutViews(completionHandler: { [weak self] in
            guard let self = self else { return }
            requestCameraAuthorizationView.removeFromSuperview()
            self.requestCameraAuthorizationView = nil
            self.setupViewForNextAuthorizationRequest()
        })
//        requestCameraAuthorizationView?.removeFromSuperview()
    }
}

extension LaunchViewController: RequestCameraAuthorizationViewDelegate {
    func requestCameraAuthorizationTapped() {
        RequestCameraAuthorizationConroller.requestCameraAuthorization() { [weak self] status in
            guard let self = self else { return }
            self.cameraAuthorizationStatus = status
        }
    }
}
