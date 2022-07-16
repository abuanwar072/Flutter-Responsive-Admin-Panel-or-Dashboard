class DrawerListItem {
  final String svgSrc;
  final String titleKey;

  DrawerListItem({
    required this.svgSrc,
    required this.titleKey,
  });
}

final List<DrawerListItem> sideMenuOptions = [
  DrawerListItem(
    svgSrc: 'assets/icons/menu_dashbord.svg',
    titleKey: 'home',
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/menu_doc.svg',
    titleKey: 'employees',
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/menu_profile.svg',
    titleKey: 'person_with_special_needs',
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/donation.svg',
    titleKey: 'donation',
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/menu_store.svg',
    titleKey: 'volunteer',
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/sponsorships.svg',
    titleKey: 'sponsorships',
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/menu_notification.svg',
    titleKey: 'notifications',
  ),
  DrawerListItem(
    svgSrc: 'assets/icons/menu_setting.svg',
    titleKey: 'settings',
  ),
];