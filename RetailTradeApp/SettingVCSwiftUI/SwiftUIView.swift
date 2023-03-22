//
//  SwiftUIView.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 22.03.2023.
//

import SwiftUI

struct SwiftUIView: View {
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack(){
        Rectangle()
            .fill(Gradient(colors: [.indigo, .purple]))
            .ignoresSafeArea()
            VStack(){
                Text("Сохранить или загрузить данные из библиотеки?")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(10)
                    .padding(.top, 100)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
            }

        }
    }

}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
