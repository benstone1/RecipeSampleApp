//
//  Array+RawRepresentable.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/19/21.
//

import Foundation

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8) else { return nil }
        do {
            let arr = try JSONDecoder().decode([Element].self, from: data)
            self = arr
        }
        catch {
            return nil
        }
    }
    
    public var rawValue: String {
        do {
            let encodedArr = try JSONEncoder().encode(self)
            return String(data: encodedArr, encoding: .utf8)!
        }
        catch {
            fatalError()
        }

    }
}
