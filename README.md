# Cubit Cart Example
A simple cubit cart system realization. Used simple navigator and **flutter_bloc**'s **BlocProvider**


Be aware of this thing, when you provide some DI to route in your projects, or just use something like **go_router**:
```dart
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
```