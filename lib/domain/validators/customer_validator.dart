import '../../infrastructure/repositories/customer_repository.dart';
import '../models/customer.dart';
import '../services/customer_service.dart';

class CustomerValidator {

  static bool isValidPhoneNumber(String phoneNumber) {
    try {
      if (phoneNumber.isEmpty || phoneNumber.length < 11 || phoneNumber.substring(0,2)!="09") {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidEmail(String email) {
    try {
      if (email.isEmpty || !email.contains('@')) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidBankAccountNumber(String accountNumber) {
    if (accountNumber.isEmpty || accountNumber.length < 16 || accountNumber.substring(0,4)!="6037") {
      return false;
    }
    return true;
  }

  static Future<bool> isUniqueEmail(String email) async {
    final customerService = CustomerService(CustomerDatabaseRepository());

    final emailExists = await customerService.doesEmailExist(email);
    return !emailExists;
  }

  static Future<bool> isUniqueCustomer(Customer customer) async{
    final customerService = CustomerService(CustomerDatabaseRepository());

    final customerExists = await customerService.doesCustomerExist(customer);
    return !customerExists;
  }

}