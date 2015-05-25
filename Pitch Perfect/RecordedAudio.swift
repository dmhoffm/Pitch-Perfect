//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by David Hoffman on 5/24/15.
//  Copyright (c) 2015 JohnMuirHealth. All rights reserved.
//

import Foundation

//
// model for recorded audio object
//
class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(fromFilePathUrl filePathUrl: NSURL!, fromTitle title: String!) {
        self.filePathUrl = filePathUrl
        self.title  = title
    }
}
