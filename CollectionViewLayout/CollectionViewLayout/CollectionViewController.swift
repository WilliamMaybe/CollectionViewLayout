//
//  CollectionViewController.swift
//  CollectionViewLayout
//
//  Created by maybe on 2018/8/26.
//  Copyright © 2018年 Maybe Zh. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class EmojiCell: UICollectionViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
}

class CollectionViewController: UICollectionViewController {
    
    var emojis: [[String]] = []
    
    override func viewDidLoad() {
        refresh()
        super.viewDidLoad()
        collectionView?.isPrefetchingEnabled = false
    }

    @IBAction func addEmoji(_ sender: Any) {
        let section = Int(arc4random_uniform(UInt32(emojis.count)))
        let row = Int(arc4random_uniform(UInt32(emojis[section].count)))
        emojis[section].insert("😄", at: row)
        collectionView?.insertItems(at: [IndexPath(row: row, section: section)])
    }
    @IBAction func deleteEmoji(_ sender: Any) {
        let section = Int(arc4random_uniform(UInt32(emojis.count)))
        let row = Int(arc4random_uniform(UInt32(emojis[section].count)))
        emojis[section].remove(at: row)
        collectionView?.deleteItems(at: [IndexPath(row: row, section: section)])
    }
    
    func refresh()  {
        let ids = 1...2
        let emoticons = (0x1F600...0x1F647).compactMap { UnicodeScalar($0).map(String.init) }
        let splitedCount = Int((Double(emoticons.count) / Double(ids.count)).rounded(.up))
        
        emojis = ids.enumerated().map { offset, model in
            let start = offset * splitedCount
            let end = min(start + splitedCount, emoticons.endIndex)
            let emoticons = emoticons[start..<end]
            return Array(emoticons)
        }
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emojis.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmojiCell
        cell.emojiLabel.text = emojis[indexPath.section][indexPath.row]
        cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0,
                                       green: CGFloat(arc4random_uniform(255)) / 255.0,
                                       blue: CGFloat(arc4random_uniform(255)) / 255.0,
                                       alpha: 1)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
