//
//  PreloaderButton.swift
//  PreloaderButton
//
//  Created by Polina Belovodskaya on 05.01.2023.
//

import SwiftUI

struct PreloaderButton: View {

    @State private var isTapButton: Bool = false
    @State private var isAtMaxScale: Bool = false
    @State private var isShowArrows: Bool = false
    @State private var isShowCheckmark: Bool = false

    private let buttonSize: CGFloat = 50

    private let arrowsTimer = Timer.publish(every: 0.9, on: .main, in: .common).autoconnect()
    private let checkmarkTimer = Timer.publish(every: 0.9, on: .main, in: .common).autoconnect()

    var body: some View {

        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Button {
                isTapButton.toggle()
                isAtMaxScale.toggle()

            } label: {
                ZStack {
                    GeometryReader { geo in
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 30)
                                .fill(isTapButton ? .green : .white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.green, lineWidth: 2)
                                )
                                .frame(width: isShowArrows ? buttonSize : geo.size.width)
                                .animation(.spring().speed(0.5), value: isShowArrows)
                                .shadow(color: .green.opacity(0.5), radius: 20)
                            Spacer()
                        }
                    }
                    ZStack {
                        Text("Save")
                            .foregroundColor(isTapButton ? .white : .green)
                            .font(.system(size: 20, weight: .heavy, design: .default))
                            .scaleEffect(isAtMaxScale ? 0.8 : 1)
                            .animation(.spring(), value: isAtMaxScale)
                            .onReceive(arrowsTimer) { _ in
                                if isAtMaxScale {
                                    isAtMaxScale.toggle()
                                    isShowArrows.toggle()
                                    arrowsTimer.upstream.connect().cancel()
                                }
                            }
                            .opacity(isShowArrows || isShowCheckmark ? 0 : 1)
                            .animation(.spring().speed(0.5), value: isShowArrows)

                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.system(size: 25))
                            .frame(width: buttonSize, height: buttonSize)
                            .foregroundColor(.white)
                            .rotationEffect(Angle(degrees: self.isTapButton ? 360 : 0))
                            .animation(Animation.linear(duration: 2.0)
                                .repeatForever(autoreverses: false), value: isTapButton)
                            .opacity(isShowArrows ? 1 : 0)
                            .onReceive(checkmarkTimer) { _ in
                                if isShowArrows{
                                    isShowArrows.toggle()
                                    isShowCheckmark.toggle()
                                    checkmarkTimer.upstream.connect().cancel()
                                }
                            }

                        Image(systemName: "checkmark")
                            .font(.system(size: 25))
                            .frame(width: buttonSize, height: buttonSize)
                            .foregroundColor(.white)
                            .opacity(isShowCheckmark ? 1 : 0)
                    }
                }
                .frame(height: buttonSize)
            }
            .padding([.leading, .trailing], 30)
        }

    }
}

struct PreloaderButton_Previews: PreviewProvider {
    static var previews: some View {
        PreloaderButton()
    }
}
