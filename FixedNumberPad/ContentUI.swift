
//  ContentUI.swift
//  FixedNumberPad
//
//  Created by Chris Milne on 18/06/2025.
//  Use this version in coordination with InputFieldsUI

import SwiftUI

enum NavigationTarget: Hashable {
    case next
    case last
}
enum FocusedField: Hashable {
    case fieldA, fieldB, fieldC
}

struct ContentUI: View {
    @State private var inStringA: String = ""
    @State private var inputA: Double = 0.0
    @State private var inStringB: String = ""
    @State private var inputB: Double = 0.0
    @State private var inStringC: String = ""
    @State private var inputC: Double = 0.0
    @State private var note: String = "mm"
    @State private var Inputvalue: String = ""
    @State var Outputvalue: Double = 0.0
    @State private var navPath: [NavigationTarget] = [] /// It's an array to hold more than one destination. E.G LastScreen or NextScreen
    @State private var activeField: FocusedField = .fieldA
    @State var isStyled: Bool = false /// Style applied to the active input field
    @State var temp: Bool = false
    
    var body: some View {
        
        NavigationStack(path: $navPath) {

                Text("Fixed Input Pad Demo \n")
                    .font(.title)
            VStack(alignment: .leading, spacing: 6) {
                /// This section to be used to interface to InputFieldsUI
                KeyPadInput(text: $inStringA, isStyled: activeField == .fieldA, label: "Input A", unit: note)
                    .frame(height: 40)
                KeyPadInput(text: $inStringB, isStyled: activeField == .fieldB, label: "Input B", unit: note)
                    .frame(height: 40)
                KeyPadInput(text: $inStringC, isStyled: activeField == .fieldC, label: "Input C", unit: note)
                    .frame(height: 40)
                
                
            } // VStack
            Spacer()
            .onAppear {
                activeField = .fieldA
            } // on Appear
            
            
            
            
            
            /// activeInputBinding Lets numeric keypad dynamically update the currently active field
            var activeInputBinding: Binding<String> {
                switch activeField {
                case .fieldA:
                    return $inStringA
                case .fieldB:
                    return $inStringB
                case .fieldC:
                    return $inStringC
                    
                }
            }
            
            
            
            
            NumericKeypad(
                input: activeInputBinding,
                onCommit: {
                    switch activeField {
                    case .fieldA:
                        inputA = Double(inStringA) ?? 0.0
                    case .fieldB:
                        inputB = Double(inStringB) ?? 0.0
                    case .fieldC:
                        inputC = Double(inStringC) ?? 0.0
                        
                    }
                },
                onTAB: {
                    withAnimation {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            switch activeField {
                            case .fieldA: activeField = .fieldB
                            case .fieldB: activeField = .fieldC
                            case .fieldC: activeField = .fieldA
                            }
                        }
                    }
                },
                
                path: $navPath
            )
            
            .navigationDestination(for: NavigationTarget.self) { target in
                switch target {
                case .next: NextScreen()
                case .last: LastScreen()
                } // switch target
            } // navigation Destination
        }  // NavStack
    } // Body
} // struct

#Preview {
    ContentUI()
}

