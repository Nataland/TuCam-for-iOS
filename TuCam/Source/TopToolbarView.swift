//
//  TopToolbarView.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-10.
//

import UIKit

final class TopToolbarView : UIView {
	let timerButton = UIButton()
	let gridButton = UIButton()
	let flashButton = UIButton()
	let flipButton = UIButton()
	
	init() {
		super.init(frame: CGRect.zero)
		timerButton.setImage(UIImage(systemName: "timer"), for: .normal)
		gridButton.setImage(UIImage(systemName: "grid"), for: .normal)
		flashButton.setImage(UIImage(systemName: "bolt"), for: .normal)
		flipButton.setImage(UIImage(systemName: "camera.rotate"), for: .normal)
		timerButton.tintColor = .white
		flashButton.tintColor = .white
		gridButton.tintColor = .white
		flipButton.tintColor = .white
		
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
}
