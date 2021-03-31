class Lista<T>{
    var items = [T]() 
    func add(item: T){
        items.append(item)
    }

    func suma() -> T where T: Numeric {
        items.reduce(0){ $0 + $1}
        //items.reduce(0,+)
    }
}

var numeritos = Lista<Int>()
numeritos.add(item:19)
numeritos.add(item:7)
numeritos.add(item:5)
print(numeritos.suma())