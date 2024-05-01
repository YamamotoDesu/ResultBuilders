/// Copyright (c) 2023 Kodeco Inc.
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct SilhouetteView: View {
  @State var eyePosition: Double = 30.0

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Canvas { context, size in
          var hatTop = Path()
          let hatTopWidth = 80.0
          let hatTopCenterX = size.width / 2 - hatTopWidth / 2
          let hatTopRect = CGRect(origin: CGPoint(x: hatTopCenterX, y: 0), size: CGSize(width: hatTopWidth, height: 36))
          hatTop.addRoundedRect(in: hatTopRect, cornerSize: CGSize(width: 6, height: 6))
          context.fill(hatTop, with: .color(.black))

          var hatBrim = Path()
          hatBrim.addEllipse(in: CGRect(
            origin: CGPoint(x: size.width / 4, y: 30),
            size: CGSize(width: size.width / 2, height: 18))
          )
          context.fill(hatBrim, with: .color(.black))

          let centerX = size.width / 2

          var eye1 = Path()
          eye1.addRelativeArc(
            center: CGPoint(x: centerX - 20, y: 50),
            radius: 20,
            startAngle: .degrees(0),
            delta: .degrees(180)
          )
          context.fill(eye1, with: .color(.black))

          var eye2 = Path()
          eye2.addRelativeArc(
            center: CGPoint(x: centerX + 20, y: 50),
            radius: 20,
            startAngle: .degrees(0),
            delta: .degrees(180)
          )
          context.fill(eye2, with: .color(.black))
        }

        eyeBall(rect: geometry.frame(in: .local))
          .fill(Color.white)
          .offset(x: -eyePosition, y: 50)
          .animation(.easeIn(duration: 2).delay(5).repeatForever(autoreverses: true), value: eyePosition)

        eyeBall(rect: geometry.frame(in: .local))
          .fill(Color.white)
          .offset(x: -eyePosition + 40, y: 50)
          .animation(.easeIn(duration: 2).delay(5).repeatForever(autoreverses: true), value: eyePosition)
      }
    }
    .onAppear {
      eyePosition = 10.0
    }
  }

  private func eyeBall(rect: CGRect) -> Path {
    let centerX = rect.size.width / 2
    return Path { path in
      path.addRelativeArc(
        center: CGPoint(x: centerX, y: 0),
        radius: 6,
        startAngle: .degrees(0),
        delta: .degrees(180)
      )
    }
  }
}

struct SilhouetteView_Previews: PreviewProvider {
  static var previews: some View {
    SilhouetteView()
  }
}
