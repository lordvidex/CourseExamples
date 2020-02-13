class CustomAuthException implements Exception {
  String error;
  String errorMessage;

  CustomAuthException(this.error);
  final errorMap = {
    'ERROR_WEAK_PASSWORD':'The password is too weak',
    'ERROR_INVALID_EMAIL':'Invalid email address',
    'ERROR_EMAIL_ALREADY_IN_USE':'User with email address already exists',
    'ERROR_WRONG_PASSWORD':'The password provided is incorrect',
    'ERROR_USER_NOT_FOUND':'User does not exist',
  };
  
  void findErrorMessage(){
    errorMap.forEach((key,value){
      if(error.contains(key)){
        errorMessage = value;
      }
    });
  }
  @override
  String toString() {
    findErrorMessage();
    return errorMessage;
  }
}
