class Sample {
  //Instance Method
  // Syntax: return_type method_name(){}

  void numbers(int n1, int n2) {
    int n = n1 + n2;
    print("Sum Of $n1 & $n2 is $n");
  }
}

void main() {
  Sample sum = Sample();
  sum.numbers(5, 10);
}
