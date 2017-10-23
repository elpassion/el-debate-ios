extension Int {
    func asTimeString() -> String {
        let unixTime = Double(self)
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
