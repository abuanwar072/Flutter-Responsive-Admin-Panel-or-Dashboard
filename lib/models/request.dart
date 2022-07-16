import 'dart:math';

import 'package:admin/models/models.dart';
import 'package:faker/faker.dart' as f;
import 'package:faker_dart/faker_dart.dart';

abstract class Request {
  final int id;
  final String presenterFullName;

  Request({
    required this.id,
    required this.presenterFullName,
  });
}

final _faker = f.Faker();
final _random = Random();
final List<Request> requests = [
  VolunteerRequest(
    id: 0,
    presenterFullName: Faker.instance.name.fullName(),
    volunteerPhone: Faker.instance.phoneNumber.phoneNumber(
      format: '+963 ### ### ###',
    ),
    volunteerEmail: _faker.internet.email(),
    volunteerCampaign: _faker.lorem.sentence(),
    volunteerBirthDate: Faker.instance.date.past(
      DateTime.now().subtract(const Duration(days: 365 * 18)),
      rangeInYears: 10,
    ),
    volunteerExpYears: _faker.randomGenerator.integer(15),
    volunteerUniversityDegreeUrl: _faker.image.image(),
  ),
  // SponsorshipRequest(
  //   id: 1,
  //   presenterFullName: Faker.instance.name.fullName(),
  //   sponsorEmail: _faker.internet.email(),
  //   sponsorPhone: Faker.instance.phoneNumber.phoneNumber(
  //     format: '+963 ### ### ###',
  //   ),
  //   sponsorNationalId:
  //       _faker.randomGenerator.numbers(99999999, 1).first.toString(),
  //   sponsorJob: Faker.instance.name.jobTitle(),
  //   annualSalary:
  //       double.parse(_random.nextDouble().toStringAsFixed(2)) * 100000,
  //   sponsorState: _faker.address.state(),
  //   sponsorCity: _faker.address.city(),
  //   sponsorNationalIDUrl: _faker.image.image(),
  // ),
  GiftRequest(
    id: 2,
    presenterFullName: Faker.instance.name.fullName(),
    recipientFullName: Faker.instance.name.fullName(),
    recipientPhone: Faker.instance.phoneNumber.phoneNumber(
      format: '+963 ### ### ###',
    ),
    giftValue: double.parse(_random.nextDouble().toStringAsFixed(2)) * 100,
    giftID: _faker.randomGenerator.integer(2),
  ),
  // SponsorshipRequest(
  //   id: 1,
  //   presenterFullName: Faker.instance.name.fullName(),
  //   sponsorEmail: _faker.internet.email(),
  //   sponsorPhone: Faker.instance.phoneNumber.phoneNumber(
  //     format: '+963 ### ### ###',
  //   ),
  //   sponsorNationalId: _faker.randomGenerator.numbers(99999999, 1).first.toString(),
  //   sponsorJob: Faker.instance.name.jobTitle(),
  //   annualSalary:
  //       double.parse(_random.nextDouble().toStringAsFixed(2)) * 100000,
  //   sponsorState: _faker.address.state(),
  //   sponsorCity: _faker.address.city(),
  //   sponsorNationalIDUrl: _faker.image.image(),
  // ),
  VolunteerRequest(
    id: 0,
    presenterFullName: Faker.instance.name.fullName(),
    volunteerPhone: Faker.instance.phoneNumber.phoneNumber(
      format: '+963 ### ### ###',
    ),
    volunteerEmail: _faker.internet.email(),
    volunteerCampaign: _faker.lorem.sentence(),
    volunteerBirthDate: Faker.instance.date.past(
      DateTime.now().subtract(const Duration(days: 365 * 18)),
      rangeInYears: _faker.randomGenerator.integer(10),
    ),
    volunteerExpYears: _faker.randomGenerator.integer(15),
    volunteerUniversityDegreeUrl: _faker.image.image(),
  ),
  VolunteerRequest(
    id: 0,
    presenterFullName: Faker.instance.name.fullName(),
    volunteerPhone: Faker.instance.phoneNumber.phoneNumber(
      format: '+963 ### ### ###',
    ),
    volunteerEmail: _faker.internet.email(),
    volunteerCampaign: _faker.lorem.sentence(),
    volunteerBirthDate: Faker.instance.date.past(
      DateTime.now().subtract(const Duration(days: 365 * 18)),
      rangeInYears: 10,
    ),
    volunteerExpYears: _faker.randomGenerator.integer(15),
    volunteerUniversityDegreeUrl: _faker.image.image(),
  ),
  GiftRequest(
    id: 2,
    presenterFullName: Faker.instance.name.fullName(),
    recipientFullName: Faker.instance.name.fullName(),
    recipientPhone: Faker.instance.phoneNumber.phoneNumber(
      format: '+963 ### ### ###',
    ),
    giftValue: double.parse(_random.nextDouble().toStringAsFixed(2)) * 100,
    giftID: _faker.randomGenerator.integer(2),
  ),
];
