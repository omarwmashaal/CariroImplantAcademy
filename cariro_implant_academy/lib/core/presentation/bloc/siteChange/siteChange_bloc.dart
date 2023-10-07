import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/siteChange/siteChange_blocEvents.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/siteChange/siteChange_blocStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injection_contianer.dart';

class SiteChangeBloc extends Bloc<SiteChangeBlocEvents,SiteChangeBlocStates>{
  SiteChangeBloc():super(CIA_SiteState()){
    on<GetSiteEvent>((event, emit) async {
      final site = siteController.getSite();
      if(site == null)
        {
          siteController.setSite(Website.CIA);
          emit(CIA_SiteState());
        }
      else {
        Website _site = Website.values[int.parse(site as String)];
        siteController.setSite(_site);
        if(_site == Website.CIA) {
          emit(CIA_SiteState());
        } else if(_site == Website.Lab) {
          emit(LAB_SiteState());
        } else if(_site == Website.Clinic) {
          emit(Clinic_SiteState());
        }
      }
    });
    on<SetSiteEvent>((event, emit) {
      siteController.setSite(event.site);
      sl<SharedPreferences>().setInt("Website", event.site.index);
      if(event.site == Website.CIA) {
        emit(CIA_SiteState());
      } else if(event.site == Website.Lab) {
        emit(LAB_SiteState());
      } else if(event.site == Website.Clinic) {
        emit(Clinic_SiteState());
      }
    },);
  }


}