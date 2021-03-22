//
//  EditingModel.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-03-08.
//
import UIKit
import GPUImage

class EditingModel {

	var controller: EditingViewController

	init(controller: EditingViewController) {
		self.controller = controller
	}

	enum EditingMode {
		case selectingFrames, selectingFilters
	}

	private let frames = [Int](0...28).map { UIImage(named: "frame\($0)") } // need to share this will home model
	
	private(set) var editingMode: EditingMode = .selectingFilters
	private(set) var frameSelected: Int = 0
	private(set) var filterSelected: Int = 0

	func getFrameImage() -> UIImage {
		return frames[frameSelected]!
	}
	
	func getFilter() -> BasicOperation {
		let filters = Filter.allCases.map { $0.getFilter() }
		return filters[filterSelected]
	}

	func toggleEditingMode() {
		switch editingMode {
			case .selectingFilters:
				editingMode = .selectingFrames
			case .selectingFrames:
				editingMode = .selectingFilters
		}
		controller.renderViews()
	}

	func updateFrameSelected(_ newFrame: Int) {
		frameSelected = newFrame
		controller.renderViews()
	}

	func updateFilterSelected(_ newFilter: Int) {
		filterSelected = newFilter
		controller.renderViews()
	}
}
