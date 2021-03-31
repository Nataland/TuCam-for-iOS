//
//  BottomToolbarView.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-15.
//

import UIKit

final class BottomToolbarView : UIView {
	private weak var delegate: CameraControlsDelegate?
	
	var homeModel: HomeModel
	let galleryButton = UIButton()
	let shutterButton = UIButton()
	let frameButton = UIButton()
	
	init(homeModel: HomeModel, delegate: CameraControlsDelegate) {
		self.homeModel = homeModel
		self.delegate = delegate
		super.init(frame: CGRect.zero)
		let largeConfig = UIImage.SymbolConfiguration(pointSize: 45, weight: .bold, scale: .large)
		
		galleryButton.setImage(UIImage(systemName: "photo.on.rectangle.fill"), for: .normal)
		shutterButton.setImage(UIImage(systemName: "camera.circle.fill", withConfiguration: largeConfig), for: .normal)
		frameButton.setImage(UIImage(systemName: "paintbrush.fill"), for: .normal)
		
		galleryButton.tintColor = .white
		shutterButton.tintColor = .white
		frameButton.tintColor = .white
		
		galleryButton.addTarget(self, action: #selector(galleryButtonClicked), for: .touchUpInside)
		shutterButton.addTarget(self, action: #selector(shutterButtonClicked), for: .touchUpInside)
		frameButton.addTarget(self, action: #selector(frameButtonClicked), for: .touchUpInside)
		
		let stackView = UIStackView(arrangedSubviews: [galleryButton, shutterButton, frameButton])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.backgroundColor = .black
		addSubview(stackView)
		stackView.constrainToFill(parent: self)
	}
	
	func render() {
		// Todo
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func galleryButtonClicked(sender: UIButton!) {
		delegate?.pickFromPhotoLibrary()
	}
	
	@objc func shutterButtonClicked(sender: UIButton!) {
		delegate?.takePicture()
	}
	
	@objc func frameButtonClicked(sender: UIButton!) {
		homeModel.toggleIsSelectingFrames()
	}
}
