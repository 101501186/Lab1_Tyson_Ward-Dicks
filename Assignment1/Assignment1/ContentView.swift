// COMP 3097 Lab Assignment 1
// Tyson Ward-Dicks - 101501186

import SwiftUI

import Combine

struct ContentView: View {
    
    @State private var number = Int.random(in: 1...100)
    @State private var correctCount = 0
    @State private var wrongCount = 0
    @State private var attempts = 0
    @State private var showTick = false
    @State private var showCross = false
    @State private var showAlert = false
    @State private var userAnswered = false
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        
        VStack {
            Text("\(number)")
                            .font(.system(size: 80, weight: .bold))
            
            HStack(spacing: 40) {
                Button("Prime") {
                    checkAnswer(userSaysPrime: true)
                }
                
                Button("Not Prime") {
                    checkAnswer(userSaysPrime: false)
                }
            }
            .font(.title)
            
            Text("Correct: \(correctCount)   Wrong: \(wrongCount)")
                .font(.title3)
            
            Text("Attempts: \(attempts)")
                .font(.caption)
                .foregroundColor(.gray)
            
            if showTick {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
            }

            if showCross {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
            }
            
            
        }
        .padding()
        .alert("Results After 10 Attempts", isPresented: $showAlert) {
                    Button("OK") { }
                } message: {
                    Text("Correct: \(correctCount)\nWrong: \(wrongCount)")
                }
        .onReceive(timer) { _ in
            if !userAnswered {
                wrongCount += 1
                attempts += 1

                if attempts % 10 == 0 {
                    showAlert = true
                }
            }

            generateNewNumber()
        }
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
    
    func generateNewNumber() {
        number = Int.random(in: 1...100)
        userAnswered = false
        resetTimer()
    }
    
    func checkAnswer(userSaysPrime: Bool) {
        if userAnswered { return }   // ignore multiple taps
            userAnswered = true
        
        let actualPrime = isPrime(number)

        if userSaysPrime == actualPrime {
            correctCount += 1
            showTick = true
            showCross = false
            print("Correct!")
        } else {
            wrongCount += 1
            showCross = true
            showTick = false
            print("Wrong!")
        }
        attempts += 1
        
        if attempts % 10 == 0 {
            showAlert = true
        }
        
        resetTimer()
        
        generateNewNumber()
    }
    
    func resetTimer() {
        timer.upstream.connect().cancel() // cancel the current timer
        timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    }
}

#Preview {
    ContentView()
}
