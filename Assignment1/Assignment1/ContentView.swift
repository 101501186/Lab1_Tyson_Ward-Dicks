// COMP 3097 Lab Assignment 1
// Tyson Ward-Dicks - 101501186

import SwiftUI

struct ContentView: View {
    
    @State private var number = Int.random(in: 1...100)
    
    var body: some View {
        VStack {
            Text("\(number)")
                            .font(.system(size: 80, weight: .bold))
            
            HStack(spacing: 40) {
                Button("Prime") {
                    print("Prime Selected")
                }
                
                Button("Not Prime") {
                    print("Not Prime tapped")
                }
            }
            .font(.title)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
