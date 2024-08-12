import 'package:ecom/data/models/category_model.dart';

abstract class CategoryState{
  final List<CategoryModel> categories ;

  CategoryState(this.categories);
}

class CategoryInitialState extends CategoryState{
  CategoryInitialState():super([]);
}
class CategoryLoadingState extends CategoryState{
  CategoryLoadingState(super.categories);
}

class CategoryLodedState extends CategoryState{
  CategoryLodedState(super.categories);
}

class CategoryErrorState extends CategoryState{
  final String message;
  CategoryErrorState(super.categories, this.message);
}

