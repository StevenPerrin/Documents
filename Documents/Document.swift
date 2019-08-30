

import Foundation

class Document: Codable {
    var title: String
    var body: String
    var dateModified: Date
    var size: UInt64
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case body = "body"
        case dateModified = "date_modified"
        case size = "size"
    }
    
    init(title: String, body: String, dateModified: Date, size: UInt64) {
        self.title = title
        self.body = body
        self.dateModified = dateModified
        self.size = size
    }
}

extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }
    
    var size: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }
    
    var modificationDate: Date? {
        return attributes?[.modificationDate] as? Date
    }
}

