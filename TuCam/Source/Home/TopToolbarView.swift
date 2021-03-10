//
//  TopToolbarView.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-10.
//

import UIKit

final class TopToolbarView : UIView {
	private weak var delegate: CameraControlsDelegate?
	
	var homeModel: HomeModel
	let timerButton = UIButton()
	let gridButton = UIButton()
	let flashButton = UIButton()
	let flipButton = UIButton()
	
	init(homeModel: HomeModel, delegate: CameraControlsDelegate?) {
		self.homeModel = homeModel
		self.delegate = delegate
		super.init(frame: CGRect.zero)
		
		timerButton.tintColor = .white
		gridButton.tintColor = .white
		flashButton.tintColor = .white
		flipButton.tintColor = .white
		flipButton.setImage(UIImage(systemName: "camera.rotate"), for: .normal)
		timerButton.addTarget(self, action: #selector(timerButtonClicked), for: .touchUpInside)
		gridButton.addTarget(self, action: #selector(gridButtonClicked), for: .touchUpInside)
		flashButton.addTarget(self, action: #selector(flashButtonClicked), for: .touchUpInside)
		flipButton.addTarget(self, action: #selector(flipButtonClicked), for: .touchUpInside)
		
		let stackView = UIStackView(arrangedSubviews: [timerButton, gridButton, flashButton, flipButton])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.backgroundColor = .black
		addSubview(stackView)
		stackView.constrainToFill(parent: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func render() {
		timerButton.setImage(homeModel.getTimerImage(), for: .normal)
		timerButton.setTitle(homeModel.getTimerText(), for: .normal)
		gridButton.setImage(UIImage(systemName: homeModel.shouldShowGrid ? "rectangle.split.3x3" : "rectangle"), for: .normal)
		flashButton.setImage(homeModel.getFlashImage(), for: .normal)
	}
	
	@objc func timerButtonClicked(sender: UIButton!) {
		homeModel.toggleTimerState()
	}
	
	@objc func gridButtonClicked(sender: UIButton!) {
		homeModel.toggleShouldShowGrid()
	}
	
	@objc func flashButtonClicked(sender: UIButton!) {
		homeModel.toggleFlashState()
		delegate?.toggleFlashState()
	}
	
	@objc func flipButtonClicked(sender: UIButton!) {
		homeModel.toggleIsFrontCamera()
		delegate?.flipCamera()
	}
}
