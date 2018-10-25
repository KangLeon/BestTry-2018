//: Playground - noun: a place where people can play

import Cocoa
import Foundation

class Shape {
    var  numberOfSides = 0
    
    init(_ numberOfSides:Int) {
        self.numberOfSides=numberOfSides
    }
    
    func simpleDescription () {
        print("A shape with \(numberOfSides) sides")
    }
    
}

var  shape :Shape? = Shape(3)

shape=nil

shape?.numberOfSides=3//可选链式调用

shape?.simpleDescription()//可选链式调用

class NamesShape: Shape {
    let  name:String
    
    init(name: String,numberOfSides: Int) {
        self.name=name
        super.init(numberOfSides)
    }

    //重写实现
//    override func simpleDescription() {
//        print("\(name) has \(numberOfSides) sides")
//    }
}

let nameShape = NamesShape(name: "Test", numberOfSides: 7)

nameShape.simpleDescription()





