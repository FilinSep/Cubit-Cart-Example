import 'package:cartexample/cubit/cart_cubit.dart';
import 'package:cartexample/pages/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      bloc: context.watch<CartCubit>(),
      builder: (context, state) {
        var pizzas = state.pizzas;
        var cart = state.cart;
        if (state.pizzas == null) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      // lol
                      (_) => BlocProvider<CartCubit>.value(
                        value: context.watch<CartCubit>(),
                        child: OrderPage(),
                      ),
                ),
              );
            },
            child: Icon(Icons.shopping_cart),
          ),
          appBar: AppBar(title: Text('Pizza'), centerTitle: true),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  cart.isEmpty
                      ? 'Your cart is empty'
                      : 'Cart items count: ${cart.length}',
                  style: TextStyle(fontSize: 18),
                ),
                Divider(),
                Expanded(
                  child: GridView.builder(
                    itemCount: pizzas!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder:
                        (context, index) => buildPizzaCard(
                          context,
                          context.watch<CartCubit>(),
                          index,
                          pizzas,
                          cart,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPizzaCard(context, cartCubit, index, Map pizzas, List cart) {
    String currentPizza = pizzas.keys.toList()[index];
    double price = pizzas[currentPizza];

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (cart.contains(currentPizza)) {
          // Remove
          cartCubit.removeFromCart(currentPizza);
          return;
        }

        // Add
        cartCubit.addToCart(currentPizza);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                currentPizza,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              Expanded(child: Icon(Icons.local_pizza, size: 80)),
              Divider(endIndent: 10, indent: 10),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child:
                    !cart.contains(currentPizza)
                        ? // Add to cart
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                        : // Remove from cart
                        Text(
                          'Remove',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
