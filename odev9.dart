import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(S
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void navigateToSecondPage(BuildContext context) {
    String fullName = '${firstNameController.text} ${lastNameController.text}';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondPage(fullName: fullName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 80.0),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  navigateToSecondPage(context);
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'New User? '),
                      TextSpan(
                        text: 'Create Account',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
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

class SecondPage extends StatelessWidget {
  final String fullName;

  SecondPage({required this.fullName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $fullName'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: makeupProducts.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    makeupProducts[index]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    makeupProducts[index]['name'],
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    addToCart(context, makeupProducts[index]);
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Go to Cart'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void addToCart(BuildContext context, Map<String, dynamic> product) {
    shoppingCart.add(product);
    showSnackBar(context, '${product["name"]} added to cart');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('${product["name"]} added to cart'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class ShoppingCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: shoppingCart.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: Image.asset(shoppingCart[index]['image']),
                title: Text(shoppingCart[index]['name']),
              ),
              Divider(), // Add a divider between items
            ],
          );
        },
      ),
    );
  }
}

List<Map<String, dynamic>> makeupProducts = [
  {
    'name': 'Foundation',
    'image': 'images/f.jpg',
  },
  {
    'name': 'Lipstick',
    'image': 'images/l.jpg',
  },
  {
    'name': 'Mascara',
    'image': 'images/m.jpg',
  },
  {
    'name': 'Eyeshadow Palette',
    'image': 'images/e.jpg',
  },
  {
    'name': 'Blush',
    'image': 'images/b.jpg',
  },
  {
    'name': 'Eyeliner',
    'image': 'images/ey.png',
  },
  // Diğer ürünlerin fotoğraf yollarını ve isimlerini de buraya ekleyebilirsiniz
];

List<Map<String, dynamic>> shoppingCart = [];
