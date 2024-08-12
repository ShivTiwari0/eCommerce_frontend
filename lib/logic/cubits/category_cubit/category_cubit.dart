import 'package:ecom/data/models/category_model.dart';
import 'package:ecom/data/repository/category_repository.dart';

import 'package:ecom/logic/cubits/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState>{
  CategoryCubit() : super(CategoryInitialState()){_initialize();}


 final _categoryRepository = CategoryRepository();

  void _initialize()async{
    emit(CategoryLoadingState(state.categories));
    try {
     List<CategoryModel> categories =  await _categoryRepository.fetchAllCategory();
      emit(CategoryLodedState(categories));
    } catch (e) {
      emit(CategoryErrorState(state.categories,e.toString()));
    }
  }
}