//
//  Extension.swift
//  MovieForYou
//
//  Created by Dmitryi Velko on 25.12.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
