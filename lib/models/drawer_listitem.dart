import 'package:easy_localization/easy_localization.dart';

class DrawerListItem {
  final String svgSrc;
  final String title;

  DrawerListItem({
    required this.svgSrc,
    required this.title,
  });
}

final List<DrawerListItem> sideMenuOptions = [
  DrawerListItem(
    svgSrc: 'assets/icons/menu_dashbord.svg',
    title: tr('home'),
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/menu_doc.svg',
    title: tr('employees'),
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/menu_profile.svg',
    title: tr('person_with_special_needs'),
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/donation.svg',
    title: tr('donation'),
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/menu_store.svg',
    title: tr('volunteer'),
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/sponsorships.svg',
    title: tr('sponsorships'),
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/menu_notification.svg',
    title: tr('notifications'),
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/menu_setting.svg',
    title: tr('settings'),
  ),
];
