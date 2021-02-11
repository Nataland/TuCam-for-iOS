//
//  HomeViewController.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-08.
//

import UIKit

class HomeViewController: UIViewController {
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationController?.setNavigationBarHidden(true, animated: false)
		
		let topToolbarView = TopToolbarView()
		let cameraView = CameraView()
		view.addSubview(topToolbarView)
		view.addSubview(cameraView)
		topToolbarView.translatesAutoresizingMaskIntoConstraints = false
		cameraView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topToolbarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
			topToolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			topToolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			topToolbarView.heightAnchor.constraint(equalToConstant: 60),
			cameraView.topAnchor.constraint(equalTo: topToolbarView.bottomAnchor),
			cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			cameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
		])
    }

	/*
	- 4 icons evenly spaced - 
	[Camera view]
	- 2 medium size icons on the bottom right & left -
	*/
}

