//
//  EditableText.swift
//  Overlay Timer 2
//
//  Created by Anirudh Kumar on 07/12/25.
//

import SwiftUI

struct EditableText: View {
    let onChange: (String) -> Bool
    let onSubmit: (String) -> Void
    let onEdit: (_ isGoingToEdit: Bool) -> Void
    @Binding var text: String
    @State private var isEditing = false
    @State private var isError = false
    @State private var textInput: String = "";
    
    init(onChange: @escaping (String) -> Bool, onSubmit: @escaping (String) -> Void, onEdit: @escaping (_: Bool) -> Void, text: Binding<String>, isEditing: Bool = false, isError: Bool = false) {
        self.onChange = onChange
        self.onSubmit = onSubmit
        self.onEdit = onEdit
        self._text = text
        self.isEditing = isEditing
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
                    .onSubmit {
                        if (!isError) {
                            onSubmit(textInput)
                            isEditing = false
                        }
                    }
                    .onChange(of: text) { newValue in
                        
                        if onChange(newValue) {
                            isError = false
                        }
                        else {
                            isError = true
                        }
                    }
            }
            else {
                Text(text)
                    .frame(width: width)
            }
        }
        .onTapGesture {
            isEditing = !isEditing
            onEdit(isEditing)
        }
    }
}
