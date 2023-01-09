//
//  InfographicElement.swift
//  InfographicElement
//
//  Created by Polina Belovodskaya on 08.01.2023.
//

import SwiftUI

struct InfographicElement: View {

    private let rectangleSize = UIScreen.main.bounds.width/2 - 20
    private let miniBlocksColumns = Array(repeating: GridItem(.flexible(), spacing: 20, alignment: .center), count: 2)

    @State private var isShowAnimation: Bool = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            LazyVGrid(columns: miniBlocksColumns, spacing: 10) {
                ForEach(InfographicElementType.allCases, id: \.hashValue) { type in
                    setSectionElement(type: type)
                        .animation(.spring().delay(type.delay), value: isShowAnimation)
                }
            }
            .padding([.leading, .trailing], 20)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isShowAnimation.toggle()
                }
            }
        }
    }

    private func setSectionElement(type: InfographicElementType) -> some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 210.0/255.0, green: 98.0/255.0, blue: 112.0/255.0))
            ZStack {
                ZStack(alignment: type.zStackAlignment) {
                    Rectangle()
                        .fill(type.color)

                    HStack {

                        if type == .secondSection || type == .fourthSection {
                            numberElement(text: type.numberText, edge: .leading)
                            divider
                        }

                        VStack(alignment: type.textHorizontalAlignment) {
                            Text(type.titleText)
                                .font(.system(size: 15))
                                .foregroundColor(.white)

                            Text(type.descriptionText)
                                .font(.system(size: 10))
                                .foregroundColor(.white)
                        }
                        .multilineTextAlignment(type.textAlignment)
                        .padding([.leading, .trailing], 20)

                        if type == .firstSection || type == .thirdSection {
                            divider
                            numberElement(text: type.numberText, edge: .trailing)
                        }

                    }
                    .padding([.top, .bottom], 20)
                }

                ZStack {
                    Circle()
                        .blendMode(.destinationOut)
                        .frame(width: rectangleSize, height: rectangleSize)
                        .padding([type.circleEdgeY, type.circleEdgeX], -rectangleSize)

                    Image(systemName: type.icon)
                        .font(.system(size: rectangleSize/6))
                        .foregroundColor(.white).opacity(0.8)
                        .frame(width: rectangleSize/6, height: rectangleSize/6)
                        .padding([type.iconEdgeY, type.iconEdgeX], rectangleSize/2 + 20)
                }
            }
            .compositingGroup()

        }
        .frame(width: isShowAnimation ? rectangleSize : 0, height: isShowAnimation ? rectangleSize : 0)
        .cornerRadius(30, corners: type.singleCorner)
    }

    private var divider: some View {
        Divider()
            .frame(width: 2, height: 50)
            .overlay(.white)
    }

    private func numberElement(text: String, edge: Edge.Set) -> some View {
        Text(text)
            .font(.system(size: 30))
            .padding(edge, 10)
            .foregroundColor(.white)
    }
}

struct InfographicElement_Previews: PreviewProvider {
    static var previews: some View {
        InfographicElement()
    }
}
