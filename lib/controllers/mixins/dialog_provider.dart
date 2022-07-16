import 'package:admin/config/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

mixin DialogProvider {
  // SHOW A DIALOGUE WITH A CIRCULAR LOADING INDICATOR AND LOADING TEXT UNDER IT
  Future<void> showLoadingDialoge(BuildContext context, [String? asset]) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                asset ?? 'assets/animations/data_loading_animation.json',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const SizedBox(height: defaultPadding),
              Text(
                tr('loading'),
                style: const TextStyle(color: loadingColor),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
          // show confirm dialogueO
          // the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('discard_changes').tr(),
            content: Text(
              'discard_warning',
              style: Theme.of(context).textTheme.bodyMedium,
            ).tr(),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.red.withOpacity(0.1),
                  ),
                ),
                //return false when click on "NO"
                child: Text('no', style: Theme.of(context).textTheme.bodyLarge)
                    .tr(),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => primaryColor.withOpacity(0.1),
                  ),
                ),
                //return true when click on "Yes"
                child: Text('yes', style: Theme.of(context).textTheme.bodyLarge)
                    .tr(),
              ),
            ],
          ),
        ) ??
        false; // if showDialogue had returned null, then return false
  }

  Future<bool> showDeleteWarningDialogue(context) async {
    return await showDialog(
          // show confirm dialogue
          // the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'warning',
              style: TextStyle(color: Colors.red),
            ).tr(),
            content: Text(
              'delete_person_warning',
              style: Theme.of(context).textTheme.bodyMedium,
            ).tr(),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.red.withOpacity(0.1),
                  ),
                ),
                //return false when click on "NO"
                child: Text('no', style: Theme.of(context).textTheme.bodyLarge)
                    .tr(),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => primaryColor.withOpacity(0.1),
                  ),
                ),
                //return true when click on "Yes"
                child: Text('yes', style: Theme.of(context).textTheme.bodyLarge)
                    .tr(),
              ),
            ],
          ),
        ) ??
        false; // if showDialogue had returned null, then return false
  }
}
// Column(
              //   mainAxisSize: MainAxisSize.min,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const SizedBox(height: defaultPadding),
              //     const CircularProgressIndicator(
              //       color: primaryColor,
              //     ),
                  // const SizedBox(height: defaultPadding),
                  // Text(tr('loading')),
              //   ],
              // ),