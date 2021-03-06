//
//  FramePreview.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-18.
//

import UIKit

class FramePreviewCell : UICollectionViewCell {
	weak var dannyImage: UIImageView!
	weak var frameImage: UIImageView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let dannyImage = UIImageView(image: UIImage(named: "danny"))
		let frameImage = UIImageView()
		
		contentView.addSubview(dannyImage)
		contentView.addSubview(frameImage)
		
		dannyImage.constrainToFill(parent: contentView)
		frameImage.constrainToFill(parent: contentView)
		
		frameImage.layer.borderColor = UIColor.white.cgColor
		
		self.dannyImage = dannyImage
		self.frameImage = frameImage
	}
	
	func setSelected(_ value: Bool) {
		if value {
			frameImage.layer.borderWidth = 1
		} else {
			frameImage.layer.borderWidth = 0
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()

		fatalError("Interface Builder is not supported!")
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		self.frameImage.image = nil
	}
}
