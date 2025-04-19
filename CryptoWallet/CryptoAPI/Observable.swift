protocol ObservableType {
    associatedtype Value
    var value: Value { get set }
    func bind(_ listener: @escaping (Value) -> Void)
}

class Observable<T>: ObservableType {
    typealias Value = T
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
        listener(value)
    }
}
