//
//  TopToolbarView.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-10.
//

import UIKit

final class TopToolbarView : UIView {
	var homeModel: HomeModel
	let timerButton = UIButton()
	let gridButton = UIButton()
	let flashButton = UIButton()
	let flipButton = UIButton()
	
	init(homeModel: HomeModel) {
		self.homeModel = homeModel
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
		render()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func render() {
		switch homeModel.timerState {
		case .off:
			timerButton.setImage(UIImage(systemName: "timer"), for: .normal)
			timerButton.setTitle("", for: .normal)
		case .threeSeconds:
			timerButton.setImage(nil, for: .normal)
			timerButton.setTitle("3s", for: .normal)
		case .tenSeconds:
			timerButton.setImage(nil, for: .normal)
			timerButton.setTitle("10s", for: .normal)
		}
		
		gridButton.setImage(UIImage(systemName: homeModel.shouldShowGrid ? "rectangle.split.3x3" : "rectangle"), for: .normal)
		
		switch homeModel.flashState {
		case .off:
			flashButton.setImage(UIImage(systemName: "bolt.slash"), for: .normal)
		case .auto:
			flashButton.setImage(UIImage(systemName: "bolt.badge.a"), for: .normal)
		case .on:
			flashButton.setImage(UIImage(systemName: "bolt"), for: .normal)
		}
	}
	
	@objc func timerButtonClicked(sender: UIButton!) {
		homeModel.toggleTimerState()
	}
	
	@objc func gridButtonClicked(sender: UIButton!) {
		homeModel.toggleShouldShowGrid()
	}
	
	@objc func flashButtonClicked(sender: UIButton!) {
		homeModel.toggleFlashState()
	}
	
	@objc func flipButtonClicked(sender: UIButton!) {
		homeModel.toggleIsFrontCamera()
	}
}
