import 'dart:ffi';

import 'package:hello_dart/hello_dart.dart' as hello_dart;

void main(List<String> arguments) {
  print('Hello world: ${hello_dart.calculate()}!');
}

const inet = 10;
final sadf = 10.1;
var a = 10;
dynamic myVariable = 10;
const name = "ray";
const introduction = "hellp $name";
const bigSting = '''
hello
world
''';
const rawSting = r'hello\nworld $name.';
// bmyVariable = 'hello';
// var var1;
// var1 = 10;
// var1 = 'hello';

void process(dynamic val) {
  print(val);
}

void process2(int val) {
  process(val);
}

void process3(String val) {
  process(val);
}

class User {
  String id;
  String name;

  User(this.id, this.name);
}

class Mysingleton {
  Mysingleton._();
  static final Mysingleton instance = Mysingleton._();
  factory Mysingleton() => instance;
}

int? myInt = null;
double? myDouble = null;
bool? myBool = null;
final test = myBool ?? false;

class User1 {
  String name;
  User1(this.name) {
    _secreNumber = caulateSecret();
  }

  late final int _secreNumber;

  int caulateSecret() {
    return 1;
  }
}

class Person {
  Person(this.givenName, this.surname);

  String givenName;
  String surname;
  String get fullname => '$givenName $surname';

  @override
  String toString() => fullname;
}

class Student extends Person {
  Student(String givenName, String surname) : super(givenName, surname);

  var grades = <int>[];
}

abstract class DataRepository {
  factory DataRepository() {
    return FakeWebServer();
  }

  double? fechTempreature(String city);
}

class FakeWebServer implements DataRepository {
  @override
  double? fechTempreature(String city) {
    return 42.0;
  }
}

extension on FakeWebServer {
  void log() {
    print('Logged');
  }
}

enum ProgrammingLanguage { dart, swift, javaScript }

extension on ProgrammingLanguage {
  bool get isStronglyTyped {
    switch (this) {
      case ProgrammingLanguage.dart:
        return true;
      case ProgrammingLanguage.swift:
        return true;
      case ProgrammingLanguage.javaScript:
        return false;
    }
  }
}

final myFuture = Future<int>.delayed(Duration(seconds: 1), () => 42)
    .then((value) => print("Value:$value"))
    .catchError((error) => print("Error:$error"))
    .whenComplete(() => print("Done"));

Future<void> concurrencyInDart() async {
  print("before the future");

  final value = await Future<int>.delayed(Duration(seconds: 1), () => 42);
  print("Value: $value");
  print('After the future');
}
