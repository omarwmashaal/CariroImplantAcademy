import 'package:cariro_implant_academy/core/constants/enums/enums.dart';

abstract class SiteChangeBlocEvents{}
class GetSiteEvent extends SiteChangeBlocEvents{

}
class SetSiteEvent extends SiteChangeBlocEvents{
  final Website site;
  SetSiteEvent(this.site);
}