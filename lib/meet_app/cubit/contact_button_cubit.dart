import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpers/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButtonCubit extends Cubit<bool> {
  ContactButtonCubit() : super(false) {
    checkAvailability();
  }

  Future<void> checkAvailability() async {
    String message = Uri.encodeComponent("Olá Amanda, gostaria de treinar com você!\n Me mande seus planos!!");
    String whatsappUrlString = "whatsapp://send?phone=${Environment.phoneNumber}&text=$message";
    Uri whatsappUri = Uri.parse(whatsappUrlString);

    String smsUrlString = "sms:${Environment.phoneNumber}?body=$message";
    Uri smsUri = Uri.parse(smsUrlString);

    String emailUrlString = 'mailto:${Environment.email}?subject=Consulta&body=$message';
    Uri emailUri = Uri.parse(emailUrlString);

    bool canSendWhatsApp = await canLaunchUrl(whatsappUri);
    bool canSendSMS = await canLaunchUrl(smsUri);
    bool canSendEmail = await canLaunchUrl(emailUri);

    emit(canSendWhatsApp || canSendSMS || canSendEmail);
  }

  Future<void> sendMessage() async {
    String message = Uri.encodeComponent("Olá Amanda, gostaria de treinar com você!\n Me mande seus planos!!");
    String whatsappUrlString = "whatsapp://send?phone=${Environment.phoneNumber}&text=$message";
    Uri whatsappUri = Uri.parse(whatsappUrlString);

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
      } else {
        throw 'WhatsApp não disponível';
      }
    } catch (_) {
      String smsUrlString = "sms:${Environment.phoneNumber}?body=$message";
      Uri smsUri = Uri.parse(smsUrlString);

      try {
        if (await canLaunchUrl(smsUri)) {
          await launchUrl(smsUri);
        } else {
          throw 'SMS não disponível';
        }
      } catch (_) {
        String emailUrlString = 'mailto:${Environment.email}?subject=Consulta&body=$message';
        Uri emailUri = Uri.parse(emailUrlString);

        if (await canLaunchUrl(emailUri)) {
          await launchUrl(emailUri);
        } else {
          print('Nenhum aplicativo disponível para enviar a mensagem.');
        }
      }
    }
  }
}
