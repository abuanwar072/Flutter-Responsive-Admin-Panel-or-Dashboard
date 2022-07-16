import 'package:admin/config/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
    required this.onSearch,
  }) : super(key: key);
  final Function(String?) onSearch;
  final ValueNotifier<String?> searchText = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        searchText.value = value == '' ? null : value;
        onSearch(searchText.value);
      },
      decoration: InputDecoration(
        hintText: tr('search'),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding * 0.75,
        ),
        fillColor: secondaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintStyle: const TextStyle(color: Colors.black54),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(
              horizontal: defaultPadding * 0.5,
              vertical: defaultPadding * 0.25,
            ),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
