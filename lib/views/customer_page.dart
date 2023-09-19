import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../repositories/customer_repository.dart';
import '../services/customer_service.dart';
import '../viewmodels/customer_viewmodel.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}
class _CustomerPageState extends State<CustomerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: const Text('Create Customer'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateCustomerPage(),settings: const RouteSettings(name: 'editHome'),));
                }
            ),
            ElevatedButton(
                child: const Text('Get All Customers'),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomersPage()));
                }
            )
          ],
        ),
      ),
    );
  }

}

class CreateCustomerPage extends StatefulWidget {
  const CreateCustomerPage({super.key});

  @override
  State<CreateCustomerPage> createState() => _CreateCustomerPageState();
}
class _CreateCustomerPageState extends State<CreateCustomerPage> {

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _accountController = TextEditingController();

  final _viewModel = CustomerViewModel(CustomerService(CustomerDatabaseRepository()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(hintText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(hintText: 'Last Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(hintText: 'Phone Number'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: _accountController,
              decoration: const InputDecoration(hintText: 'Bank Account Number'),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              child: const Text('Create Customer'),
              onPressed: () async {
                final customer = Customer(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  bankAccountNumber: _accountController.text,
                  email: _emailController.text,
                  phoneNumber: _phoneController.text,
                  ///.. populate this two fields
                  dateOfBirth: DateTime.now(),
                  // id: 1,
                );

                await _viewModel.createCustomer(customer);

                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

}

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}
class _CustomersPageState extends State<CustomersPage> {

  final CustomerViewModel _viewModel = CustomerViewModel(CustomerService(CustomerDatabaseRepository()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Customers'),
      ),
      body: FutureBuilder(
        future: _viewModel.getAllCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final customers = snapshot.data as List<Customer>;
            return _buildCustomerList(customers);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildCustomerList(List<Customer> customers) {
    return ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];

          return ListTile(
            title: Text('${customer.firstName} ${customer.lastName}'),
            subtitle: Text(customer.email),
          );

        }
    );
  }

}