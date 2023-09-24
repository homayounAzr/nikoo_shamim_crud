import '../../infrastructure/repositories/customer_repository.dart';
import '../models/customer.dart';
import '../validators/customer_validator.dart';

class CustomerService {

  final CustomerRepository _customerRepository;

  CustomerService(this._customerRepository);

  Future<void> createCustomer(Customer customer) async {
    if(await createCustomerValidation(customer)) {
      await _customerRepository.createCustomer(customer);
    } else {
      throw Exception('Invalid Parameter');
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    if(await updateCustomerValidation(customer)) {
      await _customerRepository.updateCustomer(customer);
    } else {
      throw Exception('Invalid Parameter');
    }
  }

  Future<void> deleteCustomer(Customer customer) async {
    await _customerRepository.deleteCustomer(customer);
  }

  Future<Customer> getCustomer(int id) async {
    return await _customerRepository.getCustomer(id);
  }

  Future<bool> doesEmailExist(String email) async {
    return await _customerRepository.doesEmailExist(email);
  }

  Future<bool> doesCustomerExist(Customer customer) async {
    return await _customerRepository.doesCustomerExist(customer);
  }

  Future<List<Customer>> getAllCustomers() async {
    return await _customerRepository.getAllCustomers();
  }

  Future<bool> createCustomerValidation(Customer customer) async{
    if (!CustomerValidator.isValidPhoneNumber(customer.phoneNumber)) {
      return false;
    }

    if (!CustomerValidator.isValidEmail(customer.email)) {
      return false;
    }

    if (!CustomerValidator.isValidBankAccountNumber(customer.bankAccountNumber)) {
      return false;
    }

    if (!await CustomerValidator.isUniqueEmail(customer.email)) {
      return false;
    }

    if (!await CustomerValidator.isUniqueCustomer(customer)) {
      return false;
    }

    return true;

  }

  Future<bool> updateCustomerValidation(Customer customer) async{
    final Customer c = await _customerRepository.getCustomer(customer.id);

    if (!CustomerValidator.isValidPhoneNumber(customer.phoneNumber)) {
      return false;
    }

    if (!CustomerValidator.isValidEmail(customer.email)) {
      return false;
    }

    if (!CustomerValidator.isValidBankAccountNumber(customer.bankAccountNumber)) {
      return false;
    }

    if (!await CustomerValidator.isUniqueEmail(customer.email) && c.email != customer.email) {
      return false;
    }

    if (!await CustomerValidator.isUniqueCustomer(customer) && (c.firstName != customer.firstName || c.lastName != customer.lastName || c.dateOfBirth != customer.dateOfBirth)) {
      return false;
    }

    return true;

  }

}