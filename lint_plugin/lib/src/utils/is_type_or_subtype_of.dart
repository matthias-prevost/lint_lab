import 'package:analyzer/dart/element/type.dart';

import 'package:source_gen/source_gen.dart';

/// Check if the given [DartType] is of type [T] or a subtype of [T].
bool isTypeOrSubtypeOf<T>(DartType dartType) {
  return TypeChecker.fromRuntime(T).isAssignableFromType(dartType);
}
