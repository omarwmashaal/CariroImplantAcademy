import 'package:cariro_implant_academy/Controllers/NavigationController.dart';
import 'package:cariro_implant_academy/Controllers/RolesController.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';

import '../Controllers/PagesController.dart';

NavigationController navigationController = NavigationController.instance;
PagesController pagesController = PagesController.instance;
TabsController tabsController = new TabsController();
InternalPagesController internalPagesController =
    InternalPagesController.instance;
RolesController rolesController = RolesController.instance;
SiteController siteController = SiteController.instance;
