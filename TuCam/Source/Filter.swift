//
//  Filters.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-03-22.
//

import Foundation
import UIKit
import GPUImage

enum Filter: CaseIterable {
//	case amatorka
	case falseColor
	case grayscale
	case monochrome
	case sepia
	case smoothToon
	case virance
	case vignette
	case zoomBlur
	
	func getPreviewImage() -> UIImage {
		switch self {
		case .falseColor:
			return UIImage(named: "demo_false_color")!
		case .grayscale:
			return UIImage(named: "demo_grayscale")!
		case .monochrome:
			return UIImage(named: "demo_monochrome")!
		case .sepia:
			return UIImage(named: "demo_sepia")!
		case .smoothToon:
			return UIImage(named: "demo_smooth_toon")!
		case .virance:
			return UIImage(named: "demo_vibrance")!
		case .vignette:
			return UIImage(named: "demo_vignette")!
		case .zoomBlur:
			return UIImage(named: "demo_zoom_blur")!
		}
	}
	
	func getFilter() -> ImageProcessingOperation {
		switch self {
		case .falseColor:
			return FalseColor()
		case .grayscale:
			let saturationAdjustment = SaturationAdjustment()
			saturationAdjustment.saturation = 0
			return saturationAdjustment
		case .monochrome:
			return MonochromeFilter()
		case .sepia:
			return SepiaToneFilter()
		case .smoothToon:
			return SmoothToonFilter()
		case .virance:
			let vibrance = Vibrance()
			vibrance.vibrance = 1.2
			return vibrance
		case .vignette:
			return Vignette()
		case .zoomBlur:
			return ZoomBlur()
		}
	}
}
