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
                .foregroundColor(.blue)
                .padding(50)
                .shadow(radius: 5)
            
            HStack(spacing: 40) {
                Button("Prime") {
                    checkAnswer(userSaysPrime: true)
                }
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 140, height: 60)
                .background(Color.green)
                .cornerRadius(15)
                .shadow(radius: 5)
                
                Button("Not Prime") {
                    checkAnswer(userSaysPrime: false)
                }
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 140, height: 60)
                .background(Color.green)
                .cornerRadius(15)
                .shadow(radius: 5)
            }
            
            
            Text("Correct: \(correctCount)   Wrong: \(wrongCount)")
                .font(.title3)
                .padding(.top, 20)
            
            Text("Attempts: \(attempts)")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 5)
            
            if showTick {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.green)
                    .transition(.scale)
                    .padding(.top, 20)
            }

            if showCross {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.red)
                    .transition(.scale)
                    .padding(.top, 20)
            }
            
            Button("Reset Game") {
                resetGame()
            }
            .font(.title3)
            .padding()
            .frame(width: 180, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            
            
        }
        .padding()
        .alert("Results After 10 Attempts", isPresented: $showAlert) {
            Button("OK") {
                showAlert = false
                resetTimer()
            }
        } message: {
            Text("Correct: \(correctCount)\nWrong: \(wrongCount)")
        }
        .onReceive(timer) { _ in
            if showAlert { return }

            if !userAnswered {
                wrongCount += 1
                attempts += 1
                showCross = true
                showTick = false

                userAnswered = true

                if attempts % 10 == 0 {
                    showAlert = true
                }

                
                generateNewNumber()
            
            }
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
        if userAnswered || showAlert { return }
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
        timer.upstream.connect().cancel()
        timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    }
    
    func resetGame() {
        correctCount = 0
        wrongCount = 0
        attempts = 0
        showTick = false
        showCross = false
        userAnswered = false
        generateNewNumber()
        resetTimer()        
    }
}

#Preview {
    ContentView()
}
