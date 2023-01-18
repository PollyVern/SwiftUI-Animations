//
//  DisclosureCustomCheckList.swift
//  DisclosureCustomCheckList
//
//  Created by Polina Belovodskaya on 17.01.2023.
//

import SwiftUI

struct Algorithms: Identifiable {
    let id = UUID()
    let tag: String
    var isSelected: Bool
}

struct DisclosureCustomCheckList: View {

    @State private var algorithms = [Algorithms(tag: "Array", isSelected: false),
                              Algorithms(tag: "Hash Table", isSelected: false),
                              Algorithms(tag: "Binary Search", isSelected: false),
                              Algorithms(tag: "Database", isSelected: false)]

    @State private var isTapMenu: Bool = false
    @State private var isFirstShow: Bool = false
    @State private var isTapList: Bool = false
    private var accentColor = Color(red: 108.0/255.0, green: 9.0/255.0, blue: 34.0/255.0)

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                buttonWithArrow
                checkList
            }
            .frame(width: 250)
        }
        .onAppear {
            isFirstShow.toggle()
        }
    }

    private var buttonWithArrow: some View {
        Button {
            withAnimation {
                isTapMenu.toggle()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .frame(width: isFirstShow ? 250 : 60)
                VStack {
                    HStack {
                        if isFirstShow {
                            Text("Choose algorithms")
                                .font(
                                    .custom(
                                        "AmericanTypewriter",
                                        fixedSize: 18)
                                )
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        Image(systemName: "chevron.backward")
                            .font(.headline)
                            .foregroundColor(accentColor)
                            .rotationEffect(.degrees(isTapMenu ? 90 : 270))
                    }
                    .animation(.spring(), value: isTapMenu)
                    .padding()
                }
            }
        }
        .animation(
            .interpolatingSpring(mass: 1.0,
                                 stiffness: 100,
                                 damping: 10,
                                 initialVelocity: 0).delay(1),
            value: isFirstShow)
        .frame(height: 60)
        .padding(.bottom, 10)
    }

    private var checkList: some View {
        VStack(spacing: 0) {
            ForEach(Array(algorithms.enumerated()), id: \.offset) { index, algorithm in
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(corners: setCorner(index: index, modelCount: algorithms.count))
                    HStack {
                        Text(algorithm.tag)
                            .font(
                                .custom(
                                    "AmericanTypewriter",
                                    fixedSize: 18)
                            )
                            .foregroundColor(accentColor)
                        Spacer()
                        Image(systemName: "checkmark")
                            .font(.system(size: 15))
                            .foregroundColor(accentColor)
                            .opacity(algorithm.isSelected ? 1 : 0)
                            .animation(.spring(), value: algorithm.isSelected)
                    }
                    .padding()
                }
                .frame(height: 60)
                .onTapGesture {
                    isTapList.toggle()
                    algorithms[index].isSelected.toggle()
                }
            }
        }
        .opacity(isTapMenu ? 1 : 0)
        .frame(height: isTapMenu ? CGFloat(60 * algorithms.count) : 0)
        .animation(.easeInOut.delay(isTapMenu ? 0.2 : 0), value: isTapMenu)
    }

    private func setCorner(index: Int, modelCount: Int) -> RectCornerTypes {
        if index == 0 && modelCount == 1 {
            return .all
        } else if index == 0 {
            return .top
        } else if index == modelCount - 1 {
            return .bottom
        } else {
            return .notAll
        }
    }
}

struct DisclosureCustomCheckList_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureCustomCheckList()
    }
}


extension View {
    func cornerRadius(corners: RectCornerTypes) -> some View {
        if corners == .notAll {
            return clipShape(RoundedCorner(radius: 0, corners: corners.corners) )
        } else {
            return clipShape(RoundedCorner(radius: 15, corners: corners.corners) )
        }
    }
}

struct RoundedViewCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

enum RectCornerTypes {
    case top
    case bottom
    case all
    case notAll

    var corners: UIRectCorner {
        switch self {
        case .top:
            return [.topLeft, .topRight ]
        case .bottom:
            return [.bottomLeft, .bottomRight]
        case .all:
            return [.allCorners]
        case .notAll:
            return [.allCorners]
        }
    }
}
