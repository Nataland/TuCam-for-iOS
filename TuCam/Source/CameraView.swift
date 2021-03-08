//
//  CameraView.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-10.
//

import UIKit
import AVFoundation

final class CameraView : UIView {
	var homeModel: HomeModel
	let cameraViewFinder = UIView()
	let gridView = GridView()
	let frameOverlay = UIImageView()
	let cameraOverlayView = UIView()
	let cameraSession = CameraSession()
	// Todo: aspect ratio of camera view and content mode of frame overlay
	
	init(homeModel: HomeModel) {
		self.homeModel = homeModel
		super.init(frame: CGRect.zero)
		
		addSubview(cameraViewFinder)
		addSubview(cameraOverlayView)
		cameraOverlayView.addSubview(gridView)
		cameraOverlayView.addSubview(frameOverlay)
		
		cameraViewFinder.constrainToFill(parent: self)
		cameraOverlayView.constrainToFill(parent: self)
		gridView.constrainToFill(parent: cameraOverlayView)
		frameOverlay.constrainToFill(parent: cameraOverlayView)
		
		frameOverlay.contentMode = .scaleAspectFit
		cameraSession.onViewReady = { [weak self] layer in
			guard let self = self else { return }
			if let sublayer = self.cameraViewFinder.layer.sublayers?.first {
				sublayer.removeFromSuperlayer()
			}
			
			layer.videoGravity = .resizeAspectFill
			layer.bounds = self.cameraViewFinder.bounds
			//layer.position = CGPoint(x: CGRect.midX(self.cameraViewFinder.bounds), y: CGRect.midY(self.cameraViewFinder.bounds))
			self.cameraViewFinder.layer.addSublayer(layer)
		}
		
		cameraSession.findDevice(with: homeModel.isFrontCamera ? .front : .back)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func render() {
		frameOverlay.image = homeModel.getFrameImage()
		gridView.isHidden = !homeModel.shouldShowGrid
		cameraSession.findDevice(with: homeModel.isFrontCamera ? .front : .back)
	}
}
