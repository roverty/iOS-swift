func intercambiaInt(a: inout Int,b: inout Int){
    let temp = a
    a = b 
    b = temp
}

func intercambiaString(a: inout String,b: inout String){
    let temp = a 
    a = b 
    b = temp
}

// De manera generica
func intercambiaGenerico<T>(a: inout T, b: inout T){ 
    let temp = a 
    a = b
    b = temp    
}

var x: Int = 10 
var y: Int = 50 
print("Antes: \(x), \(y)")
intercambiaGenerico(a: &x, b:&y)
print("Despues: \(x), \(y)")

var nombre1: String = "Galig" 
var nombre2: String = "Emanuel"
print("Antes: \(nombre1), \(nombre2)")
intercambiaGenerico(a: &nombre1, b:&nombre2)
print("Despues: \(nombre1), \(nombre2)")

// func imprimeGenerico<T,E> (a: T, b:E) -> Bool {
//     print(a == b)
//     return a == b
// }

func imprimeGenerico<T, E>(a: T, b: E) -> Bool{
  print(a == b)
  return a == b
}

class Lista<T>{
    var items = [T]() 
    func add(item: T){
        items.append(item)
    }
}

var stringLista = Lista<String>()
var intLista = Lista<Int>()
// var listaPersonalizada = Lista<MyObjetoPersonalizado>()