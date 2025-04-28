import Foundation
import SwiftUI

class SaveStudyViewModel: ObservableObject {
    @Published var studyState: StudyState = .notStarted
    @Published var goalText: String = ""
    @Published var impressionText: String = ""
    @Published var timerCount: Int = 10
    @Published var isTimerRunning: Bool = false
    
    var timer: Timer?
    
    enum StudyState {
        case notStarted
        case inProgress
        case finishing
        case finished
    }
    
    func startStudy() {
        studyState = .inProgress
        startTimer()
    }
    
    func finishStudy() {
        studyState = .finishing
    }
    
    func resetStudy() {
        studyState = .notStarted
        goalText = ""
        impressionText = ""
        stopTimer()
        timerCount = 10
    }
    
    private func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.timerCount > 0 {
                self.timerCount -= 1
            } else {
                self.stopTimer()
                self.studyState = .finishing
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
    
    func saveGoal(_ goal: String) {
        goalText = goal
    }
    
    func saveImpression(_ impression: String) {
        impressionText = impression
    }
}
