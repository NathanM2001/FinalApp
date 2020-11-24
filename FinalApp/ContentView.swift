//
//  ContentView.swift
//  FinalApp
//
//  Created by Nathan Mckenzie on 11/23/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {

            VStack{

                Text("Mini Games")
                    Spacer()
                HStack{
                    Text("War Game")
                        .font(.title3)
                        .bold()
                        
                        
                        .padding(.leading, 70)
                    Spacer()
                    Text("Slots Machine")
                        .bold()
                        .font(.title3)
                        .padding(.trailing, 70)
                }
                HStack{
                    
                    NavigationLink(destination: WarGameView()) {
                        
                        Image("war")
                            .renderingMode(.original)
                            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                    }
                    .padding()
                    NavigationLink(destination: SlotMachineView()) {
                        
                        Image("slot")
                            .renderingMode(.original)
                            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                    }
                }
                
                Spacer()
            }
        }
        
    }
    }


struct SlotMachineView: View {
    @State private var symbols = ["apple", "star", "cherry"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    
    @State private var credits = 1000
    private var betAmount = 5
    var body: some View {
        
        ZStack{
            
            //background
            Rectangle().foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255)).rotationEffect(Angle(degrees: 45)).ignoresSafeArea(.all)
            VStack{
                Spacer()
                //title
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("Slots Machine")
                        .bold()
                        .foregroundColor(.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }.scaleEffect(2)
                Spacer()
                //credits counter
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                Spacer()
                //cards
                VStack{
                    HStack{
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[0]], background: $backgrounds[0])
                        
                        
                        CardView(symbol: $symbols[numbers[1]],background: $backgrounds[1])
                        
                        
                        CardView(symbol: $symbols[numbers[2]], background: $backgrounds[2])
                        
                        
                        
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[3]], background: $backgrounds[3])
                        
                        
                        CardView(symbol: $symbols[numbers[4]],background: $backgrounds[4])
                        
                        
                        CardView(symbol: $symbols[numbers[5]], background: $backgrounds[5])
                        
                        
                        
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[6]], background: $backgrounds[6])
                        
                        
                        CardView(symbol: $symbols[numbers[7]],background: $backgrounds[7])
                        
                        
                        CardView(symbol: $symbols[numbers[8]], background: $backgrounds[8])
                        
                        
                        
                        Spacer()
                    }
                }
                Spacer()
                //Button
                
                HStack(spacing: 20)
                {
                    VStack{
                        Button(action:{
                            //TODO
                            //process a single spin
                            self.processResults()
                        }){
                            Text("Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all,10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount) Credits")
                            .padding(.top, 10)
                            .font(.footnote)
                    }
                    VStack{
                        Button(action:{
                            //TODO
                            //process a single spin
                            self.processResults(true)
                        }){
                            Text("Max Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all,10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount * 5) Credits")
                            .padding(.top, 10)
                            .font(.footnote)
                    }
                }
                Spacer()
            }
        }
    }
    
    func processResults(_ isMax: Bool = false){
        //sets background to white
        self.backgrounds = self.backgrounds.map({_ in
            Color.white
        })
        
        if isMax {
            //spin all the cards
            self.numbers = self.numbers.map({ _ in
                Int.random(in: 0...self.symbols.count - 1)
            })
        }
        else{
            //spin the middle row
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
        }
        
        //check winner
        processWin(isMax)
        
    }
    
    func processWin(_ isMax: Bool = false){
        
        var matches = 0
        
        if !isMax{
            
            //processing for single spin
            if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5]{
                
                //won
                matches += 1
                
                //update backgrounds to green
                self.backgrounds[3] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[5] = Color.green
                
            }
        }
        else{
            //processing for max spin
            
            //top row
            if self.numbers[0] == self.numbers[1] && self.numbers[1] == self.numbers[2]{
                //won
                matches += 1
                
                //update background to green
                self.backgrounds[0] = Color.green
                self.backgrounds[1] = Color.green
                self.backgrounds[2] = Color.green
                
            }
            //middle row
            if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5]{
                //won
                matches += 1
                
                //update background to green
                self.backgrounds[3] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[5] = Color.green
            }
            //bottom row
            if self.numbers[6] == self.numbers[7] && self.numbers[7] == self.numbers[8]{
                //won
                matches += 1
                
                //update background to green
                self.backgrounds[6] = Color.green
                self.backgrounds[7] = Color.green
                self.backgrounds[8] = Color.green
                
            }
        
            //diagnol top left to bottom right
            if self.numbers[0] == self.numbers[4] && self.numbers[4] == self.numbers[8]{
                //won
                matches += 1
                
                //update background to green
                self.backgrounds[0] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[8] = Color.green
                
            }
            //diagnol top right to bottom left
            if self.numbers[2] == self.numbers[4] && self.numbers[4] == self.numbers[4]{
                //won
                matches += 1
                
                //update background to green
                self.backgrounds[2] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[6] = Color.green
            }
        }
        //check matches and distribute credits
        if matches > 0{
            //at least 1 one
            self.credits += matches * betAmount * 2
        }
        else if !isMax {
            // 0 win, single spin
            self.credits -= betAmount
        }
        else{
            //0 wins, max spin
            self.credits -= betAmount * 5
        }
    }
}


struct WarGameView: View{
        @State private var randNum1 = 2
        @State private var randNum2 = 2
        
        @State private var score1 = 0
        @State private var score2 = 0

        
        var body: some View {
                   
            ZStack{
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    Image("logo")
                    Spacer()
                    HStack{
                        Image("card" + String(randNum1))
                        Image("card" + String(randNum2))
                    }
                    Spacer()
                    
                    Button(action: {
                        //Randomize the ranNum1 + randNum2 state properties
                        self.randNum1 = Int.random(in: 2 ... 14)
                        self.randNum2 = Int.random(in: 2...14)
                        
                        //Update scores
                        if self.randNum1 > self.randNum2{
                            self.score1 += 1
                        }
                        else if self.randNum2 > self.randNum1{
                            self.score2 += 1
                        }
                        
                    }, label: {
                        Image("dealbutton")
                            .renderingMode(.original)
                            
                    })
                    
                    Spacer()
                    
                    HStack{
                        VStack{
                            Text("Player")
                                .bold()
                                .padding(.bottom, 20)
                            Text(String(score1))
                        }
                        .padding(.leading, 20)
                        .foregroundColor(.white)
                        
                        Spacer()
                        VStack{
                            Text("CPU")
                                .bold()
                                .padding(.bottom, 20)
                            Text(String(score2))
                        }
                        .padding(.trailing, 20)
                        .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
