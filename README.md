# Cubit Cart Example
A simple cubit cart system realization. Used simple navigator and **flutter_bloc**'s **BlocProvider**

![image](https://github.com/user-attachments/assets/6bc27ac4-501d-4c17-80de-fe4821c0bb81)


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
