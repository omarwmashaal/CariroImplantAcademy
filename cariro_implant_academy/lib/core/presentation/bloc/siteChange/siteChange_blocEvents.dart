import 'package:cariro_implant_academy/Models/Enum.dart';

abstract class SiteChangeBlocEvents{}
class GetSiteEvent extends SiteChangeBlocEvents{

}
class SetSiteEvent extends SiteChangeBlocEvents{
  final Website site;
  SetSiteEvent(this.site);
}