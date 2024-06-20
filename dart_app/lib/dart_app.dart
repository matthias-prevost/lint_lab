import 'package:fast_immutable_collections/fast_immutable_collections.dart';

int calculate() {
  final variable = IList([1]);

  final list2 = IList([1, 0, "&"]);
  var list3 = ["a", "b", "c"];

  print(list2);
  print(list3);


  return variable.firstWhere((a) => a == 1);
}