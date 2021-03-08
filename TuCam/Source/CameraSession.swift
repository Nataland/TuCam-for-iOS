//
//  CameraSession.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-03-08.
//

import AVFoundation

final class CameraSession {
	private let session = AVCaptureSession()
	private var previewLayer: AVCaptureVideoPreviewLayer?
	private var captureDevice: AVCaptureDevice?
	
	var onViewReady: ((AVCaptureVideoPreviewLayer) -> Void)?
	
	func findDevice(with type: AVCaptureDevice.Position) {
		for input in session.inputs {
			session.removeInput(input)
		}
		
		session.stopRunning()
		captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: type)
		guard let device = captureDevice else {
			print("Could not find a device for \(type)")
			return
		}
		var input: AVCaptureDeviceInput!
		do {
			input = try AVCaptureDeviceInput(device: device)
		} catch {
			print("Error while starting the device input: \(error)")
			captureDevice = nil
		}
		
		session.addInput(input)
		
		// Maintain a 3:4 ratio
		session.sessionPreset = .photo
		
		previewLayer =  AVCaptureVideoPreviewLayer(session: session)
		session.startRunning()
		
		if let layer = previewLayer {
			onViewReady?(layer)
		}
	}
}
