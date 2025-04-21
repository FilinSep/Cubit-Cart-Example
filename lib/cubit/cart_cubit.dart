import 'package:flutter_bloc/flutter_bloc.dart';

class CartState {
  final Map<String, double>? pizzas;
  final List<String> cart;

  CartState(this.pizzas, this.cart);
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(null, []));

  Future<void> getPizzas() async {
    // Fake API request waiting
    await Future.delayed(Duration(seconds: 2));

    emit(
      CartState({
        // name : price
        'Peperoni': 10.00,
        'Margherita': 10.00,
        'Neapolitan': 15.99,
        'Greek': 12.99,
        'Chicago': 12.99,
        'Calzone': 12.99,
        'Detroit': 12.99,
      }, []),
    );
  }

  void addToCart(pizza) {
    emit(CartState(state.pizzas, state.cart..add(pizza)));
  }

  void removeFromCart(pizza) {
    emit(CartState(state.pizzas, state.cart..remove(pizza)));
  }
}
