//
//  HelperCodable.swift
//  PlasticHavas
//
//  Created by David on 2020-10-29.
//

import Foundation

public class MyCodableItem: NSObject, Codable {
    private let id: String
    private let label: String?

    enum CodingKeys: String, CodingKey {
        case id
        case label
    }

    @objc public class func create(from url: URL) -> MyCodableItem {
        let decoder = JSONDecoder()
        let item = try! decoder.decode(MyCodableItem.self, from: try! Data(contentsOf: url))
        return item
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        label = try? container.decode(String.self, forKey: .label)
        super.init()
    }

    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
