//
//  CameraControlsDelegate.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-17.
//

import Foundation

protocol CameraControlsDelegate: AnyObject {
	func toggleFlashState()
	func flipCamera()
}
