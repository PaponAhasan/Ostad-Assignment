class Urls {
  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";

  static const String register = "$_baseUrl/Registration";
  static const String login = "$_baseUrl/Login";
  static const String getEmailRecovery = "$_baseUrl/RecoverVerifyEmail";
  static const String getVerifyOtp = "$_baseUrl/RecoverVerifyOtp";
  static const String resetPassword = "$_baseUrl/RecoverResetPassword";

  static const String updateProfile = "$_baseUrl/profileUpdate";

  static const String addTask = "$_baseUrl/createTask";
  static const String taskStatusCount = "$_baseUrl/taskStatusCount";

  static String changeTaskStatus(
          {required String taskId, required String status}) =>
      "$_baseUrl/updateTaskStatus/$taskId/$status";

  static String deleteTask(
      {required String taskId}) =>
      "$_baseUrl/deleteTask/$taskId";

  static const String _taskUrl = "$_baseUrl/listTaskByStatus";
  static const String getNewTask = "$_taskUrl/New";
  static const String getCompletedTask = "$_taskUrl/Completed";
  static const String getCancelledTask = "$_taskUrl/Cancelled";
  static const String getProgressTask = "$_taskUrl/Progress";
}
