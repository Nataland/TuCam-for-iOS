//
//  UIView+Extensions.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-10.
//

import UIKit

extension UIView {
	func constrainToFill(parent: UIView) {
		self.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.topAnchor.constraint(equalTo: parent.topAnchor),
			self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			self.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			self.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
		])
	}
}
