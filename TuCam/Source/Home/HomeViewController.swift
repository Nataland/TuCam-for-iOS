//
//  HomeViewController.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-08.
//

import UIKit

class HomeViewController: UIViewController {
	
	var homeModel: HomeModel?
	lazy var topToolbarView = TopToolbarView(homeModel: homeModel!, delegate: self)
	lazy var cameraView = CameraView(homeModel: homeModel!)
	lazy var bottomToolbarView = BottomToolbarView(homeModel: homeModel!, delegate: self)
	lazy var collectionView = FramePreviewsCollectionView()
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		homeModel = HomeModel(controller: self)
		navigationController?.setNavigationBarHidden(true, animated: false)
		cameraView.onPictureTaken = { [weak self] image in
			self?.presentEditingViewController(with: image)
		}
		
		view.addSubview(topToolbarView)
		view.addSubview(cameraView)
		view.addSubview(collectionView)
		view.addSubview(bottomToolbarView)
		
		topToolbarView.translatesAutoresizingMaskIntoConstraints = false
		cameraView.translatesAutoresizingMaskIntoConstraints = false
		bottomToolbarView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		collectionView.onSelectUpdateHandler = { [weak self] index in
			self?.homeModel?.updateFrameSelected(index)
		}
		
		NSLayoutConstraint.activate([
			topToolbarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			topToolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			topToolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			topToolbarView.heightAnchor.constraint(equalToConstant: 60),
			cameraView.topAnchor.constraint(equalTo: topToolbarView.bottomAnchor),
			cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			cameraView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3 * 4),
			collectionView.bottomAnchor.constraint(equalTo: bottomToolbarView.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.heightAnchor.constraint(equalToConstant: 90),
			bottomToolbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			bottomToolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			bottomToolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			bottomToolbarView.topAnchor.constraint(equalTo: cameraView.bottomAnchor)
		])
		
		cameraView.clipsToBounds = true
		
		renderViews()
		initializeCamera()
    }
	
	func presentEditingViewController(with image: UIImage) {
		guard let frameImage = homeModel?.getFrameImage() else {
			return
		}
		let controller = EditingViewController(baseImage: image, decorationFrame: frameImage)
		self.navigationController?.pushViewController(controller, animated: true)
	}
	
	func renderViews() {
		topToolbarView.render()
		cameraView.render()
		bottomToolbarView.render()
		collectionView.isHidden = !(homeModel?.isSelectingFrames == true)
	}
	
	func initializeCamera() {
		toggleFlashState()
		flipCamera()
	}
}

extension HomeViewController: CameraControlsDelegate {
	func toggleFlashState() {
		guard let model = homeModel else {
			print("A home model is required to perform actions")
			return
		}
		cameraView.camera.cameraFlashMode = model.flashState
	}
	
	func flipCamera() {
		guard let model = homeModel else {
			print("A home model is required to perform actions")
			return
		}
		cameraView.camera.cameraDevice = model.isFrontCamera ? .front : .rear
	}
	
	func takePicture() {
		cameraView.camera.takePicture()
	}
}
