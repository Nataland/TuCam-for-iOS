//
//  HomeModel.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-15.
//

import Foundation

class HomeModel {
	enum TimerState {
		case off, threeSeconds, tenSeconds
	}
	
	enum FlashState {
		case off, auto, on
	}
	
	var selectingFrames: Bool = false
	var frameSelected: Int = 0
	var timerState: TimerState = .off
	var flashState: FlashState = .off
	var shouldShowGrid: Bool = false
	var isFrontCamera: Bool = true
	var countDown: Int? = nil
}
