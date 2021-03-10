//
//  HomeModel.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-15.
//

import UIKit

class HomeModel {
	
	var controller: HomeViewController
	
	init(controller: HomeViewController) {
		self.controller = controller
	}
	
	enum TimerState {
		case off, threeSeconds, tenSeconds
	}
	
	
	private let frames = [Int](0...28).map { UIImage(named: "frame\($0)") }
	private(set) var isSelectingFrames: Bool = false
	private(set) var frameSelected: Int = 0
	private(set) var timerState: TimerState = .off
	private(set) var flashState: UIImagePickerController.CameraFlashMode = .off
	private(set) var shouldShowGrid: Bool = false
	private(set) var isFrontCamera: Bool = true
	private(set) var countDown: Int? = nil
	
	func getFrameImage() -> UIImage? {
		return frames[frameSelected]
	}
	
	func getTimerText() -> String {
		switch timerState {
		case .off:
			return ""
		case .threeSeconds:
			return "3s"
		case .tenSeconds:
			return "10s"
		}
	}
	
	func getTimerImage() -> UIImage? {
		switch timerState {
		case .off:
			return UIImage(systemName: "timer")
		case .threeSeconds, .tenSeconds:
			return nil
		}
	}
	
	func getFlashImage() -> UIImage? {
		switch flashState {
		case .off:
			return UIImage(systemName: "bolt.slash")
		case .auto:
			return UIImage(systemName: "bolt.badge.a")
		case .on:
			return UIImage(systemName: "bolt")
		@unknown default:
			return UIImage(systemName: "bolt.slash")
		}
	}
	
	func toggleIsSelectingFrames() {
		isSelectingFrames = !isSelectingFrames
		controller.renderViews()
	}
	
	func updateFrameSelected(_ newFrame: Int) {
		frameSelected = newFrame
		controller.renderViews()
	}
	
	func toggleTimerState() {
		switch timerState {
		case .off:
			timerState = .threeSeconds
		case .threeSeconds:
			timerState = .tenSeconds
		case .tenSeconds:
			timerState = .off
		}
		controller.renderViews()
	}
	
	func toggleFlashState() {
		switch flashState {
		case .off:
			flashState = .auto
		case .auto:
			flashState = .on
		case .on:
			flashState = .off
		@unknown default:
			flashState = .off
		}
		controller.renderViews()
	}
	
	func toggleShouldShowGrid() {
		shouldShowGrid = !shouldShowGrid
		controller.renderViews()
	}
	
	func toggleIsFrontCamera() {
		isFrontCamera = !isFrontCamera
		controller.renderViews()
	}
	
	func startCountDown() {
		// Todo
		controller.renderViews()
	}
}
