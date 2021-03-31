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
	private var filterLeadingConstraint: NSLayoutConstraint?
	private let decorationFrame: UIImage
	private let collectionViewToggleButton = UIButton()
	lazy var filterCollectionView = FramePreviewsCollectionView(context: .filter)
	lazy var frameCollectionView = FramePreviewsCollectionView(context: .frame)
	
	init(baseImage: UIImage, decorationFrame: UIImage) {
		self.originalImage = baseImage
		self.baseImage = baseImage
		self.decorationFrame = decorationFrame
		super.init(nibName: nil, bundle: nil)
		collectionViewToggleButton.setTitle("Select frame", for: .normal)
		collectionViewToggleButton.addTarget(self, action: #selector(animateCollections), for: .touchUpInside)
		
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
		view.addSubview(filterCollectionView)
		view.addSubview(frameCollectionView)
		view.addSubview(collectionViewToggleButton)

		editingImageView.translatesAutoresizingMaskIntoConstraints = false
		filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionViewToggleButton.translatesAutoresizingMaskIntoConstraints = false
		frameCollectionView.translatesAutoresizingMaskIntoConstraints = false
		frameCollectionView.isHidden = true
		filterCollectionView.onSelectUpdateHandler = { [weak self] index in
			self?.editingModel?.updateFilterSelected(index)
			self?.applyFilter()
		}
		frameCollectionView.onSelectUpdateHandler = { [weak self] index in
			self?.editingModel?.updateFrameSelected(index)
//			self?.applyFilter() TODO
		}
		
		filterLeadingConstraint = filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
		
		NSLayoutConstraint.activate([
			editingImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			editingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			editingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			editingImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3 * 4),
			filterCollectionView.topAnchor.constraint(equalTo: editingImageView.bottomAnchor),
			filterCollectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
			filterCollectionView.heightAnchor.constraint(equalToConstant: FramePreviewsCollectionView.Context.filter.size.height),
			frameCollectionView.topAnchor.constraint(equalTo: editingImageView.bottomAnchor),
			frameCollectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
			frameCollectionView.heightAnchor.constraint(equalToConstant: FramePreviewsCollectionView.Context.filter.size.height),
			frameCollectionView.leadingAnchor.constraint(equalTo: filterCollectionView.trailingAnchor),
			collectionViewToggleButton.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 12.0),
			collectionViewToggleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionViewToggleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionViewToggleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 12.0)
		])
		filterLeadingConstraint?.isActive = true
		
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
		
		let filterdImage: UIImage
		
		switch model.getFilter() {
		case .falseColor:
			filterdImage = originalImage.filterWithOperation(FalseColor())
		case .grayscale:
			let saturationAdjustment = SaturationAdjustment()
			saturationAdjustment.saturation = 0
			filterdImage = originalImage.filterWithOperation(saturationAdjustment)
		case .monochrome:
			filterdImage = originalImage.filterWithOperation(MonochromeFilter())
		case .sepia:
			filterdImage = originalImage.filterWithOperation(SepiaToneFilter())
		case .smoothToon:
			filterdImage = originalImage.filterWithOperation(SmoothToonFilter())
		case .virance:
			let vibrance = Vibrance()
			vibrance.vibrance = 1.2
			filterdImage = originalImage.filterWithOperation(vibrance)
		case .vignette:
			filterdImage = originalImage.filterWithOperation(Vignette())
		case .zoomBlur:
			filterdImage = originalImage.filterWithOperation(ZoomBlur())
		}
	
		guard let filteredCGImage = filterdImage.cgImage else {
			print("A cg image is required to perform actions")
			return
		}
		
		baseImage = UIImage(
			cgImage: filteredCGImage,
			scale: originalImage.scale,
			orientation: originalImage.imageOrientation
		)
		editingImageView.photo.image = baseImage
	}
	
	@objc func animateCollections() {
		if filterCollectionView.isHidden {
			filterLeadingConstraint?.constant = 0
			filterCollectionView.isHidden = false
			self.view.setNeedsUpdateConstraints()
			UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
				self.view.layoutIfNeeded()
			} completion: { [weak self] completed in
				guard completed else { return }
				self?.frameCollectionView.isHidden = true
			}
			collectionViewToggleButton.setTitle("Select frame", for: .normal)
		} else {
			filterLeadingConstraint?.constant = -UIScreen.main.bounds.width
			frameCollectionView.isHidden = false
			self.view.setNeedsUpdateConstraints()
			UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
				self.view.layoutIfNeeded()
			} completion: { [weak self] completed in
				guard completed else { return }
				self?.filterCollectionView.isHidden = true
			}
			collectionViewToggleButton.setTitle("Select filter", for: .normal)
		}
	}
}
