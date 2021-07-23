//
//  Image.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 20/7/21.
//

import UIKit

struct Image:Codable {
    
    var path: String?
    var ext: String?
    
    var url: String {
        guard let p = path, let e = ext else {return ""}
        return p + "." + e
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
