import '../models/customer.dart';
import '../repositories/customer_repository.dart';
import '../validators/customer_validator.dart';

class CustomerService {

  final CustomerRepository _customerRepository;

  CustomerService(this._customerRepository);

  Future<void> createCustomer(Customer customer) async {
    if(_isValidCustomer(customer)) {
      await _customerRepository.createCustomer(customer);
    } else {
      throw Exception('Invalid customer');
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    // Input validation
    if(_isValidCustomer(customer)) {
      await _customerRepository.updateCustomer(customer);
    } else {
      throw Exception('Invalid customer');
    }
  }

  Future<void> deleteCustomer(Customer customer) async {
    await _customerRepository.deleteCustomer(customer);
  }

  Future<Customer> getCustomer(int id) async {
    return await _customerRepository.getCustomer(id);
  }

  Future<List<Customer>> getAllCustomers() async {
    return await _customerRepository.getAllCustomers();
  }

  bool _isValidCustomer(Customer customer) {
    //todo implement validations
    if (!CustomerValidator.isValidPhoneNumber(customer.phoneNumber)) {
      return false;
    }

    if (!CustomerValidator.isValidEmail(customer.email)) {
      return false;
    }

    if (!CustomerValidator.isValidBankAccountNumber(customer.bankAccountNumber)) {
      return false;
    }

    if (!CustomerValidator.isUniqueEmail(customer.email)) {
      return false;
    }

    if (!CustomerValidator.isUniqueCustomer(customer)) {
      return false;
    }

    return true;

  }

}