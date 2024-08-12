import 'package:ecom/data/models/category_model.dart';
import 'package:ecom/data/repository/product_repository.dart';
import 'package:ecom/logic/cubits/category_product_cubit.dart/category_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;
  CategoryProductCubit(this.category) : super(CategoryProductInitialState()) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize() async {
    try {
      emit(CategoryProductLoadingState(state.products));

      final products =
          await _productRepository.fetchProductByCategory(category.sId!);
      emit(CategoryProductLoadedState(products));
    } catch (e) {
      emit(CategoryProductErrorState(state.products, e.toString()));
    }
  }
}
