import 'package:molib/application/boundaries/create_shelf/CreateShelfOuput.dart';
import 'package:molib/application/boundaries/create_shelf/ICreateShelfUseCase.dart';
import 'package:molib/domain/factories/IEntityFactory.dart';
import 'package:molib/domain/repositories/IBookShelfRepository.dart';

class CreateShelfUseCase implements ICreateShelfUseCase {
  final IBookShelfRepository _shelfRepository;
  final IEntityFactory _entityFactory;

  CreateShelfUseCase(this._shelfRepository, this._entityFactory);

  @override
  Future<CreateShelfOutput> execute() async {
    var bookShelf = _entityFactory.newBookShelf();
    await _shelfRepository.create(bookShelf);
    return CreateShelfOutput(bookShelf.id);
  }
}
