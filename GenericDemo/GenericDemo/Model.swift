//
//  Model.swift
//  GenericDemo
//
//  Created by nguyentienhoang on 11/18/18.
//  Copyright © 2018 nguyentienhoang. All rights reserved.
//

import Foundation

struct Model1: Codable {
    var id: String?
    var name: String?
    var external_id: String?
}

struct Model2: Codable {
    var id: Int?
    var name: String?
    var cod: Int?
}
