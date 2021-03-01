//
//  EditingViewController.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-18.
//

import UIKit

class EditingViewController: UIViewController {
	
//	var homeModel: HomeModel?
//	lazy var topToolbarView = TopToolbarView(homeModel: homeModel!, delegate: self)
//	lazy var cameraView = CameraView(homeModel: homeModel!)
//	lazy var bottomToolbarView = BottomToolbarView(homeModel: homeModel!, delegate: self)
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
//		homeModel = HomeModel(controller: self)
		navigationController?.setNavigationBarHidden(true, animated: false)
		
//		view.addSubview(topToolbarView)
//		view.addSubview(cameraView)
//		view.addSubview(bottomToolbarView)
//
//		topToolbarView.translatesAutoresizingMaskIntoConstraints = false
//		cameraView.translatesAutoresizingMaskIntoConstraints = false
//		bottomToolbarView.translatesAutoresizingMaskIntoConstraints = false
//
//		NSLayoutConstraint.activate([
//			topToolbarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
//			topToolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//			topToolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//			topToolbarView.heightAnchor.constraint(equalToConstant: 60),
//			cameraView.topAnchor.constraint(equalTo: topToolbarView.bottomAnchor),
//			cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//			cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//			cameraView.bottomAnchor.constraint(equalTo: bottomToolbarView.topAnchor),
//			bottomToolbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//			bottomToolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//			bottomToolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//			bottomToolbarView.heightAnchor.constraint(equalToConstant: 180)
//		])
		
		renderViews()
	}
	
	func renderViews() {
	}
}
