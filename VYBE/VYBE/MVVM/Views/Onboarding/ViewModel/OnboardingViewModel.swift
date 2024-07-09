//
//  OnboardingViewModel.swift
//  VYBE
//
//  Created by Hamza Hashmi on 10/07/2024.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    @Published var onboardingPath: [OnboardingPath] = []
    
}

extension OnboardingViewModel {
    func push(to step: OnboardingPath) {
        onboardingPath.append(step)
    }
    
    func pop() {
        onboardingPath.removeLast()
    }
}
