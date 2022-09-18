//
//  UICollectionView+Extension.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/18.
//

import UIKit

extension UICollectionView {
    static func singleTableLayout(
        widthOffset: CGFloat = 0,
        heightOffset: CGFloat = 20
    ) -> UICollectionViewCompositionalLayout {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let spacing = NSCollectionLayoutSpacing.fixed(heightOffset / 2)
        item.edgeSpacing = .init(leading: nil, top: spacing, trailing: nil, bottom: spacing)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: widthOffset, bottom: 0, trailing: widthOffset)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
