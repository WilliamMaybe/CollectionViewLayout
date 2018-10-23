//
//  CollectionViewSectionColorFlowLayout.swift
//  CollectionViewLayout
//
//  Created by maybe on 2018/8/26.
//  Copyright © 2018年 Maybe Zh. All rights reserved.
//

import UIKit

class CollectionViewSectionColorFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        register(CollectionViewSectionColorView.self, forDecorationViewOfKind: CollectionViewSectionColorView.identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        register(CollectionViewSectionColorView.self, forDecorationViewOfKind: CollectionViewSectionColorView.identifier)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let oldBounds = collectionView?.bounds ?? .zero
        return !oldBounds.equalTo(newBounds)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let tmp = super.layoutAttributesForElements(in: rect)
        
        guard var attributes = tmp else { return tmp }
        
        var sections: Set<Int> = []
        for attribute in attributes {
            if attribute.representedElementCategory == .cell {
                sections.insert(attribute.indexPath.section)
            }
        }

        for section in sections.sorted(by: <) {
            let endRow = collectionView?.numberOfItems(inSection: section) ?? 0
            guard endRow > 0 else {
                continue
            }

            let start = layoutAttributesForItem(at: IndexPath(row: 0, section: section))!
            let end = layoutAttributesForItem(at: IndexPath(row: endRow - 1, section: section))!

            guard let decoration = layoutAttributesForDecorationView(ofKind: CollectionViewSectionColorView.identifier, at: start.indexPath) else {
                continue
            }

            decoration.frame = CGRect(x: 0, y: start.frame.minY - sectionInset.top, width: collectionView?.frame.width ?? 0, height: end.frame.maxY - start.frame.minY + sectionInset.top + sectionInset.bottom )
            attributes.append(decoration)
        }
        
        return attributes
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, with: indexPath)
        attribute.zIndex = -1
        return attribute
    }
}


private class CollectionViewSectionColorView: UICollectionReusableView {
    fileprivate static let identifier = String(describing: self)
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0,
                                  green: CGFloat(arc4random_uniform(255)) / 255.0,
                                  blue: CGFloat(arc4random_uniform(255)) / 255.0,
                                  alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
