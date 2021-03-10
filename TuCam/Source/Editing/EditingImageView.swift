//
//  EditingImageView.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-03-08.
//
import UIKit

final class EditingImageView : UIView {
	let frameOverlay = UIImageView()
	let photo = UIImageView()
	var editingModel: EditingModel

	init(editingModel: EditingModel, baseImage: UIImage) {
		self.editingModel = editingModel
		super.init(frame: CGRect.zero)

		photo.image = baseImage
		addSubview(photo)
		addSubview(frameOverlay)

		photo.constrainToFill(parent: self)
		frameOverlay.constrainToFill(parent: self)
		render()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func render() {
		frameOverlay.image = editingModel.getFrameImage()
	}
}
