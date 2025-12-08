//
//  EditableText.swift
//  Overlay Timer 2
//
//  Created by Anirudh Kumar on 07/12/25.
//

import SwiftUI

struct EditableText: View {
    let onValidate: (String) -> Bool
    @Binding var text: String
    @State private var isEditing = false
    @State private var isError = false
    
    var body: some View {
        HStack {
            if isEditing {
                TextField("", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        if (!isError) {
                            isEditing = false
                        }
                    }
                    .onChange(of: text) { newValue in
                        
                        if onValidate(newValue) {
                            isError = false
                        }
                        else {
                            isError = true
                        }
                    }
            }
            else {
                Text(text)
            }
        }
        .onTapGesture {
            isEditing = !isEditing
        }
    }
}
