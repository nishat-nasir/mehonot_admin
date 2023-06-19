// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppIntl {
  AppIntl();

  static AppIntl? _current;

  static AppIntl get current {
    assert(_current != null,
        'No instance of AppIntl was loaded. Try to initialize the AppIntl delegate before accessing AppIntl.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppIntl> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppIntl();
      AppIntl._current = instance;

      return instance;
    });
  }

  static AppIntl of(BuildContext context) {
    final instance = AppIntl.maybeOf(context);
    assert(instance != null,
        'No instance of AppIntl present in the widget tree. Did you add AppIntl.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppIntl? maybeOf(BuildContext context) {
    return Localizations.of<AppIntl>(context, AppIntl);
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get companyName {
    return Intl.message(
      'Company Name',
      name: 'companyName',
      desc: '',
      args: [],
    );
  }

  /// `Job Description`
  String get jobDescription {
    return Intl.message(
      'Job Description',
      name: 'jobDescription',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Cities`
  String get cities {
    return Intl.message(
      'Cities',
      name: 'cities',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Division`
  String get division {
    return Intl.message(
      'Division',
      name: 'division',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get district {
    return Intl.message(
      'District',
      name: 'district',
      desc: '',
      args: [],
    );
  }

  /// `Recruit Condition`
  String get recruitCondition {
    return Intl.message(
      'Recruit Condition',
      name: 'recruitCondition',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Personnel`
  String get personnel {
    return Intl.message(
      'Personnel',
      name: 'personnel',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get deadline {
    return Intl.message(
      'Deadline',
      name: 'deadline',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Wages`
  String get wages {
    return Intl.message(
      'Wages',
      name: 'wages',
      desc: '',
      args: [],
    );
  }

  /// `Period`
  String get period {
    return Intl.message(
      'Period',
      name: 'period',
      desc: '',
      args: [],
    );
  }

  /// `Start time`
  String get startTime {
    return Intl.message(
      'Start time',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `End time`
  String get endTime {
    return Intl.message(
      'End time',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get updateJob {
    return Intl.message(
      'Update',
      name: 'updateJob',
      desc: '',
      args: [],
    );
  }

  /// `Password can not be empty`
  String get pwdCanNotEmpty {
    return Intl.message(
      'Password can not be empty',
      name: 'pwdCanNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password should contain at least 8 characters`
  String get pwdShouldContain {
    return Intl.message(
      'Password should contain at least 8 characters',
      name: 'pwdShouldContain',
      desc: '',
      args: [],
    );
  }

  /// `This field can not be empty`
  String get fieldCanNotEmpty {
    return Intl.message(
      'This field can not be empty',
      name: 'fieldCanNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Number can not be zero or negative`
  String get numCanNotZeroNeg {
    return Intl.message(
      'Number can not be zero or negative',
      name: 'numCanNotZeroNeg',
      desc: '',
      args: [],
    );
  }

  /// `Email can not be empty`
  String get emailCanNotEmpty {
    return Intl.message(
      'Email can not be empty',
      name: 'emailCanNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invalidEmail {
    return Intl.message(
      'Invalid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Phone number can not be empty`
  String get phoneCanNotEmpty {
    return Intl.message(
      'Phone number can not be empty',
      name: 'phoneCanNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalidPhone {
    return Intl.message(
      'Invalid phone number',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Job Post`
  String get confirmJobPost {
    return Intl.message(
      'Confirm Job Post',
      name: 'confirmJobPost',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Job Update`
  String get confirmJobUpdate {
    return Intl.message(
      'Confirm Job Update',
      name: 'confirmJobUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to post this job?`
  String get sureToPostJob {
    return Intl.message(
      'Are you sure to post this job?',
      name: 'sureToPostJob',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `OTP`
  String get otp {
    return Intl.message(
      'OTP',
      name: 'otp',
      desc: '',
      args: [],
    );
  }

  /// `Sent OTP`
  String get otpSent {
    return Intl.message(
      'Sent OTP',
      name: 'otpSent',
      desc: '',
      args: [],
    );
  }

  /// `Invalid OTP`
  String get invalidOTP {
    return Intl.message(
      'Invalid OTP',
      name: 'invalidOTP',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get resendOTP {
    return Intl.message(
      'Resend OTP',
      name: 'resendOTP',
      desc: '',
      args: [],
    );
  }

  /// `Job posted successfully`
  String get jobPostSuccess {
    return Intl.message(
      'Job posted successfully',
      name: 'jobPostSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Job updated successfully`
  String get jobUpdateSuccess {
    return Intl.message(
      'Job updated successfully',
      name: 'jobUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Job post failed`
  String get jobPostFailed {
    return Intl.message(
      'Job post failed',
      name: 'jobPostFailed',
      desc: '',
      args: [],
    );
  }

  /// `Job update failed`
  String get jobUpdateFailed {
    return Intl.message(
      'Job update failed',
      name: 'jobUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Login Error!`
  String get loginError {
    return Intl.message(
      'Login Error!',
      name: 'loginError',
      desc: '',
      args: [],
    );
  }

  /// `Please try again!`
  String get pleaseTryAgain {
    return Intl.message(
      'Please try again!',
      name: 'pleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Press back again to exit`
  String get pressBackAgainToExit {
    return Intl.message(
      'Press back again to exit',
      name: 'pressBackAgainToExit',
      desc: '',
      args: [],
    );
  }

  /// `Hour`
  String get hour {
    return Intl.message(
      'Hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `Minute`
  String get minute {
    return Intl.message(
      'Minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `Validation Error!`
  String get validationError {
    return Intl.message(
      'Validation Error!',
      name: 'validationError',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `More Info`
  String get moreInfo {
    return Intl.message(
      'More Info',
      name: 'moreInfo',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Work Days`
  String get workDays {
    return Intl.message(
      'Work Days',
      name: 'workDays',
      desc: '',
      args: [],
    );
  }

  /// `Skills`
  String get skills {
    return Intl.message(
      'Skills',
      name: 'skills',
      desc: '',
      args: [],
    );
  }

  /// `Experience`
  String get experience {
    return Intl.message(
      'Experience',
      name: 'experience',
      desc: '',
      args: [],
    );
  }

  /// `Job Type`
  String get jobType {
    return Intl.message(
      'Job Type',
      name: 'jobType',
      desc: '',
      args: [],
    );
  }

  /// `Job Category`
  String get jobCategory {
    return Intl.message(
      'Job Category',
      name: 'jobCategory',
      desc: '',
      args: [],
    );
  }

  /// `Education Level`
  String get educationLevel {
    return Intl.message(
      'Education Level',
      name: 'educationLevel',
      desc: '',
      args: [],
    );
  }

  /// `Birth`
  String get birth {
    return Intl.message(
      'Birth',
      name: 'birth',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Position`
  String get position {
    return Intl.message(
      'Position',
      name: 'position',
      desc: '',
      args: [],
    );
  }

  /// `Position Name`
  String get positionName {
    return Intl.message(
      'Position Name',
      name: 'positionName',
      desc: '',
      args: [],
    );
  }

  /// `Add Skills`
  String get addSkills {
    return Intl.message(
      'Add Skills',
      name: 'addSkills',
      desc: '',
      args: [],
    );
  }

  /// `Add Education`
  String get addEducation {
    return Intl.message(
      'Add Education',
      name: 'addEducation',
      desc: '',
      args: [],
    );
  }

  /// `Add Experience`
  String get addExperience {
    return Intl.message(
      'Add Experience',
      name: 'addExperience',
      desc: '',
      args: [],
    );
  }

  /// `Institute Name`
  String get instituteName {
    return Intl.message(
      'Institute Name',
      name: 'instituteName',
      desc: '',
      args: [],
    );
  }

  /// `Field of Study`
  String get fieldOfStudy {
    return Intl.message(
      'Field of Study',
      name: 'fieldOfStudy',
      desc: '',
      args: [],
    );
  }

  /// `Degree`
  String get degree {
    return Intl.message(
      'Degree',
      name: 'degree',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message(
      'Start Date',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get endDate {
    return Intl.message(
      'End Date',
      name: 'endDate',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Responsibilities`
  String get responsibilities {
    return Intl.message(
      'Responsibilities',
      name: 'responsibilities',
      desc: '',
      args: [],
    );
  }

  /// `Etc`
  String get etc {
    return Intl.message(
      'Etc',
      name: 'etc',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Bengali`
  String get bengali {
    return Intl.message(
      'Bengali',
      name: 'bengali',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection!`
  String get noInternet {
    return Intl.message(
      'No Internet Connection!',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again`
  String get noInternetCheck {
    return Intl.message(
      'Please check your internet connection and try again',
      name: 'noInternetCheck',
      desc: '',
      args: [],
    );
  }

  /// `No Data Found!`
  String get noData {
    return Intl.message(
      'No Data Found!',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `No Job Found!`
  String get noJobFound {
    return Intl.message(
      'No Job Found!',
      name: 'noJobFound',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `App Version`
  String get appVersion {
    return Intl.message(
      'App Version',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Update Available`
  String get updateAvailable {
    return Intl.message(
      'Update Available',
      name: 'updateAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Now`
  String get now {
    return Intl.message(
      'Now',
      name: 'now',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Update App`
  String get updateApp {
    return Intl.message(
      'Update App',
      name: 'updateApp',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to update app?`
  String get doYouWantToUpdateApp {
    return Intl.message(
      'Do you want to update app?',
      name: 'doYouWantToUpdateApp',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `App Info`
  String get appInfo {
    return Intl.message(
      'App Info',
      name: 'appInfo',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `You want to logout?`
  String get youWantToLogout {
    return Intl.message(
      'You want to logout?',
      name: 'youWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get others {
    return Intl.message(
      'Others',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `Here you can request us to post a job or become a ceo and post and control by yourself`
  String get postJobHereMsg {
    return Intl.message(
      'Here you can request us to post a job or become a ceo and post and control by yourself',
      name: 'postJobHereMsg',
      desc: '',
      args: [],
    );
  }

  /// `Post Job`
  String get postJob {
    return Intl.message(
      'Post Job',
      name: 'postJob',
      desc: '',
      args: [],
    );
  }

  /// `Become a CEO`
  String get becomeACeo {
    return Intl.message(
      'Become a CEO',
      name: 'becomeACeo',
      desc: '',
      args: [],
    );
  }

  /// `Saved Jobs`
  String get savedJobs {
    return Intl.message(
      'Saved Jobs',
      name: 'savedJobs',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `There is no saved job`
  String get thereIsNoSavedJob {
    return Intl.message(
      'There is no saved job',
      name: 'thereIsNoSavedJob',
      desc: '',
      args: [],
    );
  }

  /// `There is no job description`
  String get thereIsNoJobDescription {
    return Intl.message(
      'There is no job description',
      name: 'thereIsNoJobDescription',
      desc: '',
      args: [],
    );
  }

  /// `Work Condition`
  String get workCondition {
    return Intl.message(
      'Work Condition',
      name: 'workCondition',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get nextStep {
    return Intl.message(
      'Next',
      name: 'nextStep',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get verifyOtp {
    return Intl.message(
      'Verify OTP',
      name: 'verifyOtp',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Name`
  String get invalidName {
    return Intl.message(
      'Invalid Name',
      name: 'invalidName',
      desc: '',
      args: [],
    );
  }

  /// `Password doesn't match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Password doesn\'t match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `This number already exist`
  String get numberAlreadyExist {
    return Intl.message(
      'This number already exist',
      name: 'numberAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `OTP must be 6 digit`
  String get otpMustBe6Digit {
    return Intl.message(
      'OTP must be 6 digit',
      name: 'otpMustBe6Digit',
      desc: '',
      args: [],
    );
  }

  /// `Go to Login Page`
  String get goToLoginPage {
    return Intl.message(
      'Go to Login Page',
      name: 'goToLoginPage',
      desc: '',
      args: [],
    );
  }

  /// `Congratulation!`
  String get congratulation {
    return Intl.message(
      'Congratulation!',
      name: 'congratulation',
      desc: '',
      args: [],
    );
  }

  /// `You're now a member of Porisom Family`
  String get successLoginMsg {
    return Intl.message(
      'You\'re now a member of Porisom Family',
      name: 'successLoginMsg',
      desc: '',
      args: [],
    );
  }

  /// `There is no bio. Please add bio to attract more recruiters.`
  String get noBio {
    return Intl.message(
      'There is no bio. Please add bio to attract more recruiters.',
      name: 'noBio',
      desc: '',
      args: [],
    );
  }

  /// `No skills are added. You can add it from Edit Profile`
  String get noSkill {
    return Intl.message(
      'No skills are added. You can add it from Edit Profile',
      name: 'noSkill',
      desc: '',
      args: [],
    );
  }

  /// `No education are added. You can add it from Edit Profile`
  String get noEducation {
    return Intl.message(
      'No education are added. You can add it from Edit Profile',
      name: 'noEducation',
      desc: '',
      args: [],
    );
  }

  /// `No experience are added. You can add it from Edit Profile`
  String get noExperience {
    return Intl.message(
      'No experience are added. You can add it from Edit Profile',
      name: 'noExperience',
      desc: '',
      args: [],
    );
  }

  /// `No language was added. You can add it from Edit Profile`
  String get noLanguage {
    return Intl.message(
      'No language was added. You can add it from Edit Profile',
      name: 'noLanguage',
      desc: '',
      args: [],
    );
  }

  /// `No certificate was added. You can add it from Edit Profile`
  String get noCertificate {
    return Intl.message(
      'No certificate was added. You can add it from Edit Profile',
      name: 'noCertificate',
      desc: '',
      args: [],
    );
  }

  /// `No project was added. You can add it from Edit Profile`
  String get noProject {
    return Intl.message(
      'No project was added. You can add it from Edit Profile',
      name: 'noProject',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message(
      'Area',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message(
      'Bio',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `No Saved Job`
  String get noSavedJob {
    return Intl.message(
      'No Saved Job',
      name: 'noSavedJob',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Login ID`
  String get loginId {
    return Intl.message(
      'Login ID',
      name: 'loginId',
      desc: '',
      args: [],
    );
  }

  /// `Premium`
  String get premium {
    return Intl.message(
      'Premium',
      name: 'premium',
      desc: '',
      args: [],
    );
  }

  /// `Change Login ID`
  String get changeLoginId {
    return Intl.message(
      'Change Login ID',
      name: 'changeLoginId',
      desc: '',
      args: [],
    );
  }

  /// `Change Division`
  String get changeDivision {
    return Intl.message(
      'Change Division',
      name: 'changeDivision',
      desc: '',
      args: [],
    );
  }

  /// `My Job Posts`
  String get myJobPosts {
    return Intl.message(
      'My Job Posts',
      name: 'myJobPosts',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `No Job Posts Found`
  String get noJobPosts {
    return Intl.message(
      'No Job Posts Found',
      name: 'noJobPosts',
      desc: '',
      args: [],
    );
  }

  /// `Got any idea to work on? \nPost it here and get the best candidates for your company.`
  String get noJobPostsDescription {
    return Intl.message(
      'Got any idea to work on? \nPost it here and get the best candidates for your company.',
      name: 'noJobPostsDescription',
      desc: '',
      args: [],
    );
  }

  /// `No More Job Found`
  String get noMoreJobFound {
    return Intl.message(
      'No More Job Found',
      name: 'noMoreJobFound',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message(
      'Dismiss',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Change ID`
  String get changeId {
    return Intl.message(
      'Change ID',
      name: 'changeId',
      desc: '',
      args: [],
    );
  }

  /// `We are always looking for ways to improve our app. Please share your feedback with us.`
  String get feedbackComment {
    return Intl.message(
      'We are always looking for ways to improve our app. Please share your feedback with us.',
      name: 'feedbackComment',
      desc: '',
      args: [],
    );
  }

  /// `Enter your feedback`
  String get enterYourFeedback {
    return Intl.message(
      'Enter your feedback',
      name: 'enterYourFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Your feedback is valuable to us. Please share your thoughts about our app.`
  String get feedbackCommentHint {
    return Intl.message(
      'Your feedback is valuable to us. Please share your thoughts about our app.',
      name: 'feedbackCommentHint',
      desc: '',
      args: [],
    );
  }

  /// `Amazing`
  String get amazing {
    return Intl.message(
      'Amazing',
      name: 'amazing',
      desc: '',
      args: [],
    );
  }

  /// `Excellent`
  String get excellent {
    return Intl.message(
      'Excellent',
      name: 'excellent',
      desc: '',
      args: [],
    );
  }

  /// `Good`
  String get good {
    return Intl.message(
      'Good',
      name: 'good',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message(
      'Okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `Bad`
  String get bad {
    return Intl.message(
      'Bad',
      name: 'bad',
      desc: '',
      args: [],
    );
  }

  /// `Very Bad`
  String get veryBad {
    return Intl.message(
      'Very Bad',
      name: 'veryBad',
      desc: '',
      args: [],
    );
  }

  /// `Terrible`
  String get terrible {
    return Intl.message(
      'Terrible',
      name: 'terrible',
      desc: '',
      args: [],
    );
  }

  /// `Thanks! 🫶 Feedback submitted successfully.\n We will try to improve our app.`
  String get feedbackCommentSuccess {
    return Intl.message(
      'Thanks! 🫶 Feedback submitted successfully.\n We will try to improve our app.',
      name: 'feedbackCommentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to change your division?`
  String get changeDivisionConfirmation {
    return Intl.message(
      'Are you sure to change your division?',
      name: 'changeDivisionConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `My Job Applications List`
  String get myJobApplicationsList {
    return Intl.message(
      'My Job Applications List',
      name: 'myJobApplicationsList',
      desc: '',
      args: [],
    );
  }

  /// `No Job Applications Found`
  String get noJobApplications {
    return Intl.message(
      'No Job Applications Found',
      name: 'noJobApplications',
      desc: '',
      args: [],
    );
  }

  /// `You have not applied for any job yet. \nApply for a job and get hired.`
  String get noJobApplicationsDescription {
    return Intl.message(
      'You have not applied for any job yet. \nApply for a job and get hired.',
      name: 'noJobApplicationsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Apply to Jobs`
  String get applyToJobs {
    return Intl.message(
      'Apply to Jobs',
      name: 'applyToJobs',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Applied`
  String get applied {
    return Intl.message(
      'Applied',
      name: 'applied',
      desc: '',
      args: [],
    );
  }

  /// `Already Applied`
  String get alreadyApplied {
    return Intl.message(
      'Already Applied',
      name: 'alreadyApplied',
      desc: '',
      args: [],
    );
  }

  /// `You have already applied for this job. \nPlease wait for the recruiter to contact you.`
  String get alreadyAppliedDescription {
    return Intl.message(
      'You have already applied for this job. \nPlease wait for the recruiter to contact you.',
      name: 'alreadyAppliedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Apply to Job`
  String get applyToJob {
    return Intl.message(
      'Apply to Job',
      name: 'applyToJob',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to apply for this job?`
  String get areYouSureToApplyJob {
    return Intl.message(
      'Are you sure to apply for this job?',
      name: 'areYouSureToApplyJob',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Application`
  String get withdrawApplication {
    return Intl.message(
      'Withdraw Application',
      name: 'withdrawApplication',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Profile update failed`
  String get profileUpdateFailed {
    return Intl.message(
      'Profile update failed',
      name: 'profileUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Save Profile`
  String get saveProfile {
    return Intl.message(
      'Save Profile',
      name: 'saveProfile',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to save profile?`
  String get areYouSureToSaveProfile {
    return Intl.message(
      'Are you sure to save profile?',
      name: 'areYouSureToSaveProfile',
      desc: '',
      args: [],
    );
  }

  /// `Search Jobs`
  String get searchJobs {
    return Intl.message(
      'Search Jobs',
      name: 'searchJobs',
      desc: '',
      args: [],
    );
  }

  /// `App will restart again`
  String get appWillRestartAgain {
    return Intl.message(
      'App will restart again',
      name: 'appWillRestartAgain',
      desc: '',
      args: [],
    );
  }

  /// `App is resetting`
  String get appIsResetting {
    return Intl.message(
      'App is resetting',
      name: 'appIsResetting',
      desc: '',
      args: [],
    );
  }

  /// `Dhaka`
  String get divDhk {
    return Intl.message(
      'Dhaka',
      name: 'divDhk',
      desc: '',
      args: [],
    );
  }

  /// `Chittagong`
  String get divCtg {
    return Intl.message(
      'Chittagong',
      name: 'divCtg',
      desc: '',
      args: [],
    );
  }

  /// `Khulna`
  String get divKhl {
    return Intl.message(
      'Khulna',
      name: 'divKhl',
      desc: '',
      args: [],
    );
  }

  /// `Rajshahi`
  String get divRaj {
    return Intl.message(
      'Rajshahi',
      name: 'divRaj',
      desc: '',
      args: [],
    );
  }

  /// `Barisal`
  String get divBar {
    return Intl.message(
      'Barisal',
      name: 'divBar',
      desc: '',
      args: [],
    );
  }

  /// `Sylhet`
  String get divSyl {
    return Intl.message(
      'Sylhet',
      name: 'divSyl',
      desc: '',
      args: [],
    );
  }

  /// `Rangpur`
  String get divRng {
    return Intl.message(
      'Rangpur',
      name: 'divRng',
      desc: '',
      args: [],
    );
  }

  /// `Mymensingh`
  String get divMym {
    return Intl.message(
      'Mymensingh',
      name: 'divMym',
      desc: '',
      args: [],
    );
  }

  /// `Part Time`
  String get partTimeStr {
    return Intl.message(
      'Part Time',
      name: 'partTimeStr',
      desc: '',
      args: [],
    );
  }

  /// `Full Time`
  String get fullTimeStr {
    return Intl.message(
      'Full Time',
      name: 'fullTimeStr',
      desc: '',
      args: [],
    );
  }

  /// `Contractual`
  String get contractualStr {
    return Intl.message(
      'Contractual',
      name: 'contractualStr',
      desc: '',
      args: [],
    );
  }

  /// `One Day Job`
  String get oneDayJobStr {
    return Intl.message(
      'One Day Job',
      name: 'oneDayJobStr',
      desc: '',
      args: [],
    );
  }

  /// `Internship`
  String get internshipStr {
    return Intl.message(
      'Internship',
      name: 'internshipStr',
      desc: '',
      args: [],
    );
  }

  /// `Volunteer`
  String get volunteerStr {
    return Intl.message(
      'Volunteer',
      name: 'volunteerStr',
      desc: '',
      args: [],
    );
  }

  /// `Remote`
  String get remoteStr {
    return Intl.message(
      'Remote',
      name: 'remoteStr',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get website {
    return Intl.message(
      'Website',
      name: 'website',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get changeEmail {
    return Intl.message(
      'Change Email',
      name: 'changeEmail',
      desc: '',
      args: [],
    );
  }

  /// `Current Email`
  String get currentEmail {
    return Intl.message(
      'Current Email',
      name: 'currentEmail',
      desc: '',
      args: [],
    );
  }

  /// `Company Logo`
  String get companyLogo {
    return Intl.message(
      'Company Logo',
      name: 'companyLogo',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get company {
    return Intl.message(
      'Company',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete this job?`
  String get deleteJobConfirm {
    return Intl.message(
      'Are you sure to delete this job?',
      name: 'deleteJobConfirm',
      desc: '',
      args: [],
    );
  }

  /// `You can't change company name`
  String get canNotChangeComName {
    return Intl.message(
      'You can\'t change company name',
      name: 'canNotChangeComName',
      desc: '',
      args: [],
    );
  }

  /// `You can't change the Company name\nor Logo after posting the job.`
  String get canNotChangeComNameOrLogo {
    return Intl.message(
      'You can\'t change the Company name\nor Logo after posting the job.',
      name: 'canNotChangeComNameOrLogo',
      desc: '',
      args: [],
    );
  }

  /// `Hourly`
  String get hourlyStr {
    return Intl.message(
      'Hourly',
      name: 'hourlyStr',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get dailyStr {
    return Intl.message(
      'Daily',
      name: 'dailyStr',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weeklyStr {
    return Intl.message(
      'Weekly',
      name: 'weeklyStr',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthlyStr {
    return Intl.message(
      'Monthly',
      name: 'monthlyStr',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearlyStr {
    return Intl.message(
      'Yearly',
      name: 'yearlyStr',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterdayStr {
    return Intl.message(
      'Yesterday',
      name: 'yesterdayStr',
      desc: '',
      args: [],
    );
  }

  /// `days ago`
  String get daysAgoStr {
    return Intl.message(
      'days ago',
      name: 'daysAgoStr',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get todayStr {
    return Intl.message(
      'Today',
      name: 'todayStr',
      desc: '',
      args: [],
    );
  }

  /// `Deadline has passed`
  String get deadlineHasPassed {
    return Intl.message(
      'Deadline has passed',
      name: 'deadlineHasPassed',
      desc: '',
      args: [],
    );
  }

  /// `month(s) left`
  String get monthLeft {
    return Intl.message(
      'month(s) left',
      name: 'monthLeft',
      desc: '',
      args: [],
    );
  }

  /// `day(s) left`
  String get dayLeft {
    return Intl.message(
      'day(s) left',
      name: 'dayLeft',
      desc: '',
      args: [],
    );
  }

  /// `week(s) left`
  String get weekLeft {
    return Intl.message(
      'week(s) left',
      name: 'weekLeft',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get satStr {
    return Intl.message(
      'Sat',
      name: 'satStr',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get sunStr {
    return Intl.message(
      'Sun',
      name: 'sunStr',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get monStr {
    return Intl.message(
      'Mon',
      name: 'monStr',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get tueStr {
    return Intl.message(
      'Tue',
      name: 'tueStr',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get wedStr {
    return Intl.message(
      'Wed',
      name: 'wedStr',
      desc: '',
      args: [],
    );
  }

  /// `Thu`
  String get thuStr {
    return Intl.message(
      'Thu',
      name: 'thuStr',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get friStr {
    return Intl.message(
      'Fri',
      name: 'friStr',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppIntl> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'bn'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppIntl> load(Locale locale) => AppIntl.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
