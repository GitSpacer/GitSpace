//
//  GSButton.swift
//  GSDesignSystem
//
//  Created by 원태영 on 10/5/23.
//

import SwiftUI

struct GSButton<Label: View>: View {
    
    enum Style {
        case primary(isDisabled: Bool)
        case secondary(isDisabled: Bool)
        case tag
        case plain
        case tab
    }
