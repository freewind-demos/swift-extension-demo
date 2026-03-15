# Swift 扩展 Demo

## 简介

本 demo 展示 Swift 扩展（Extension）的强大功能。扩展允许我们**为现有类型添加新功能**，而不需要继承或修改原始类型。

## 基本原理

### 什么是扩展？

扩展就像给类型"打补丁"，可以在不修改原始代码的情况下添加新功能：

```swift
extension Double {
    var km: Double { self * 1000 }
    var m: Double { self }
    var cm: Double { self / 100 }
}

let distance: Double = 5.0
print("5 km = \(distance.km) 米")  // 输出: 5000.0
```

### 扩展 vs 继承

| 特性 | 扩展 | 继承 |
|------|------|------|
| 修改原始类型 | 不需要 | 需要创建子类 |
| 添加存储属性 | 不可以 | 可以 |
| 重写方法 | 不可以 | 可以 |
| 运行时类型 | 不改变 | 改变 |

---

## 启动和使用

### 环境要求

- Swift 5.0+
- macOS 或 Linux

### 安装和运行

```bash
cd swift-extension-demo
swift run
---

## 教程

### 扩展添加计算属性

```swift
extension Double {
    var km: Double { self * 1000 }
    var m: Double { self }
    var cm: Double { self / 100 }
}

let distance: Double = 5.0
print("5 km = \(distance.km) 米")  // 5000.0
print("5 cm = \(distance.cm) 米")  // 0.05
```

### 扩展添加方法

```swift
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
print("aba 是回文: \("aba".isPalindrome)")  // true
print("abc 不是回文: \("abc".isPalindrome)")  // false
```

### 扩展添加构造器

```swift
struct Point {
    var x: Double
    var y: Double
}

extension Point {
    // 添加便利构造器
    init(fromString str: String) {
        let parts = str.split(separator: ",")
        x = Double(parts[0]) ?? 0
        y = Double(parts[1]) ?? 0
    }

    // 添加静态属性
    static var zero: Point {
        Point(x: 0, y: 0)
    }
}

let p1 = Point(x: 1, y: 2)
let p2 = Point(fromString: "3,4")
let p3 = Point.zero
```

### 扩展实现协议

```swift
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
```

### 扩展添加下标

```swift
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

let arr = [1, 2, 3]
print("arr[0] = \(arr[safe: 0] ?? -1)")  // 1
print("arr[10] = \(arr[safe: 10] ?? -1)") // -1（安全访问）
```

---

## 扩展的限制

### 不能添加存储属性

```swift
extension String {
    var storage: String = "test"  // 错误！
}
```

扩展只能添加计算属性，不能添加存储属性。

### 不能重写现有方法

```swift
extension String {
    func count() -> Int {  // 错误！String 已有 count 属性
        return 0
    }
}
```

### 可以为泛型类型添加扩展

```swift
extension Array where Element: Numeric {
    var sum: Element {
        return self.reduce(0, +)
    }
}

let numbers = [1, 2, 3, 4, 5]
print("总和: \(numbers.sum)")
```

---

## 关键代码详解

### 扩展的实现原理

扩展实际上是在编译时把代码"注入"到原始类型中：

```swift
extension Double {
    var km: Double { self * 1000 }
}
```

编译器会生成类似这样的代码：
```swift
// 在 Double 类型中添加计算属性
extension Double {
    var km: Double {
        get { self * 1000 }
    }
}
```

### 扩展的查找顺序

当使用扩展添加的属性/方法时：
1. 首先查找原始类型中定义的
2. 然后查找扩展中定义的

---

## 总结

扩展是 Swift 非常强大的特性：

1. **不修改原始类型** — 扩展可以在不修改源码的情况下添加功能
2. **协议实现** — 可以用扩展为现有类型添加协议实现
3. **代码组织** — 用扩展把代码按功能分组

使用场景：
- 为第三方库添加功能
- 为系统类型添加自定义方法
- 协议默认实现
- 代码组织（按功能分组）
