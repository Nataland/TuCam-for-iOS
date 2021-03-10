//
//  EditingViewController.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-18.
//

import UIKit

class EditingViewController: UIViewController {
	
	var editingModel: EditingModel?
	lazy var editingImageView = EditingImageView(editingModel: editingModel!, baseImage: baseImage)
	
	private let baseImage: UIImage
	private let decorationFrame: UIImage
	
	init(baseImage: UIImage, decorationFrame: UIImage) {
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
		let activityController = UIActivityViewController(activityItems: [baseImage], applicationActivities: nil)
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

		editingImageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			editingImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			editingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			editingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			editingImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3 * 4)
		])
		
		renderViews()
	}
	
	func renderViews() {
	}
}
