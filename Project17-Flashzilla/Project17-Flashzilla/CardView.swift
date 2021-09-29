//
//  CardView.swift
//  Project17-Flashzilla
//
//  Created by Ryan Token on 9/24/21.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    @Binding var recycleIncorrectAnswers: Bool
    
    let card: Card
    @Binding var cards: [Card]
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))

                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(offset.width > 0 ? Color.green : Color.red)
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        
        .gesture(
            DragGesture()
                .onChanged { offset in
                    self.offset = offset.translation
                    feedback.prepare()
                }

                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            feedback.notificationOccurred(.success)
                            removal?()
                        } else {
                            feedback.notificationOccurred(.error)
                            
                            if recycleIncorrectAnswers {
                                print("recycling incorrect answer")
                                
                                withAnimation {
                                    cards.insert(card, at: 0)
                                }
                            } else {
                                removal?()
                            }
                        }
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
}
