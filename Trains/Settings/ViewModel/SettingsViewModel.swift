//  SettingsViewModel.swift

import SwiftUI

@Observable final class SettingsViewModel {
    
    let userAgreement: UserAgreementConfig
    
    private let model: UserAgreementModel
    
    init(model: UserAgreementModel) {
        self.model = model
        self.userAgreement = model.userAgreement
    }
}
