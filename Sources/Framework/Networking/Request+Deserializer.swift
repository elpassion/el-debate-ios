import PromiseKit

internal func request<T>(with executor: @escaping (@escaping (ApiResponse) -> Void) -> Void,
                         deserializedBy deserializer: Deserializer<T>) -> Promise<T> {
    return Promise(requestExecutor: executor) { response in
        try deserializer.deserialize(json: response.json)
    }
}
