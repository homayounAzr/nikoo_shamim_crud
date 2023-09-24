// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../repositories/customer_repository.dart';
import '../services/customer_service.dart';
import '../viewmodels/customer_viewmodel.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: const Text('Create Customer'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateCustomerPage()));
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
  final Customer? customer;
  final VoidCallback? onUpdate;

  const CreateCustomerPage({super.key, this.customer, this.onUpdate});

  @override
  State<CreateCustomerPage> createState() => _CreateCustomerPageState();
}
class _CreateCustomerPageState extends State<CreateCustomerPage> {

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _accountController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  final _viewModel = CustomerViewModel(CustomerService(CustomerDatabaseRepository()));
  final _dateFormat = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController(text: widget.customer?.firstName);
    _lastNameController = TextEditingController(text: widget.customer?.lastName);
    _phoneController = TextEditingController(text: widget.customer?.phoneNumber);
    _emailController = TextEditingController(text: widget.customer?.email);
    _accountController = TextEditingController(text: widget.customer?.bankAccountNumber);
    _dateOfBirthController = TextEditingController(
        text: widget.customer?.dateOfBirth != null?
        _dateFormat.format(widget.customer!.dateOfBirth): null
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Customer'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(hintText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(hintText: 'Last Name'),
              ),
              DateTimeField(
                format: _dateFormat,
                controller: _dateOfBirthController,
                decoration: const InputDecoration(hintText: 'Date Of Birth'),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                    context: context,
                    firstDate: DateTime(2010),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                },
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
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  child: const Text('Create Customer'),
                  onPressed: () async {
                    final customer = Customer(
                      id: widget.customer?.id ?? -1,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      bankAccountNumber: _accountController.text,
                      email: _emailController.text,
                      phoneNumber: _phoneController.text,
                      dateOfBirth: DateTime.parse(_dateOfBirthController.text),
                    );
                    try{
                      if(widget.customer != null){
                        await _viewModel.updateCustomer(customer);
                        widget.onUpdate!();
                        Navigator.of(context).pop();
                      }else {
                        await _viewModel.createCustomer(customer);
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomersPage()));
                      }
                    }catch(e) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('Invalid Parameter'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK')
                                )
                              ],
                            );
                          }
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ],
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
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('${customer.firstName} ${customer.lastName}'),
            subtitle: Text(customer.email),
            leading: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (){
                setState(() {
                  _viewModel.deleteCustomer(customer);
                });
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCustomerPage(
                  customer: customer,
                  onUpdate: (){
                  setState(() {});
                },)));
              },
            ),
          );

        }
    );
  }

}