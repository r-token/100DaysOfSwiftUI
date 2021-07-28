//
//  ContentView.swift
//  Project9-Drawing
//
//  Created by Ryan Token on 7/22/21.
//

import SwiftUI

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var cgAmount: CGFloat = 0.0
    @State private var arrowLineWidth: CGFloat = 10.0
    @State private var colorCycle = 0.0
    @State private var insetAmount: CGFloat = 50
    @State private var rows = 4
    @State private var columns = 4
    
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        VStack {
//            Triangle()
//                .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .frame(width: 300, height: 300)

//            Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
//                .strokeBorder(Color.blue, lineWidth: 40)
            
            // ARROW (challenge day)
            Triangle()
                .stroke(Color.red, style: StrokeStyle(lineWidth: arrowLineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 75, height: 50)
                .onTapGesture {
                    withAnimation {
                        arrowLineWidth += 10
                    }
                }
            
            Rectangle()
                .stroke(Color.red, style: StrokeStyle(lineWidth: arrowLineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 30, height: 300)
                .onTapGesture {
                    withAnimation {
                        arrowLineWidth += 10
                    }
                }
            
            Slider(value: $arrowLineWidth, in: 1...50)
                .padding()

//            Circle()
//                .strokeBorder(Color.blue, lineWidth: 40)
            
//            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                .fill(Color.red, style: FillStyle(eoFill: true))
//
//            Text("Offset")
//            Slider(value: $petalOffset, in: -40...40)
//                .padding([.horizontal, .bottom])
//
//            Text("Width")
//            Slider(value: $petalWidth, in: 0...100)
//                .padding(.horizontal)
            
//            ZStack {
//                ForEach(0..<steps) { value in
//                    Circle()
//                        .inset(by: CGFloat(value))
//                        .strokeBorder(LinearGradient(gradient: Gradient(colors: [
//                            color(for: value, brightness: 1),
//                            color(for: value, brightness: 0.5)
//                        ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
//                }
//            }
//            .drawingGroup()
            
//            ZStack {
//                Image("PaulHudson")
//                    .colorMultiply(.red)
//
////                Rectangle()
////                    .fill(Color.red)
////                    .blendMode(.multiply)
//            }
//            .frame(width: 400, height: 500)
//            .clipped()
            
//            VStack {
//                Image("PaulHudson")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200)
//                    .saturation(Double(cgAmount))
//                    .blur(radius: (1 - cgAmount) * 20)
//
//                ZStack {
//                    Circle()
//                        .fill(Color.red)
//                        .frame(width: 200 * cgAmount)
//                        .offset(x: -50, y: -80)
//                        .blendMode(.screen)
//
//                    Circle()
//                        .fill(Color.green)
//                        .frame(width: 200 * cgAmount)
//                        .offset(x: 50, y: -80)
//                        .blendMode(.screen)
//
//                    Circle()
//                        .fill(Color.blue)
//                        .frame(width: 200 * cgAmount)
//                        .blendMode(.screen)
//                }
//                .frame(width: 300, height: 300)
//
//                Slider(value: $cgAmount)
//                    .padding()
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.black)
//            .edgesIgnoringSafeArea(.all)
            
//            Trapezoid(insetAmount: insetAmount)
//                .frame(width: 200, height: 100)
//                .onTapGesture {
//                    withAnimation {
//                        insetAmount = CGFloat.random(in: 10...90)
//                    }
//                }
            
//            Checkerboard(rows: rows, columns: columns)
//                .onTapGesture {
//                    withAnimation(.linear(duration: 3)) {
//                        self.rows = 8
//                        self.columns = 16
//                    }
//                }
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
}

struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20

    // How wide to make each petal
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()

        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)

            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))

            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)

            // add it to our main path
            path.addPath(rotatedPetal)
        }

        // now send the main path back
        return path
    }
}

struct Trapezoid: Shape {
    var insetAmount: CGFloat
    
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
   }
}

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
           AnimatablePair(Double(rows), Double(columns))
        }

        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // figure out how big each row/column needs to be
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)

        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
