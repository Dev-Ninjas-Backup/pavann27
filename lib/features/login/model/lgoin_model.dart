class LoginModel {
  final String phoneNumber;
  final String countryCode;
  final String countryFlag;

  LoginModel({
    required this.phoneNumber,
    this.countryCode = "+91",
    this.countryFlag = "🇮🇳",
  });

  Map<String, dynamic> toJson() {
    return {
      "phone": "$countryCode$phoneNumber",
      "countryCode": countryCode,
      "loginType": "anonymous",
    };
  }
}