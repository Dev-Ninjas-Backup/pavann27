class LoginModel {
  final String phoneNumber;
  final String countryCode;

  LoginModel({
    required this.phoneNumber,
    this.countryCode = "+91",
  });

  Map<String, dynamic> toJson() {
    return {
      "phone": "$countryCode$phoneNumber",
      "loginType": "anonymous",
    };
  }
}