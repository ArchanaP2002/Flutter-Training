
// Inside the even() we passed the parameter n so its function with parameter 
// Using void Keyword so its no return type
void even(int n){
  if (n% 2 ==0) {
    print("The given $n is Even");
  }else{
    print("The Given $n is Odd");
  }

}
void main(){
  even(4);
}