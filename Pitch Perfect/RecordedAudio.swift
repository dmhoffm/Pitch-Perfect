//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by David Hoffman on 5/24/15.
//  Copyright (c) 2015 JohnMuirHealth. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(fromUrl url: NSURL!, fromTitle t: String!) {
        filePathUrl = url
        title = t
    }
}
