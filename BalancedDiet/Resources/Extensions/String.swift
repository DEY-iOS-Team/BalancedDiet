//
//  ExtensionString.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 9.04.22.
//
import Foundation

extension String {
    func isReallyEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    static var empty: String {
        ""
    }
}
