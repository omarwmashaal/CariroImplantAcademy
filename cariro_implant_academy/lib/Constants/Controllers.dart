import 'package:cariro_implant_academy/Controllers/NavigationController.dart';
import 'package:cariro_implant_academy/Controllers/RolesController.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/core/helpers/dialogHelper.dart';

import '../Controllers/PagesController.dart';
import '../Widgets/AppBarBloc.dart';
import '../core/injection_contianer.dart';

NavigationController navigationController = NavigationController.instance;
PagesController pagesController = PagesController.instance;
InternalPagesController internalPagesController =
    InternalPagesController.instance;
RolesController rolesController = RolesController.instance;
late SiteController siteController ;
late AppBarBloc appBarBloc ;
late DialogHelper dialogHelper;



