import 'dart:math';

import 'package:admin/config/constants.dart';
import 'package:admin/controllers/donation_operations/donation_operations_bloc.dart';
import 'package:admin/controllers/mixins/dialog_provider.dart';
import 'package:admin/models/donation_operation.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationsHistoryScreen extends StatelessWidget with DialogProvider {
  DonationsHistoryScreen({Key? key}) : super(key: key);

  static String routeName() => '/donations_history_screen';
  final ValueNotifier<bool> isLoadingDialogVisible = ValueNotifier(false);

  final Faker faker = Faker.instance;
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'prev_don_op',
          style: Theme.of(context).textTheme.titleMedium,
        ).tr(),
        elevation: 0,
        backgroundColor: bgColor,

        // Back Button
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          splashRadius: 20,
        ),
      ),
      body: BlocConsumer<DonationOperationsBloc, DonationOperationsState>(
        listener: (context, state) async {
          if (state is DonationOperationsLoading) {
            showLoadingDialoge(context);
            isLoadingDialogVisible.value = true;
          } else {
            if (isLoadingDialogVisible.value) {
              isLoadingDialogVisible.value = false;
              Navigator.pop(context);
            }
          }
        },
        builder: (context, state) {
          if (state is DonationOperationsError) {
            return UnexpectedErrorWidget(
              onRetryPressed: () {
                BlocProvider.of<DonationOperationsBloc>(context)
                    .add(GetDonationOperations());
              },
            );
          }
          if (state is DonationOperationsLoaded) {
            if (state.donationOperations.isEmpty) {
              return NoDataWidget(
                onRefreshPressed: () {
                  context
                      .read<DonationOperationsBloc>()
                      .add(GetDonationOperations());
                },
                message: tr('no_donation_operations'),
              );
            }
            List<DonationOperation> sortedDonationOperations =
                state.donationOperations.toList()
                  ..sort((a, b) => b.paymentDate!.compareTo(a.paymentDate!));
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              color: primaryColor,
              onRefresh: () async {
                BlocProvider.of<DonationOperationsBloc>(context)
                    .add(GetDonationOperations());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(defaultPadding),
                physics: const BouncingScrollPhysics(),
                itemCount: sortedDonationOperations.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: defaultPadding * 0.5),
                    child: DonationCard(
                      donationOperation: sortedDonationOperations[index],
                    ),
                  );
                },
              ),
            );
          }
          return ValueListenableBuilder<bool>(
            valueListenable: isLoadingDialogVisible,
            builder: (context, value, child) {
              if (!value && state is DonationOperationsLoading) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        color: primaryColor,
                      ),
                      const SizedBox(height: defaultPadding),
                      Text(
                        tr('loading'),
                        style: const TextStyle(color: primaryColor),
                      ),
                    ],
                  ),
                );
              }

              return Container();
            },
          );
        },
      ),
    );
  }
}
