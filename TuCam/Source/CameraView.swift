//
//  CameraView.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-10.
//

import UIKit
import AVFoundation

final class CameraView : UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	var homeModel: HomeModel
	let camera = UIImagePickerController()
	let cameraViewFinder = UIView()
	let gridView = GridView()
	let frameOverlay = UIImageView()
	
	init(homeModel: HomeModel) {
		self.homeModel = homeModel
		super.init(frame: CGRect.zero)
		
		addSubview(cameraViewFinder)
		addSubview(gridView)
		addSubview(frameOverlay)
		
		cameraViewFinder.constrainToFill(parent: self)
		gridView.constrainToFill(parent: self)
		frameOverlay.constrainToFill(parent: self)
		
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
			if UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.camera) != nil {
				camera.sourceType = .camera
				camera.cameraDevice = .front
				camera.delegate = self
				camera.showsCameraControls = false
				cameraViewFinder.addSubview(camera.view)
				camera.cameraOverlayView = frameOverlay
				camera.view.constrainToFill(parent: cameraViewFinder)
			}
		} else {
			print("no camera device found")
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: true)
		let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
		print("picture taken", image?.size ?? 0)
	}
	
	func render() {
		frameOverlay.image = homeModel.getFrameImage()
		gridView.isHidden = !homeModel.shouldShowGrid
	}
}
