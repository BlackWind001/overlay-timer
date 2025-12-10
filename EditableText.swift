//
//  EditableText.swift
//  Overlay Timer 2
//
//  Created by Anirudh Kumar on 07/12/25.
//

import SwiftUI

struct EditableText: View {
    let onChange: (String) -> String
    let onSubmit: (String) -> Void
    let onEdit: (_ isGoingToEdit: Bool) -> Void
    @Binding var text: String
    @Binding var isEditing: Bool
    @State private var isError = false
    @State private var textInput: String = "";
    
    init(onChange: @escaping (String) -> String, onSubmit: @escaping (String) -> Void, onEdit: @escaping (_: Bool) -> Void, text: Binding<String>, isEditing: Binding<Bool>, isError: Bool = false) {
        self.onChange = onChange
        self.onSubmit = onSubmit
        self.onEdit = onEdit
        self._text = text
        self._isEditing = isEditing
        self.isError = isError
        self._textInput = State(initialValue: text.wrappedValue)
    }
    
    
    var body: some View {
        let width = CGFloat(64)
        
        HStack {
            if isEditing {
                TextField("", text: $textInput)
                    .textFieldStyle(.plain)
                    .frame(height: 48)
                    .frame(width: width)
                    .border(Color.gray)
                    .onSubmit {
                        if (!isError) {
                            onSubmit(textInput)
                        }
                    }
                    .onChange(of: textInput) { newValue in
                        
                        textInput = onChange(newValue)
                    }
            }
            else {
                Text(text)
                    .frame(width: width)
            }
        }
        .onTapGesture {
            onEdit(!isEditing)
        }
        .onChange(of: text) { newValue in
            textInput = newValue
        }
    }
}
