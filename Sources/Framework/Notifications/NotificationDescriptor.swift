import Foundation

struct NotificationDescriptor<T> {

    let name: Notification.Name
    let parser: ([AnyHashable: Any]) -> T?

}
