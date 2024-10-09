//
//  AvatarPicker.swift
//  Spy
//
//  Created by Вячеслав on 11/26/23.
//

import SwiftUI

struct AvatarPicker: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                Text(viewModel.currentStep.text)
                    .foregroundColor(.white)
                    .font(.system(size: 19, weight: .bold))
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        viewModel.currentStep = viewModel.toPickerFromScreen
                        
                    }, label: {
                        
                        Image("xmark")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                            .foregroundColor(.second)
                    })
                }
                .padding(.horizontal)
            }
            
            let avatarNames: [String] = (1...29).map { "avatar_\($0)" }
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], content: {

                    ForEach(avatarNames, id: \.self) { avatar in
                        
                        Button(action: {
                            
                            guard let selectedPlayer = viewModel.selectedPlayerForPicker else { return }
                            
                            if viewModel.toPickerFromScreen == .names {
                                
                                viewModel.playerNames = viewModel.updatePlayerPhoto(in: viewModel.playerNames, for: selectedPlayer, with: avatar)
                                
                            } else if viewModel.toPickerFromScreen == .nameFavorites {
                                
                                viewModel.dataManager.saved_users = viewModel.updatePlayerPhoto(in: viewModel.dataManager.saved_users, for: selectedPlayer, with: avatar)
                            }
                            
                            viewModel.currentStep = viewModel.toPickerFromScreen
                            viewModel.selectedPlayerForPicker = nil
                            
                        }, label: {
                            
                            Image(avatar)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 83, height: 83)
                        })
                        .buttonStyle(ScaledButton(scaling: 0.9))
                    }
                })
                .padding(.bottom)
            }
            .frame(height: UIScreen.main.bounds.height / 2)
        }
    }
}

#Preview {
    ZStack {
        Color.bgPrime.ignoresSafeArea()
        AvatarPicker(viewModel: MainViewModel())
    }
}
