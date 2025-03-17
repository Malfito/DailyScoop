class OtpVerificationRequest {
  String otp;
  String phone; // Using the phone number to identify the user

  OtpVerificationRequest({
    required this.otp,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
      'phone': phone,
    };
  }
}
