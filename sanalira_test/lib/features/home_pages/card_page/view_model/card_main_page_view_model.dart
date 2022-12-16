import 'package:mobx/mobx.dart';
import 'package:sanalira_test/cores/firebase_services/authentication_service.dart';
part 'card_main_page_view_model.g.dart';

class CardMainPageViewModel = _CardMainPageViewModelBase
    with _$CardMainPageViewModel;

abstract class _CardMainPageViewModelBase with Store {
  signOut() {
    AuthenticationService authenticationService = AuthenticationService();
    authenticationService.signOut();
  }
}
