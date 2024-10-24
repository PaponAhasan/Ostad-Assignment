class Urls{
  static const String _baseUrl = "http://152.42.163.176:2006/api/v1";

  static const String register = "$_baseUrl/Registration";
  static const String login = "$_baseUrl/Login";
  static const String getEmailRecovery = "$_baseUrl/RecoverVerifyEmail";
  static const String getVerifyOtp = "$_baseUrl/RecoverVerifyOtp";
  static const String resetPassword = "$_baseUrl/RecoverResetPassword";
  static const String addTask = "$_baseUrl/createTask";
}