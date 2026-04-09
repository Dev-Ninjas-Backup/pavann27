class OtpModel {
  final String phoneNumber;
  final String otp;
  final String verificationId; // If using Firebase

  OtpModel({
    required this.phoneNumber,
    required this.otp,
    this.verificationId = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "phoneNumber": phoneNumber,
      "otp": otp,
    };
  }
}