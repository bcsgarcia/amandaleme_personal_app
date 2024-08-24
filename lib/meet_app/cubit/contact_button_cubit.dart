import 'dart:io' as io;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpers/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButtonCubit extends Cubit<bool> {
  ContactButtonCubit() : super(false) {
    checkAvailability();
  }

  Future<void> checkAvailability() async {
    if (io.Platform.isAndroid) {
      emit(true);
      return;
    }

    String message = Uri.encodeComponent("Olá Amanda, gostaria de treinar com você!\n Me mande seus planos!!");

    String whatsappUrlString;

    if (io.Platform.isIOS) {
      whatsappUrlString = "https://wa.me/${Environment.phoneNumber}?text=$message";
    } else {
      whatsappUrlString = "whatsapp://send?phone=${Environment.phoneNumber}&text=$message";
    }

    Uri whatsappUri = Uri.parse(whatsappUrlString);
    String smsUrlString = "sms:${Environment.phoneNumber}?body=$message";
    Uri smsUri = Uri.parse(smsUrlString);

    String emailUrlString = 'mailto:${Environment.email}?subject=Consulta&body=$message';
    Uri emailUri = Uri.parse(emailUrlString);

    bool canSendWhatsApp = await canLaunchUrl(whatsappUri);
    bool canSendSMS = await canLaunchUrl(smsUri);
    bool canSendEmail = await canLaunchUrl(emailUri);

    // Aqui você emite ou toma uma ação baseada na disponibilidade

    emit(canSendWhatsApp || canSendSMS || canSendEmail);
  }

  Future<void> sendMessage() async {
    String message = Uri.encodeComponent("Olá Amanda, gostaria de treinar com você!\n Me mande seus planos!!");
    String whatsappUrlString = "whatsapp://send?phone=${Environment.phoneNumber}&text=$message";

    whatsappUrlString = "whatsapp://send?phone=${Environment.phoneNumber}&text=$message";

    Uri whatsappUri = Uri.parse(whatsappUrlString);

    final whatsappWasCalled = await launchUrl(
      whatsappUri,
    );

    if (!whatsappWasCalled) {
      String smsUrlString = "sms:${Environment.phoneNumber}?body=$message";
      Uri smsUri = Uri.parse(smsUrlString);

      final smsWasCalled = await launchUrl(smsUri);

      if (!smsWasCalled) {
        String emailUrlString = 'mailto:${Environment.email}?subject=Consulta&body=$message';
        Uri emailUri = Uri.parse(emailUrlString);
        await launchUrl(emailUri);
      }
    }
  }
}
