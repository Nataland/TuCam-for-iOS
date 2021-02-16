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
	
	init(homeModel: HomeModel) {
		self.homeModel = homeModel
		super.init(frame: CGRect.zero)
		backgroundColor = UIColor(named: "AccentColor")
		
		addSubview(cameraViewFinder)
		cameraViewFinder.constrainToFill(parent: self)
		
//		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
//			if UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.camera) != nil{
//				camera.sourceType = .camera
//				camera.cameraDevice = .front
//				camera.delegate = self
//				camera.showsCameraControls = false
//				cameraViewFinder.addSubview(camera.view)
//				camera.view.constrainToFill(parent: cameraViewFinder)
//			}
//		}else{
//			print("no camera device found")
//		}
		render()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func render() {
		// Todo
	}
}
