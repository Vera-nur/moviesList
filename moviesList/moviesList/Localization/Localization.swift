//
//  Localization.swift
//  moviesList
//
//  Created by Vera Nur on 21.07.2025.
//

import Foundation

extension String {
    public func localized(with arg: [CVarArg] = []) -> String {
        return String(format: NSLocalizedString(self, comment: ""), arguments: arg)
    }
}
