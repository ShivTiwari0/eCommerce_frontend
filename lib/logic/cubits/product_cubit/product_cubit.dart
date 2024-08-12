import 'package:ecom/data/repository/product_repository.dart';
import 'package:ecom/logic/cubits/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState>{
  ProductCubit() : super(ProductInitialState()){
    _initialize();
  }
  
  final _repository = ProductRepository();

  void _initialize() async{

    try {
      emit(ProductLoadingState(state.products));
      final products = await _repository.fetchAllProduct();
      emit(ProductLoadedState(products));
    } catch (e) {
      emit(ProductErrorState(state.products, e.toString()));
    }
  }
}

