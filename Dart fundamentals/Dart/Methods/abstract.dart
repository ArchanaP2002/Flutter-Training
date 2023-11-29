
abstract class Text {
  void name(); // defining an abstract method
}

class Sample extends Text {
  @override
  void name() {
    print("Hello");
  }
}

void main() {
  Sample demo = Sample();
  demo.name(); // This will print "Hello"
}
