import 'package:yupcity_admin/services/application/recover_pass_logic.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RecoverFieldsFormBloc extends FormBloc<bool, String> {


  final textEmail = TextFieldBloc();

  var validatorEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  RecoverFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      textEmail,
    ]);
  }

  void addErrors() {
    textEmail.addFieldError('Introduzca email');
  }

  @override
  void onSubmitting() async {
    try {
      var datsmiRecoverLogic = DatsmiRecoverPassLogic();
      var responseRegister = await datsmiRecoverLogic.recoverPass(textEmail.value);
      emitSuccess(successResponse: responseRegister, canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}