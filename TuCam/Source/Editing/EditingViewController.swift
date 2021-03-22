//
//  EditingViewController.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-18.
//

import UIKit
import GPUImage

class EditingViewController: UIViewController {
	
	var editingModel: EditingModel?
	lazy var editingImageView = EditingImageView(editingModel: editingModel!, baseImage: baseImage)
	
	private let originalImage: UIImage
	private var baseImage: UIImage
	private let decorationFrame: UIImage
	lazy var collectionView = FramePreviewsCollectionView(context: .filter)
	
	init(baseImage: UIImage, decorationFrame: UIImage) {
		self.originalImage = baseImage
		self.baseImage = baseImage
		self.decorationFrame = decorationFrame
		super.init(nibName: nil, bundle: nil)
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
	}
	
	@objc func cancel() {
		let alertController = UIAlertController(title: "Discard changes?", message: "Are you sure you want to discard your changes?", preferredStyle: .alert)
		let confirmAction = UIAlertAction(title: "Discard", style: .destructive) { [weak self] _ in
			self?.navigationController?.popViewController(animated: true)
			self?.navigationController?.setNavigationBarHidden(true, animated: true)
		}
		let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
		alertController.addAction(confirmAction)
		alertController.addAction(cancelAction)
		present(alertController, animated: true)
	}
	
	@objc func save() {
		guard let model = editingModel else {
			print("An editing model is required to perform actions")
			return
		}
		
		UIGraphicsBeginImageContextWithOptions(baseImage.size, false, 0.0)
		baseImage.draw(in: CGRect(origin: CGPoint.zero, size: baseImage.size))
		model.getFrameImage().draw(in: CGRect(origin: CGPoint.zero, size: baseImage.size))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		let activityController = UIActivityViewController(activityItems: [newImage!], applicationActivities: nil)
		present(activityController, animated: true) { [weak self] in
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		editingModel = EditingModel(controller: self)
		navigationController?.setNavigationBarHidden(false, animated: true)
		
		view.addSubview(editingImageView)
		view.addSubview(collectionView)

		editingImageView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.onSelectUpdateHandler = { [weak self] index in
			self?.editingModel?.updateFilterSelected(index)
			self?.applyFilter()
		}

		NSLayoutConstraint.activate([
			editingImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			editingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			editingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			editingImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3 * 4),
			collectionView.topAnchor.constraint(equalTo: editingImageView.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.heightAnchor.constraint(equalToConstant: FramePreviewsCollectionView.Context.filter.size.height)
		])
		
		renderViews()
	}
	
	func renderViews() {
		editingImageView.render()
	}
	
	func applyFilter() {
		guard let model = editingModel else {
			print("An editing model is required to perform actions")
			return
		}
		baseImage = UIImage(
			cgImage: originalImage.filterWithOperation(model.getFilter()).cgImage!,
			scale: originalImage.scale,
			orientation: originalImage.imageOrientation
		)
		editingImageView.photo.image = baseImage
	}
}
