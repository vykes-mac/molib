import 'GetAllBooksOutput.dart';

abstract class IGetAllBooksUseCase {
  Future<GetAllBooksOutput> execute();
}
