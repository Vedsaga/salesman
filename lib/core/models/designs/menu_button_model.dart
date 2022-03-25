class MenuButtonModel {
  final String title;
  final String iconName;
  final Function onTap;
  final bool disabled;

  MenuButtonModel({
    required this.title,
    required this.iconName,
    required this.onTap,
    required this.disabled,
  });
}
