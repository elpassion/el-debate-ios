extension Int {
    public func asTimeString() -> String {
        return asTimeStringWithZone(zone: TimeZone.current)
    }

    public func asTimeStringWithZone(zone: TimeZone) -> String {
        let unixTime = Double(self) / 1_000
        let date = Date(timeIntervalSince1970: unixTime)

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = zone
        dateFormatter.dateFormat = "HH:mm"

        return dateFormatter.string(from: date)
    }
}
