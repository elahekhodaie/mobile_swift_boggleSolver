//
//  Trie.swift
//  mobile.swift
//
//  Created by elahe khodaie on 3/19/1399 AP.
//  Copyright © 1399 AP elahe khodaie. All rights reserved.
//

import Foundation

final class TrieNode {
    
    var childNodes = [Character: TrieNode]()
    var isLeaf = false
   //  new node
    func createChildNode(for character: Character) -> TrieNode {
        if let child = childNodes[character] {
            return child
        }else {
            let node = TrieNode()
            childNodes[character] = node
            return node
        }
    }
}

final class TrieTree {
    
    var root = TrieNode()
    init(dictionary: [String]) {
        dictionary.forEach {
            insert(word: $0)
        }
    }
    private func insert(word: String) {
        var node = root
        for character in word {
            node = node.createChildNode(for: character)
        }
        node.isLeaf = true
    }
}
