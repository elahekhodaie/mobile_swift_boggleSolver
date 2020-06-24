//
//  board.swift
//  mobile.swift
//
//  Created by elahe khodaie on 3/22/1399 AP.
//  Copyright © 1399 AP elahe khodaie. All rights reserved.
//

import Foundation


final class Board {
    
    let numberOfRows: Int
    let numberOfColumns: Int
    var tiles = [BoardTile]()
    init(letters: [[Character]]) {
        
        self.numberOfRows = letters.count
        self.numberOfColumns = letters[0].count
        //build board tile with our letters
        for (rowIndex, row) in letters.enumerated() {
            for (column_ind, letter) in row.enumerated() {
                tiles.append(BoardTile(row: rowIndex, column: column_ind, letter: letter))
            }
        }
    }
    func tileAtPosition(row: Int, column: Int) -> BoardTile? {
        for tile in tiles where tile.row == row && tile.column == column {
            return tile
        }
        return nil
    }
    func isIndexInRange(row: Int, column: Int) -> Bool {
        return  row < numberOfRows && column < numberOfColumns && row >= 0 && column >= 0
    }
}
final class BoardTile {

    let row: Int
    let column: Int
    let letter: Character
    var isVisited = false
    init(row: Int, column: Int, letter: Character) {
        self.row = row
        self.column = column
        self.letter = letter
    }
}
