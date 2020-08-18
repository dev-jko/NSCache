//
//  ViewController.swift
//  NSCache
//
//  Created by Jaedoo Ko on 2020/08/18.
//  Copyright © 2020 jko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let cache = NSCache<NSString, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cache.countLimit = 5
        cache.totalCostLimit = 10
        
        let item = Item()
        let key = makeKey(item: item)
        cache.setObject(item, forKey: key)
        print(item === cache.object(forKey: key))
        cache.removeObject(forKey: key)
        print(cache.object(forKey: key))
        
        var items = [Item]()
        (0..<20).forEach { _ in items.append(Item()) }
        print(items)
        print(items.map { $0.value })
        items.forEach { cache.setObject($0, forKey: makeKey(item: $0), cost: 3) }
        items.map { cache.object(forKey: makeKey(item: $0)) as? Item }
            .enumerated()
            .forEach { print($0, $1?.value) }
    }

    private func makeKey(item: Item) -> NSString {
        return NSString(string: "\(item.value)")
    }

}

class Item {
    private static var count = 0
    
    let value: Int
    
    init() {
        value = Self.count
        Self.count += 1
    }
}
