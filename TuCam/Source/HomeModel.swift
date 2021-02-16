//
//  HomeModel.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-15.
//

import Foundation

class HomeModel {
	
	var controller: HomeViewController
	
	init(controller: HomeViewController) {
		self.controller = controller
	}
	
	enum TimerState {
		case off, threeSeconds, tenSeconds
	}
	
	enum FlashState {
		case off, auto, on
	}
	
	private(set) var isSelectingFrames: Bool = false
	private(set) var frameSelected: Int = 0
	private(set) var timerState: TimerState = .off
	private(set) var flashState: FlashState = .off
	private(set) var shouldShowGrid: Bool = false
	private(set) var isFrontCamera: Bool = true
	private(set) var countDown: Int? = nil
	
	func toggleIsSelectingFrames() {
		isSelectingFrames = !isSelectingFrames
		controller.renderViews()
	}
	
	func updateFrameSelected(newFrame: Int) {
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
