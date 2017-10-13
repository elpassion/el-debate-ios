protocol URLProviding {
    var url: String { get }
}

class URLProvider: URLProviding {

    var url: String = "https://el-debate.herokuapp.com"

}
