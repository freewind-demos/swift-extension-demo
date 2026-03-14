// swift-extension-demo.swift

// ============ 扩展添加计算属性 ============
extension Double {
    var km: Double { self * 1000 }
    var m: Double { self }
    var cm: Double { self / 100 }
}

let distance: Double = 5.0
print("5 km = \(distance.km) 米")
print("5 cm = \(distance.cm) 米")

// ============ 扩展添加方法 ============
extension String {
    func repeatCount(_ n: Int) -> String {
        return String(repeating: self, count: n)
    }

    var isPalindrome: Bool {
        let cleaned = self.lowercased().filter { $0.isLetter }
        return String(cleaned.reversed()) == cleaned
    }
}

print("ha 重复3次: \("ha".repeatCount(3))")
print("aba 是回文: \("aba".isPalindrome)")
print("abc 不是回文: \("abc".isPalindrome)")

// ============ 扩展添加构造器 ============
struct Point {
    var x: Double
    var y: Double
}

extension Point {
    init(fromString str: String) {
        let parts = str.split(separator: ",")
        x = Double(parts[0]) ?? 0
        y = Double(parts[1]) ?? 0
    }

    static var zero: Point {
        Point(x: 0, y: 0)
    }
}

let p1 = Point(x: 1, y: 2)
let p2 = Point(fromString: "3,4")
let p3 = Point.zero
print("p1: (\(p1.x), \(p1.y))")
print("p2: (\(p2.x), \(p2.y))")
print("p3: (\(p3.x), \(p3.y))")

// ============ 扩展实现协议 ============
protocol JsonSerializable {
    func toJson() -> String
}

struct User: JsonSerializable {
    var name: String
    var age: Int
}

extension User {
    func toJson() -> String {
        return "{\"name\": \"\(name)\", \"age\": \(age)}"
    }
}

let user = User(name: "Tom", age: 25)
print("JSON: \(user.toJson())")

// ============ 扩展添加下标 ============
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

let arr = [1, 2, 3]
print("arr[0] = \(arr[safe: 0] ?? -1)")
print("arr[10] = \(arr[safe: 10] ?? -1)")
