///An abstract class to have a structure for our usecase call methods (Callable classes) 
///So that usecase classes can extend it
///Returns a type(T) and receives params (P)

abstract class UseCase<T,P>{
  Future<T> call(P param);
}