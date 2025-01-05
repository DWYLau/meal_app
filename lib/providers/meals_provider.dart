import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/dummy_data.dart';

///static data that does not change
///use provider
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
