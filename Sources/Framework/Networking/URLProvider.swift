protocol URLProviding {
    var url: String { get }
}

class URLProvider: URLProviding {

    let url: String = "https://el-debate.herokuapp.com"

}
