class Customer {
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String phoneNumber;
  String email;
  String bankAccountNumber;

  Customer({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.bankAccountNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'phone_number': phoneNumber,
      'email': email,
      'bank_account_number': bankAccountNumber
    };
  }

  static Customer fromMap(Map<String, dynamic> map) {
    return Customer(
        firstName: map['first_name'],
        lastName: map['last_name'],
        dateOfBirth: DateTime.parse(map['date_of_birth']),
        phoneNumber: map['phone_number'],
        email: map['email'],
        bankAccountNumber: map['bank_account_number']
    );
  }
}