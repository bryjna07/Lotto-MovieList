//
//  Cell.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/24/25.
//

import Foundation

enum CellType {
    case movie
    
    var id: String {
        switch self {
        case .movie:
            return "MovieCell"
        }
    }
}
