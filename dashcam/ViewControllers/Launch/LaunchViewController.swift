//
//  LaunchViewController.swift
//  dashcam
//
//  Created by Babu Rajendran on 5/18/21.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }

}

private extension LaunchViewController {
    func setupViews() {
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
