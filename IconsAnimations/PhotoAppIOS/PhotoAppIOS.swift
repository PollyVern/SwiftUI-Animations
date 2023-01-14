//
//  PhotoAppIOS.swift
//  PhotoAppIOS
//
//  Created by Polina Belovodskaya on 13.01.2023.
//

import SwiftUI

enum PetalColors: CaseIterable, Identifiable  {

    case orange
    case yellow
    case green
    case cyan
    case blue
    case purple
    case pink
    case red

    var id: Self { self }
    
    var topColor: Color {
        switch self {
        case .orange:
            return Color(red: 248.0/255.0, green: 155.0/255.0, blue: 53.0/255.0)
        case .yellow:
            return Color(red: 255.0/255.0, green: 232.0/255.0, blue: 55.0/255.0)
        case .green:
            return Color(red: 199.0/255.0, green: 219.0/255.0, blue: 67.0/255.0)
        case .cyan:
            return Color(red: 106.0/255.0, green: 186.0/255.0, blue: 188.0/255.0)
        case .blue:
            return Color(red: 105.0/255.0, green: 183.0/255.0, blue: 229.0/255.0)
        case .purple:
            return Color(red: 150.0/255.0, green: 142.0/255.0, blue: 196.0/255.0)
        case .pink:
            return Color(red: 205.0/255.0, green: 140.0/255.0, blue: 189.0/255.0)
        case .red:
            return Color(red: 242.0/255.0, green: 101.0/255.0, blue: 104.0/255.0)
        }
    }

    var bottomColor: Color {
        switch self {
        case .orange:
            return Color(red: 254.0/255.0, green: 194.0/255.0, blue: 41.0/255.0)
        case .yellow:
            return Color(red: 223.0/255.0, green: 221.0/255.0, blue: 49.0/255.0)
        case .green:
            return Color(red: 150.0/255.0, green: 204.0/255.0, blue: 106.0/255.0)
        case .cyan:
            return Color(red: 106.0/255.0, green: 195.0/255.0, blue: 133.0/255.0)
        case .blue:
            return Color(red: 135.0/255.0, green: 161.0/255.0, blue: 211.0/255.0)
        case .purple:
            return Color(red: 181.0/255.0, green: 142.0/255.0, blue: 193.0/255.0)
        case .pink:
            return Color(red: 226.0/255.0, green: 118.0/255.0, blue: 141.0/255.0)
        case .red:
            return Color(red: 243.0/255.0, green: 125.0/255.0, blue: 79.0/255.0)
        }
    }
}

struct PhotoAppIOS: View {
    private let colors = PetalColors.self
    @State private var isShowAnimation: Bool = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            background
        }
    }

    private var background: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 60)
                    .fill(.white)
                    .frame(width: geometry.size.width, height: geometry.size.width)

                ZStack {
                    ForEach(Array(colors.allCases.enumerated()), id: \.offset) { index, color in
                        setPetal(width: geometry.size.width, color: color, index: Double(index))
                    }
                }
                
                Button {
                    self.isShowAnimation.toggle()
                } label: {
                    Text("Tap")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                }
                .opacity(isShowAnimation ? 0 : 1)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .padding([.leading, .trailing], 30)
        .onTapGesture {
            self.isShowAnimation.toggle()
        }
    }

    private func setPetal(width: CGFloat ,color: PetalColors, index: Double) -> some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 60)
                .fill(.clear)
                .frame(width: width/3 - 30, height: width - 30)

            RoundedRectangle(cornerRadius: 60)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [color.topColor, color.bottomColor]), startPoint: .top, endPoint: .bottom)
                )
                .opacity(isShowAnimation ? 1 : 0)
                .blendMode(.multiply)
                .frame(width: width/3 - 20, height: width/2 - 20)
        }
        .rotationEffect(.degrees(isShowAnimation ? (index * 45.0) : 0))
        .animation(.spring(), value: isShowAnimation)
    }

}

struct PhotoAppIOS_Previews: PreviewProvider {
    static var previews: some View {
        PhotoAppIOS()
    }
}
