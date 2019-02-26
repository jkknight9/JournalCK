//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Jack Knight on 2/25/19.
//  Copyright © 2019 Jack Knight. All rights reserved.
//

import Foundation
import CloudKit

struct Constants {
    static let titleKey = "Title"
    static let bodyKey = "Body"
    static let recordKey = "Entry"
    
}

class Entry {
    
    var title: String
    var bodyText: String
    let ckRecordID: CKRecord.ID
    
    init(title: String, bodyText: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.bodyText = bodyText
        self.ckRecordID = ckRecordID
    }
    
  convenience init?(record: CKRecord) {
    
    guard let title = record[Constants.titleKey] as? String,
        let bodyText = record[Constants.bodyKey] as? String else {return nil}
    
    self.init(title: title, bodyText: bodyText, ckRecordID: record.recordID)
    }
}

extension Entry: Equatable {
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.bodyText == rhs.bodyText
    }
}

extension CKRecord {
    
    convenience init(entry: Entry) {
        
        self.init(recordType: Constants.recordKey, recordID: entry.ckRecordID)
        
        self.setValue(entry.title, forKey: Constants.titleKey)
        self.setValue(entry.bodyText, forKey: Constants.bodyKey)
    }
}
