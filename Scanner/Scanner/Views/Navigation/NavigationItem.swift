//
//  NavigationItem.swift
//  Scanner
//
//  Created by Mirza Baig on 15/04/23.
//

import SwiftUI

enum NavigationItem: Int, Hashable, CaseIterable, Identifiable, Codable{
    case recent
    case browse
    
    var id: Int{rawValue}
    
    var localizedName:LocalizedStringKey{
        switch self{
        case .recent:
            return "Recent"
        case .browse:
            return "Browse"
        }
    }
}
