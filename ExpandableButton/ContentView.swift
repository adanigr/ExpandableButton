//
//  ContentView.swift
//  ExpandableButton
//
//  Created by Adan Reséndiz on 17/11/20.
//

import SwiftUI

// MARK: - Define local structs
struct ExpandableButtonItem: Identifiable {
    let id = UUID()
    let label: Image
    var action: (() -> Void)? = nil
}

struct ExpandableButtonPanel: View {
    let primaryButton: ExpandableButtonItem
    let secondaryButtons: [ExpandableButtonItem]
    
    private let size: CGFloat = 65
    private var cornerRadius: CGFloat {
        get { size /  2 }
    }
    
    // MARK: - Define local state vars
    @State private var isExpanded = false
    
    // MARK: Define view panel
    var body: some View {
        VStack {
            
            if isExpanded {
                ForEach(secondaryButtons){ button in
                    Button(action: {
                        withAnimation {
                            self.isExpanded.toggle()
                        }
                        
                        button.action?()
                    }, label: {
                        button.label
                    })
                    .frame(width: self.size, height: self.size)
                }
            }
            
            Button( action: {
                withAnimation {
                    self.isExpanded.toggle()
                }
                
                self.primaryButton.action?()
            }, label: {
                self.primaryButton.label
            })
            .frame(width: self.size, height: self.size)
        }
        // MARK: Add style to VStack
        .background(Color.white)
        .cornerRadius(cornerRadius)
        .shadow(radius: 10)
    }
}

struct ContentView: View {
    // MARK: - Define local state vars
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List(1...20, id: \.self) { i in
                    Text("Row #\(i)")
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ExpandableButtonPanel(
                            primaryButton: ExpandableButtonItem(label: Image(systemName: "ellipsis")),
                            secondaryButtons: [
                                ExpandableButtonItem(label: Image(systemName: "photo")) {
                                    self.showAlert.toggle()
                                },
                                ExpandableButtonItem(label: Image(systemName: "camera")) {
                                    self.showAlert.toggle()
                                },
                            ]
                        )
                        .padding()
                    }
                }
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Tap!"))
                })
            }
            .navigationTitle("Expandable Button")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
