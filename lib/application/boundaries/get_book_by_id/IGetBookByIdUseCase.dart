import 'package:molib/application/boundaries/IUseCase.dart';

import 'GetBookByIdInput.dart';
import 'GetBookByIdOuput.dart';

abstract class IGetBookByIdUseCase
    extends IUseCase<GetBookByIdInput, GetBookByIdOutput> {}
