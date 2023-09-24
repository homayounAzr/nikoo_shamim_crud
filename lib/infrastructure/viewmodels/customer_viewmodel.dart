
import '../../domain/models/customer.dart';
import '../../domain/services/customer_service.dart';

class CustomerViewModel {

  final CustomerService _customerService;

  CustomerViewModel(this._customerService);

  Future<void> createCustomer(Customer customer) async {
    return _customerService.createCustomer(customer);
  }

  Future<void> updateCustomer(Customer customer) async {
    return _customerService.updateCustomer(customer);
  }

  Future<void> deleteCustomer(Customer customer) async {
    return _customerService.deleteCustomer(customer);
  }

  Future<Customer> getCustomer(int id) async {
    return _customerService.getCustomer(id);
  }

  Future<bool> doesEmailExist(String email) async {
    return _customerService.doesEmailExist(email);
  }

  Future<List<Customer>> getAllCustomers() async {
    return _customerService.getAllCustomers();
  }

}