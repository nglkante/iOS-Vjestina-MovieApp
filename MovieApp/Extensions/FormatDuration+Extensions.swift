extension Int {
    
    func formatDuration() -> String {
        let hours = self / 60
        let remainingMinutes = self % 60
        
        var durationString = ""
        if hours > 0 {
            durationString += "\(hours)h"
        }
        if remainingMinutes > 0 {
            if !durationString.isEmpty {
                durationString += " "
            }
            durationString += "\(remainingMinutes)m"
        }
        return durationString
    }
}
