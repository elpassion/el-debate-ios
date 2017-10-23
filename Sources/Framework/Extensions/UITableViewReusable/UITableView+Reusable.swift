extension UITableView {

    func registerCell<T: UITableViewCell>(_ cell: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusabelCell<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with type: \(T.self) for reuse identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

}
