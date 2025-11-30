//  ErrorViewModel.swift

import Observation

@Observable final class ErrorViewModel {
    var actualStatus: ErrorType = .NoProblems
    var imageName: String? {
        get {
                    switch actualStatus {
                    case .NoProblems:
                       return nil
                    case .ServerError:
                       return "ServerError"
                    case .NoInternetConnection:
                        return  "NoInternetError"
                    }
        }
        
    }
    var text: String? {
        get { actualStatus != .NoProblems ? actualStatus.rawValue : nil
        }
    }

    func set(error: ErrorType) {
        self.actualStatus = error
    }
}
