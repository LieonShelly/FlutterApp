# FlutterApp
flutter学习之路
# Dart语法
# Dart 类的初始化方法总结

Dart 中支持多种类的构造方式，用于灵活地初始化对象。以下是完整的构造函数类型总结。

---

## ✅ 1. 默认构造函数（无名构造函数）

```dart
class Person {
  String name;
  int age;

  Person(this.name, this.age);
}
```
## ✅ 2. 命名构造函数

``` dart
class Person {
  String name;
  int age;

  Person.guest() {
    name = "Guest";
    age = 0;
  }

  Person.withName(this.name) : age = 18;
}

```
✅ 3. 重定向构造函数

```dart
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  Person.guest() : this("Guest", 0);
}
```
## ✅ 4. 工厂构造函数（factory）
```dart
class Logger {
  static final Logger _instance = Logger._internal();

  factory Logger() {
    return _instance;
  }

  Logger._internal();
}

```
## ✅ 5. 常量构造函数（const）
```dart
class Point {
  final int x, y;

  const Point(this.x, this.y);
}

const Point point0 = Point(0, 0);

```

## ✅ 6. 具名参数构造函数（带标签）

```dart
class User {
  String name;
  int age;

  User({required this.name, this.age = 0});
}

User user0 = User(name: "name", age: 10);
```

## ✅ 7. 初始化列表
```dart
class Point {
  final int x;
  final int y;

  Point(int a, int b) : x = a, y = b;
}

```

## ✅ 8. 构造函数断言（assert）
```dart
class Person {
  final String name;

  Person(this.name) : assert(name.isNotEmpty);
}

```
## ✅ 9. 调用父类构造函数（super）
```dart
class Animal {
  String name;
  Animal(this.name);
}

class Dog extends Animal {
  Dog(String name) : super(name);
}

```

### Dart 中 new / final / const 构造函数对比

| 关键字      | 含义 | 是否运行时创建对象 | 是否编译时创建对象 | 是否可变 | 是否复用同一对象 | 常见场景 |
|-------------|------|--------------------|--------------------|----------|------------------|----------|
| `new` (默认) | 普通构造函数 | ✅ 是 | ❌ 否 | ✅ 可变（取决于类） | ❌ 否 | 一般对象创建 |
| `final`     | 只能赋值一次的变量 | ✅ 是 | ❌ 否 | ⚠️ 引用不可变，但对象本身可变 | ❌ 否 | 运行时常量引用 |
| `const` (对象) | 编译时常量对象 | ❌ 否 | ✅ 是 | ❌ 不可变（字段必须是 `final`） | ✅ 相同参数对象自动复用 | Flutter 常量 Widget、不可变值对象 |
| `const` (构造函数) | 定义可用于创建编译时常量的构造函数 | ❌ 否 | ✅ 是（当用 `const` 创建时） | ❌ 不可变 | ✅ 相同参数对象自动复用 | 用于定义不可变类，例如 `const Point(1,2)` |

---

## 示例

```dart
class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);
}

void main() {
  var p1 = Point(1, 2);       // 普通对象，运行时创建
  final p2 = Point(1, 2);     // 运行时常量引用，但不是编译时常量对象
  const p3 = Point(1, 2);     // 编译时常量对象
  const p4 = Point(1, 2);     // 与 p3 复用同一个对象

  print(identical(p1, p2)); // false
  print(identical(p2, p3)); // false
  print(identical(p3, p4)); // true
}
