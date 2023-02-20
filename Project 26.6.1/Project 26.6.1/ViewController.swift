//
//  ViewController.swift
//  Project 26.6.1
//
//  Created by Boris Kotov on 21.02.2023.
//

import UIKit

class ViewController: UIViewController {
    let imageView = UIImageView()
    let segmentedControl = UISegmentedControl()
    
    let userDefaults = UserDefaults.standard
    var togglePressed = false
    
    override func loadView() {
        super.loadView()
        
        segmentedControl.insertSegment(withTitle: "Light", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Dark", at: 1, animated: true)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            segmentedControl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            segmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
        segmentedControl.addTarget(self, action: #selector(segmentedControlPressed), for: .valueChanged)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        togglePressed = userDefaults.bool(forKey: "TogglePressed")
        segmentedControl.selectedSegmentIndex = togglePressed ? 1 : 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateViewState()
    }
    
    func updateViewState() {
        view.window?.overrideUserInterfaceStyle = togglePressed ? .dark : .light
        let image = UIImage(named: togglePressed ? "dark" : "light")
        imageView.image = image
    }
    
    @objc func segmentedControlPressed(_ sender: UISegmentedControl) {
        togglePressed = sender.selectedSegmentIndex == 1
        userDefaults.set(togglePressed, forKey: "TogglePressed")
        updateViewState()
    }
}

