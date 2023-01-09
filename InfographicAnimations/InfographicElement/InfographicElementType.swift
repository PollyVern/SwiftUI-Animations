//
//  InfographicElementType.swift
//  InfographicElement
//
//  Created by Polina Belovodskaya on 09.01.2023.
//

import SwiftUI

enum InfographicElementType: CaseIterable {
    case firstSection
    case secondSection
    case thirdSection
    case fourthSection

    var color: Color {
        switch self {
        case .firstSection:
            return Color(red: 240.0/255.0, green: 194.0/255.0, blue: 196.0/255.0)
        case .secondSection:
            return Color(red: 217.0/255.0, green: 165.0/255.0, blue: 167.0/255.0)
        case .thirdSection:
            return Color(red: 137.0/255.0, green: 82.0/255.0, blue: 90.0/255.0)
        case .fourthSection:
            return Color(red: 200.0/255.0, green: 124.0/255.0, blue: 136.0/255.0)
        }
    }

    var circleEdgeY: Edge.Set {
        switch self {
        case .firstSection:
            return .bottom
        case .secondSection:
            return .bottom
        case .thirdSection:
            return .top
        case .fourthSection:
            return .top
        }
    }

    var circleEdgeX: Edge.Set {
        switch self {
        case .firstSection:
            return .trailing
        case .secondSection:
            return .leading
        case .thirdSection:
            return .trailing
        case .fourthSection:
            return .leading
        }
    }

    var iconEdgeX: Edge.Set {
        switch self {
        case .firstSection:
            return .leading
        case .secondSection:
            return .trailing
        case .thirdSection:
            return .leading
        case .fourthSection:
            return .trailing
        }
    }

    var iconEdgeY: Edge.Set {
        switch self {
        case .firstSection:
            return .top
        case .secondSection:
            return .top
        case .thirdSection:
            return .bottom
        case .fourthSection:
            return .bottom
        }
    }

    var singleCorner: UIRectCorner {
        switch self {
        case .firstSection:
            return .topLeft
        case .secondSection:
            return .topRight
        case .thirdSection:
            return .bottomLeft
        case .fourthSection:
            return .bottomRight
        }
    }

    var titleText: String {
        return "LOREM IPSUM"
    }

    var descriptionText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    }

    var textAlignment: TextAlignment {
        switch self {
        case .firstSection:
            return .trailing
        case .secondSection:
            return .leading
        case .thirdSection:
            return .trailing
        case .fourthSection:
            return .leading
        }
    }

    var zStackAlignment: Alignment {
        switch self {
        case .firstSection:
            return .top
        case .secondSection:
            return .top
        case .thirdSection:
            return .bottom
        case .fourthSection:
            return .bottom
        }
    }

    var textHorizontalAlignment: HorizontalAlignment {
        switch self {
        case .firstSection:
            return .trailing
        case .secondSection:
            return .leading
        case .thirdSection:
            return .trailing
        case .fourthSection:
            return .leading
        }
    }

    var numberText: String {
        switch self {
        case .firstSection:
            return "1"
        case .secondSection:
            return "2"
        case .thirdSection:
            return "3"
        case .fourthSection:
            return "4"
        }
    }

    var icon: String {
        switch self {
        case .firstSection:
            return "leaf"
        case .secondSection:
            return "ladybug"
        case .thirdSection:
            return "pawprint"
        case .fourthSection:
            return "ant"
        }
    }

    var delay: Double {
        switch self {
        case .firstSection:
            return 0
        case .secondSection:
            return 0.05
        case .thirdSection:
            return 0.1
        case .fourthSection:
            return 0.15
        }
    }

}
