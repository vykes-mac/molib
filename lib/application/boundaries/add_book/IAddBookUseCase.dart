import 'package:molib/application/boundaries/IUseCase.dart';
import 'package:molib/application/boundaries/add_book/AddBookInput.dart';
import 'package:molib/application/boundaries/add_book/AddBookOutput.dart';

abstract class IAddBookUseCase extends IUseCase<AddBookInput, AddBookOutput> {}
