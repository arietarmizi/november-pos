import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

class ProductPasswordScreen extends StatefulWidget {
  const ProductPasswordScreen({super.key});

  @override
  State<ProductPasswordScreen> createState() => _ProductPasswordScreenState();
}

class _ProductPasswordScreenState extends State<ProductPasswordScreen> {
  final _controller = TextEditingController();
  String? _error;

  void _checkPassword() {
    final savedPassword = dotenv.env['PRODUCTS_PASSWORD'];
    if (_controller.text == savedPassword) {
      context.go('/products', extra: true);
    } else {
      setState(() {
        _error = "Password salah!";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Password"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                errorText: _error,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkPassword,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
