//
//  main.swift
//  mobile.swift
//
//  Created by elahe khodaie on 3/18/1399 AP.
//  Copyright © 1399 AP elahe khodaie. All rights reserved.
//

import Foundation

final class BoggleSolver {
    private let minWordLength = 3
    private let board: Board
    private let tree: TrieTree
    // the moves we can make
    private let possibleBoggleMoves: [(x: Int, y: Int)] = [(-1, 0), (-1, -1), (-1 ,1), (0, -1), (0, 1), (1, 0), (1, -1), (1, 1)]
    private var validWords = [String]()
    
    init(board: Board, tree: TrieTree) {
        self.board = board
        self.tree = tree
    }
    func findValidWords() -> [String] {
        for tile in board.tiles {
            for child in tree.root.childNodes where child.key == tile.letter {
                searchForWord(root: child.value, tile: tile, prefix: String(describing: tile.letter))
            }
        }
        return validWords
    }

    private func searchForWord(root: TrieNode, tile: BoardTile, prefix: String) {
        if root.isLeaf && prefix.count >= minWordLength {
            validWords.append(prefix)
        }
        tile.isVisited = true

        for move in possibleBoggleMoves {
            let newRow = tile.row + move.y
            let newColumn = tile.column + move.x
            if board.isIndexInRange(row: newRow, column: newColumn),
                let nextTile = board.tileAtPosition(row: newRow, column: newColumn),
                !nextTile.isVisited {

                var newString = prefix
                newString.append(nextTile.letter)
                
                // keep traversing the branch if there is a child node that contains the next tile's letter
                for child in root.childNodes where child.key == nextTile.letter {
                    searchForWord(root: child.value, tile: nextTile, prefix: newString)
                }
            }
        }

        tile.isVisited = false
    }
}
func split(str: String) -> [String] {
    var substr: String = ""
    var list: [String] = []
    for char in str{
        if (char == " ") {
            list.append(substr)
            substr = ""
        } else {
            substr += String(char)
        }
    }
    if (substr != "") {
        list.append(substr)
    }
    return list
}
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
print("enter your words :")
let word_array = readLine()?
    .split {$0 == " "}
    .map (String.init)

print("enter M and N :")
var next_line = split(str: readLine()!)
var max_row_num = Int(next_line[0])!
var max_col_num = Int(next_line[1])!
var matrix: [[Character]] = []
// this part reads the board
var brd :[[Character]] = []
print("enter the board :")

for r in 0...(max_row_num - 1){
    next_line = split(str: readLine()!)
    brd.append([])
    for c in next_line {
        brd[r].append(Character(c))
    }
}

let tree = TrieTree(dictionary: word_array!)
let board = Board(letters: brd)
let solver = BoggleSolver(board: board, tree: tree)
let validWords = solver.findValidWords()

print("the valid words in the puzzle are :")
// the board may have more than
let newWords = validWords.removingDuplicates()
newWords.forEach{ print($0) }

