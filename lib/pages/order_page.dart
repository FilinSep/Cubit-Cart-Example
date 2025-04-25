import 'package:cartexample/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Why there is no back button in go_router stateful shell route :(
      appBar: AppBar(title: Text('Your cart'), centerTitle: true),
      body: BlocBuilder<CartCubit, CartState>(
        bloc: context.read<CartCubit>(),
        builder: (context, state) {
          var pizzas = state.pizzas as Map;
          var cart = state.cart;

          double summary = 0;
          for (var pizza in cart) {
            summary += pizzas[pizza];
          }

          return Center(
            child:
                cart.isEmpty
                    ? Text(
                      'Cart is empty',
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    )
                    : Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                String currentPizza = cart[index];
                                double price = pizzas[currentPizza];

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    spacing: 10,
                                    children: [
                                      SizedBox(
                                        width: 90,
                                        child: Text(
                                          currentPizza,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '\$${price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap:
                                            () => context
                                                .read<CartCubit>()
                                                .removeFromCart(currentPizza),
                                        child: Text(
                                          'Remove',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: cart.length,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                            child: Text(
                              'Buy for \$${summary.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
          );
        },
      ),
    );
  }
}
