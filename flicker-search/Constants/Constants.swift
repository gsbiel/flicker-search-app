//
//  Constants.swift
//  flicker-search
//
//  Created by user164622 on 2/25/20.
//  Copyright © 2020 user164622. All rights reserved.
//

import Foundation

struct K {
    enum SettingItems : String, CaseIterable {
        case Settings = "Settings"
        case TermsAndPolicy = "Terms and privacy policy"
        case Feedback = "Send feedback"
        case Help = "Help"
        case SwitchAccount = "Switch account"
        case Cancel = "Cancel"
    }
    
    static func getValue(enumItem: SettingItems) -> String {
        return enumItem.rawValue
    }
}

