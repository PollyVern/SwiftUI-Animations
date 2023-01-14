//
//  SliderButton.swift
//  SliderButton
//
//  Created by Polina Belovodskaya on 04.01.2023.
//

import SwiftUI

enum SliderButtonTypes: CaseIterable {

    case pay
    case processing
    case success

    var title: String {
        switch self {
        case .pay:
            return "PAY"
        case .processing:
            return "Processing..."
        case .success:
            return "Success"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .pay:
            return .blue
        case .processing:
            return .white
        case .success:
            return .green
        }
    }

    var titleColor: Color {
        switch self {
        case .pay:
            return .white
        case .processing:
            return .gray
        case .success:
            return .white
        }
    }

}


struct SliderButton: View {

    @State private var isTapButton: Bool = false
    @State private var isSuccess: Bool = false

    private var baseHeight: CGFloat = 50

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Button {
                isTapButton.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isSuccess.toggle()
                }
            } label: {
                VStack(spacing: 0) {
                    baseInternalView(type: .success)
                    baseInternalView(type: .processing)
                    baseInternalView(type: .pay)
                    Spacer()
                        .frame(height: baseHeight * 2)
                }
                .frame(height: baseHeight * CGFloat(SliderButtonTypes.allCases.count))
                .mask(
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: baseHeight)
                )
            }
            .padding([.leading, .trailing], 30)
            .disabled(isTapButton)
            .shadow(color: isTapButton ? (isSuccess ? .green.opacity(0.5) : .white.opacity(0.5)) : .blue.opacity(0.5), radius: 20)
        }

    }

    private func baseInternalView(type: SliderButtonTypes) -> some View {
        ZStack {
            Rectangle()
                .fill(type.backgroundColor)
                .frame(height: 50)
            Text(type.title)
                .foregroundColor(type.titleColor)
                .font(.system(size: 20, weight: .heavy, design: .default))
        }
        .frame(height: 50)
        .offset(y: isTapButton ? baseHeight : 0)
        .animation(.spring(), value: isTapButton)

        .offset(y: isSuccess ? baseHeight : 0)
        .animation(.spring(), value: isSuccess)
    }

}

struct SliderButton_Previews: PreviewProvider {
    static var previews: some View {
        SliderButton()
    }
}
