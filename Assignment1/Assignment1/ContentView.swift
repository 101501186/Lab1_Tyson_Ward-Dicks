// COMP 3097 Lab Assignment 1
// Tyson Ward-Dicks - 101501186

import SwiftUI

struct ContentView: View {
    
    @State private var number = Int.random(in: 1...100)
    @State private var correctCount = 0
    @State private var wrongCount = 0
    @State private var attempts = 0
    
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
    
    func isPrime(_ n: Int) -> Bool {
        if n <= 1 { return false }
        if n <= 3 { return true }
        for i in 2...Int(sqrt(Double(n))) {
            if n % i == 0 {
                return false
            }
        }
        return true
    }
}

#Preview {
    ContentView()
}
