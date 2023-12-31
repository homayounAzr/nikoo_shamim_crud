class Customer {
  int id;
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String phoneNumber;
  String email;
  String bankAccountNumber;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.bankAccountNumber,
  });

  Map<String, dynamic> toMap() {
    final birthDate = DateTime(
      dateOfBirth.year,
      dateOfBirth.month,
      dateOfBirth.day,
    );

    return {
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': birthDate.toIso8601String(),
      'phone_number': phoneNumber,
      'email': email,
      'bank_account_number': bankAccountNumber
    };
  }

  static Customer fromMap(Map<String, dynamic> map) {
    return Customer(
        id: map['_id'],
        firstName: map['first_name'],
        lastName: map['last_name'],
        dateOfBirth: DateTime.parse(map['date_of_birth']),
        phoneNumber: map['phone_number'],
        email: map['email'],
        bankAccountNumber: map['bank_account_number']);
  }
}
