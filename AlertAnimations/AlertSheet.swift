//
//  AlertSheet.swift
//  AlertSheet
//
//  Created by Polina Belovodskaya on 07.01.2023.
//

import SwiftUI

enum AlertSheetType {
    case warning
    case info

    var icon: String {
        switch self {
        case .warning:
            return "xmark.diamond.fill"
        case .info:
            return "info.circle"
        }
    }

    var title: String {
        switch self {
        case .warning:
            return "Some warning\ntitle text ..."
        case .info:
            return "Some info\ntitle text ..."
        }
    }
}

struct AlertSheet: View {

    @State private var isOpen: Bool = false
    @State private var alertType: AlertSheetType = .info

    private let screenHeight = UIScreen.main.bounds.height
    private let screenWidth = UIScreen.main.bounds.width
    private let mainCircleSize = UIScreen.main.bounds.width/3
    private let maskCircleSize = UIScreen.main.bounds.width/2

    var body: some View {

        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack(alignment: .bottom) {
                    backView
                    frontView
                }
                setButtons
            }
            .padding([.leading, .trailing], 60)
        }
        .onAppear {
            isOpen.toggle()
        }
    }

    private var frontView: some View {
        ZStack {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill((alertType == .info) ? AnyShapeStyle(.blue.gradient) : AnyShapeStyle(.red.gradient))
                    .frame(height: screenHeight/2.5)
                    .padding(.top, 30)
                    .cornerRadius(30)
                    .padding(.top, -30)

                Circle()
                    .blendMode(.destinationOut)
                    .frame(width: maskCircleSize)
                    .padding(.top, (-maskCircleSize)/2)

            }
            .compositingGroup()

            Text(alertType.title)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .heavy, design: .default))
                .multilineTextAlignment(.center)
        }
    }

    private var backView: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 30)
                .fill(.white.gradient)
                .frame(height: screenHeight/2.5 + 30)

            ZStack {
                Circle()
                    .fill((alertType == .info) ? AnyShapeStyle(.blue.gradient) : AnyShapeStyle(.red.gradient))
                    .frame(width: mainCircleSize)
                    .shadow(radius: 10)

                Image(systemName:alertType.icon)
                    .font(.system(size: mainCircleSize/2))
                    .frame(width: mainCircleSize/2, height: mainCircleSize/2)
                    .foregroundColor(.white)
            }
            .padding(.top, 20)
        }
        .offset(y: isOpen ? -(mainCircleSize/2 - 20) : 0)
        .animation(.spring(), value: isOpen)
        .padding([.leading, .trailing], 20)
    }

    private var setButtons: some View {
        VStack {
            HStack {
                Button {
                    self.alertType = .info
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.white)
                        Text("Info")
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                    }
                }

                Button {
                    alertType = .warning
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.white)
                        Text("Warning")
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                    }
                }
            }
            .frame(height: 30)
            .padding(.top, 30)

            Button {
                isOpen.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.white)
                    Text("Close/Open")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                }
            }
            .frame(height: 30)
        }
    }

}

struct AlertSheet_Previews: PreviewProvider {
    static var previews: some View {
        AlertSheet()
    }
}
