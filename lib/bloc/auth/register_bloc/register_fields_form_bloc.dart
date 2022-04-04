import 'package:yupcity_admin/services/application/login_logic.dart';
import 'package:yupcity_admin/services/application/register_logic.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:yupcity_admin/services/application/login_logic.dart';
import 'package:yupcity_admin/services/application/register_logic.dart';

class RegisterFieldsFormBloc extends FormBloc<String, String> {


  final textName = TextFieldBloc();
  final textEmail = TextFieldBloc();
  final textTelephone = TextFieldBloc();
  final textPassword = TextFieldBloc();

  final textPassword2 = TextFieldBloc();


  RegisterFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      textName,
      textEmail,
      textTelephone,
      textPassword,
      textPassword2,

    ]);
  }

  void addErrors() {
    textName.addFieldError('Introduzca el nombre');
    textEmail.addFieldError('Introduzca email');
    textPassword.addFieldError('Introduzca contraseña');
    textPassword2.addFieldError('Introduzca constraseña');
  }

  @override
  void onSubmitting() async {
    try {
      var datsmiRegisterLogic = YupchargeRegisterLogic();
      textTelephone.updateInitialValue("");
      var responseRegister = await datsmiRegisterLogic.register(textName.value, textEmail.value, textTelephone.value, textPassword.value);
      var datsmiLoginLogic = YupchargeLoginLogic();
      var token = await datsmiLoginLogic.login(textEmail.value, textPassword.value);
      emitSuccess(successResponse: token, canSubmitAgain: true);
    } catch (e) {
      emitFailure(failureResponse:e.toString());
    }
  }
}