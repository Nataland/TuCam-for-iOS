//
//  FramePreviewsCollectionView.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-22.
//

import UIKit

final class FramePreviewsCollectionView : UIView, UICollectionViewDataSource, UICollectionViewDelegate {
	var onSelectUpdateHandler: ((Int) -> Void)?
	var collectionView: UICollectionView
	private let frames = [Int](0...28).map { UIImage(named: "frame\($0)") }
	private let reuseIdentifier = "cell"
	private var selectedIndex: Int = 0
	
	init() {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.itemSize = CGSize(width: 60, height: 90)
		layout.register(FramePreviewCell.self, forDecorationViewOfKind: reuseIdentifier)
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		super.init(frame: CGRect.zero)
		collectionView.delegate = self
		collectionView.dataSource = self
		addSubview(collectionView)
		collectionView.constrainToFill(parent: self)
		collectionView.register(FramePreviewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		collectionView.reloadData()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: -UICollectionViewDataSource
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return frames.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let framePreviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! FramePreviewCell
		framePreviewCell.setSelected(selectedIndex == indexPath.row)
		framePreviewCell.frameImage.image = frames[indexPath.row]
		return framePreviewCell
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	
	// MARK: -UICollectionViewDelegate
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectedIndex = indexPath.row
		collectionView.reloadData()
		onSelectUpdateHandler?(indexPath.row)
	}
}
