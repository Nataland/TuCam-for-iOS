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
		backgroundColor = .systemPink
		timerButton.setTitle("Timer", for: .normal)
		gridButton.setTitle("Grid", for: .normal)
		flashButton.setTitle("Flash", for: .normal)
		flipButton.setTitle("Flip", for: .normal)
		
		let stackView = UIStackView(arrangedSubviews: [timerButton, gridButton, flashButton, flipButton])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.backgroundColor = .red
		
		addSubview(stackView)
		stackView.constrainToFill(parent: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
