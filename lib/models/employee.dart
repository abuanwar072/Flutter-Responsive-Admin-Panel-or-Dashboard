class Employee {
  final int? empId;
  final String? cityEn;
  final String? cityAr;
  final String? stateEn;
  final String? stateAr;
  final String? firstName;
  final String? lastName;
  late String? fullName;
  final String? password;
  final String? phoneNumber;
  final String? email;
  final String? cvFileUrl;
  final String? startDate;
  final String? endDate;
  final bool? isAdmin;
  final String? resumeFileName;

  Employee({
    this.empId,
    this.cityEn,
    this.cityAr,
    this.stateEn,
    this.stateAr,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.password,
    this.email,
    this.cvFileUrl,
    this.startDate,
    this.endDate,
    this.isAdmin,
    this.resumeFileName,
  });

  // FROM JSON METHODS
  Employee.fromJson(Map<String, dynamic> json)
      : empId = json['id'],
        cityEn = json['city_en'],
        cityAr = json['city_ar'],
        stateEn = json['state_en'],
        stateAr = json['state_ar'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        fullName = json['full_name'],
        phoneNumber = json['phone_num'],
        email = json['email'],
        password = null,
        cvFileUrl = json['cv_docu'],
        startDate = json['start_date'],
        endDate = json['end_date'],
        isAdmin = json['admin'],
        resumeFileName = null;
}

// TO JSON METHODS THAT MATCH THE KEYS OF FROM JSON METHOD
Map<String, dynamic> employeeToJson(Employee instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_num': instance.phoneNumber,
      'password': instance.password,
      'email': instance.email,
      'state_en': instance.stateEn,
      'state_ar': instance.stateAr,
      'city_en': instance.cityEn,
      'city_ar': instance.cityAr,
      'cv_docu': instance.cvFileUrl,
      'admin': ((instance.isAdmin!) ? 1 : 0),
    };
