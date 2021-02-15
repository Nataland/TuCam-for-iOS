//
//  BottomToolbarView.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-15.
//

import UIKit

final class BottomToolbarView : UIView {
	let galleryButton = UIButton()
	let shutterButton = UIButton()
	let frameButton = UIButton()
	
	init() {
		super.init(frame: CGRect.zero)
		let largeConfig = UIImage.SymbolConfiguration(pointSize: 45, weight: .bold, scale: .large)
		galleryButton.setImage(UIImage(systemName: "photo.on.rectangle.fill"), for: .normal)
		shutterButton.setImage(UIImage(systemName: "camera.circle.fill", withConfiguration: largeConfig), for: .normal)
		frameButton.setImage(UIImage(systemName: "paintbrush.fill"), for: .normal)
		galleryButton.tintColor = .white
		shutterButton.tintColor = .white
		frameButton.tintColor = .white
		
		let stackView = UIStackView(arrangedSubviews: [galleryButton, shutterButton, frameButton])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.backgroundColor = .black
		addSubview(stackView)
		stackView.constrainToFill(parent: self)
		
//		addSubview(galleryButton)
//		addSubview(shutterButton)
//		addSubview(frameButton)
		
//		galleryButton.translatesAutoresizingMaskIntoConstraints = false
//		shutterButton.translatesAutoresizingMaskIntoConstraints = false
//		frameButton.translatesAutoresizingMaskIntoConstraints = false
//
//		NSLayoutConstraint.activate([
//			shutterButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//			shutterButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//			shutterButton.widthAnchor.constraint(equalToConstant: 50),
//			shutterButton.heightAnchor.constraint(equalToConstant: 50)
//		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

