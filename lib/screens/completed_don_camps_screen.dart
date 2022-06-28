import 'dart:math';

import 'package:admin/config/constants.dart';
import 'package:admin/models/donation_campaign.dart';
import 'package:admin/reusable_widgets/donation_campaign_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';

class CompletedDonCampsScreen extends StatelessWidget {
  CompletedDonCampsScreen({Key? key}) : super(key: key);

  static String routeName() => '/completed_don_camps_screen';
  final _faker = Faker.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('completed_camps'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        backgroundColor: bgColor,

        // Back Button
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          splashRadius: 20,
        ),
        actions: [],
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(
          defaultPadding,
          defaultPadding,
          defaultPadding,
          0,
        ),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return DonationCampaignCard(
            donationCampaign: DonationCampaign(
              id: index,
              titleAr: _faker.lorem.sentence(wordCount: 2),
              titleEn: _faker.lorem.sentence(wordCount: 2),
              targetAmount: double.parse(
                  (Random().nextDouble() * 100).toStringAsFixed(1)),
              collectedAmount: double.parse(
                  (Random().nextDouble() * 100).toStringAsFixed(1)),
              numberOfBeneficiaries: Random().nextInt(1000),
              coverImageUrl: _faker.image.unsplash.image(),
              startDate: _faker.date.past(DateTime.now(), rangeInYears: 1),
              endDate: _faker.date.between(
                DateTime.now().add(Duration(days: 1)),
                DateTime.now().add(Duration(days: 60)),
              ),
              // SET STATUS RANDOMLY EITHER COMPLETED OR CANCELLED
              status: Random().nextBool()
                  ? DonationCampaignStatus.completed
                  : DonationCampaignStatus.cancelled,
            ),
          );
        },
      ),
    );
  }
}