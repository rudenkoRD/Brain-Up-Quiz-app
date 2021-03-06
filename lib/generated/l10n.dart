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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get main_screen_title {
    return Intl.message(
      'Home',
      name: 'main_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `My tests`
  String get my_tests_bar_title {
    return Intl.message(
      'My tests',
      name: 'my_tests_bar_title',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get favourite_screen_title {
    return Intl.message(
      'Favourite',
      name: 'favourite_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_screen_title {
    return Intl.message(
      'Settings',
      name: 'settings_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Create a new test`
  String get create_new_test_heading {
    return Intl.message(
      'Create a new test',
      name: 'create_new_test_heading',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get heading_label {
    return Intl.message(
      'Title',
      name: 'heading_label',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subject_label {
    return Intl.message(
      'Subject',
      name: 'subject_label',
      desc: '',
      args: [],
    );
  }

  /// `easy`
  String get easy_label {
    return Intl.message(
      'easy',
      name: 'easy_label',
      desc: '',
      args: [],
    );
  }

  /// `medium`
  String get medium_label {
    return Intl.message(
      'medium',
      name: 'medium_label',
      desc: '',
      args: [],
    );
  }

  /// `hard`
  String get hard_label {
    return Intl.message(
      'hard',
      name: 'hard_label',
      desc: '',
      args: [],
    );
  }

  /// `insane`
  String get insane_label {
    return Intl.message(
      'insane',
      name: 'insane_label',
      desc: '',
      args: [],
    );
  }

  /// `???`
  String get unknown_label {
    return Intl.message(
      '???',
      name: 'unknown_label',
      desc: '',
      args: [],
    );
  }

  /// `Author`
  String get author_label {
    return Intl.message(
      'Author',
      name: 'author_label',
      desc: '',
      args: [],
    );
  }

  /// `Created at`
  String get created_at_label {
    return Intl.message(
      'Created at',
      name: 'created_at_label',
      desc: '',
      args: [],
    );
  }

  /// `Dfficulty`
  String get difficulty_label {
    return Intl.message(
      'Dfficulty',
      name: 'difficulty_label',
      desc: '',
      args: [],
    );
  }

  /// `Mark`
  String get mark_label {
    return Intl.message(
      'Mark',
      name: 'mark_label',
      desc: '',
      args: [],
    );
  }

  /// `Marks`
  String get rating_label {
    return Intl.message(
      'Marks',
      name: 'rating_label',
      desc: '',
      args: [],
    );
  }

  /// `Single choice`
  String get single_choice_question_label {
    return Intl.message(
      'Single choice',
      name: 'single_choice_question_label',
      desc: '',
      args: [],
    );
  }

  /// `True / false`
  String get yes_no_question_label {
    return Intl.message(
      'True / false',
      name: 'yes_no_question_label',
      desc: '',
      args: [],
    );
  }

  /// `Short answer`
  String get short_answer_question_label {
    return Intl.message(
      'Short answer',
      name: 'short_answer_question_label',
      desc: '',
      args: [],
    );
  }

  /// `Correct order`
  String get correct_order_question_label {
    return Intl.message(
      'Correct order',
      name: 'correct_order_question_label',
      desc: '',
      args: [],
    );
  }

  /// `Multiple choice`
  String get multiple_answer_question_label {
    return Intl.message(
      'Multiple choice',
      name: 'multiple_answer_question_label',
      desc: '',
      args: [],
    );
  }

  /// `Matching`
  String get matching_question_question_label {
    return Intl.message(
      'Matching',
      name: 'matching_question_question_label',
      desc: '',
      args: [],
    );
  }

  /// `Take the test`
  String get take_test_label {
    return Intl.message(
      'Take the test',
      name: 'take_test_label',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete_label {
    return Intl.message(
      'Delete',
      name: 'delete_label',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new title`
  String get enter_heading_label {
    return Intl.message(
      'Enter a new title',
      name: 'enter_heading_label',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel_label {
    return Intl.message(
      'cancel',
      name: 'cancel_label',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get save_label {
    return Intl.message(
      'save',
      name: 'save_label',
      desc: '',
      args: [],
    );
  }

  /// `create`
  String get create_label {
    return Intl.message(
      'create',
      name: 'create_label',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get ok_label {
    return Intl.message(
      'ok',
      name: 'ok_label',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new subject`
  String get enter_subject_label {
    return Intl.message(
      'Enter a new subject',
      name: 'enter_subject_label',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next_label {
    return Intl.message(
      'Next',
      name: 'next_label',
      desc: '',
      args: [],
    );
  }

  /// `Select one correct answer`
  String get select_one_correct_answer_label {
    return Intl.message(
      'Select one correct answer',
      name: 'select_one_correct_answer_label',
      desc: '',
      args: [],
    );
  }

  /// `Answer error`
  String get answer_error_label {
    return Intl.message(
      'Answer error',
      name: 'answer_error_label',
      desc: '',
      args: [],
    );
  }

  /// `Select a correct answer`
  String get select_correct_answer_label {
    return Intl.message(
      'Select a correct answer',
      name: 'select_correct_answer_label',
      desc: '',
      args: [],
    );
  }

  /// `True`
  String get yes_label {
    return Intl.message(
      'True',
      name: 'yes_label',
      desc: '',
      args: [],
    );
  }

  /// `False`
  String get no_label {
    return Intl.message(
      'False',
      name: 'no_label',
      desc: '',
      args: [],
    );
  }

  /// `Enter a correct answer`
  String get enter_correct_answer_label {
    return Intl.message(
      'Enter a correct answer',
      name: 'enter_correct_answer_label',
      desc: '',
      args: [],
    );
  }

  /// `answer`
  String get answer_label {
    return Intl.message(
      'answer',
      name: 'answer_label',
      desc: '',
      args: [],
    );
  }

  /// `Field is required`
  String get field_cant_be_empty_label {
    return Intl.message(
      'Field is required',
      name: 'field_cant_be_empty_label',
      desc: '',
      args: [],
    );
  }

  /// `Place items in the correct order`
  String get place_items_in_the_correct_order_label {
    return Intl.message(
      'Place items in the correct order',
      name: 'place_items_in_the_correct_order_label',
      desc: '',
      args: [],
    );
  }

  /// `Select all correct answers`
  String get select_all_correct_answers_label {
    return Intl.message(
      'Select all correct answers',
      name: 'select_all_correct_answers_label',
      desc: '',
      args: [],
    );
  }

  /// `Match all options with correct answers`
  String get match_all_options_with_correct_answers_label {
    return Intl.message(
      'Match all options with correct answers',
      name: 'match_all_options_with_correct_answers_label',
      desc: '',
      args: [],
    );
  }

  /// `Finish the test`
  String get finish_test_label {
    return Intl.message(
      'Finish the test',
      name: 'finish_test_label',
      desc: '',
      args: [],
    );
  }

  /// `Delete this test?`
  String get delete_test_label {
    return Intl.message(
      'Delete this test?',
      name: 'delete_test_label',
      desc: '',
      args: [],
    );
  }

  /// `The test will be permanently deleted!`
  String get delete_text_warning {
    return Intl.message(
      'The test will be permanently deleted!',
      name: 'delete_text_warning',
      desc: '',
      args: [],
    );
  }

  /// `Add new question`
  String get add_question_label {
    return Intl.message(
      'Add new question',
      name: 'add_question_label',
      desc: '',
      args: [],
    );
  }

  /// `Select type of question`
  String get select_question_type_label {
    return Intl.message(
      'Select type of question',
      name: 'select_question_type_label',
      desc: '',
      args: [],
    );
  }

  /// `Double tap to delete the question`
  String get use_double_tap_to_delete_label {
    return Intl.message(
      'Double tap to delete the question',
      name: 'use_double_tap_to_delete_label',
      desc: '',
      args: [],
    );
  }

  /// `Swipe to delete`
  String get swipe_to_delete_label {
    return Intl.message(
      'Swipe to delete',
      name: 'swipe_to_delete_label',
      desc: '',
      args: [],
    );
  }

  /// `Option deleted`
  String get option_deleted_label {
    return Intl.message(
      'Option deleted',
      name: 'option_deleted_label',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect option`
  String get incorrect_option_label {
    return Intl.message(
      'Incorrect option',
      name: 'incorrect_option_label',
      desc: '',
      args: [],
    );
  }

  /// `Correct option`
  String get correct_option_label {
    return Intl.message(
      'Correct option',
      name: 'correct_option_label',
      desc: '',
      args: [],
    );
  }

  /// `User's answer`
  String get user_answer {
    return Intl.message(
      'User\'s answer',
      name: 'user_answer',
      desc: '',
      args: [],
    );
  }

  /// `Add some options. Order them correctly`
  String get ordering_tutorial {
    return Intl.message(
      'Add some options. Order them correctly',
      name: 'ordering_tutorial',
      desc: '',
      args: [],
    );
  }

  /// `option:`
  String get option_label {
    return Intl.message(
      'option:',
      name: 'option_label',
      desc: '',
      args: [],
    );
  }

  /// `The field should be unique`
  String get field_should_be_unique {
    return Intl.message(
      'The field should be unique',
      name: 'field_should_be_unique',
      desc: '',
      args: [],
    );
  }

  /// `Leave blank for wrong option`
  String get leave_blank_for_other_answer {
    return Intl.message(
      'Leave blank for wrong option',
      name: 'leave_blank_for_other_answer',
      desc: '',
      args: [],
    );
  }

  /// `Quiz should have at least one question!`
  String get quiz_should_have_questions_warning_label {
    return Intl.message(
      'Quiz should have at least one question!',
      name: 'quiz_should_have_questions_warning_label',
      desc: '',
      args: [],
    );
  }

  /// `Quiz not passed`
  String get test_not_completed_label {
    return Intl.message(
      'Quiz not passed',
      name: 'test_not_completed_label',
      desc: '',
      args: [],
    );
  }

  /// `To be able to vote and view questions, take the test.`
  String get test_not_completed_attention {
    return Intl.message(
      'To be able to vote and view questions, take the test.',
      name: 'test_not_completed_attention',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get result_title {
    return Intl.message(
      'Result',
      name: 'result_title',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_label {
    return Intl.message(
      'Continue',
      name: 'continue_label',
      desc: '',
      args: [],
    );
  }

  /// `Question editing`
  String get question_editing_label {
    return Intl.message(
      'Question editing',
      name: 'question_editing_label',
      desc: '',
      args: [],
    );
  }

  /// `Question deleted`
  String get question_deleted_label {
    return Intl.message(
      'Question deleted',
      name: 'question_deleted_label',
      desc: '',
      args: [],
    );
  }

  /// `question:`
  String get question_label {
    return Intl.message(
      'question:',
      name: 'question_label',
      desc: '',
      args: [],
    );
  }

  /// `Question type:`
  String get question_type_label {
    return Intl.message(
      'Question type:',
      name: 'question_type_label',
      desc: '',
      args: [],
    );
  }

  /// `Option type`
  String get option_type_label {
    return Intl.message(
      'Option type',
      name: 'option_type_label',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general_label {
    return Intl.message(
      'General',
      name: 'general_label',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications_label {
    return Intl.message(
      'Notifications',
      name: 'notifications_label',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account_label {
    return Intl.message(
      'Account',
      name: 'account_label',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit_label {
    return Intl.message(
      'Exit',
      name: 'exit_label',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time_label {
    return Intl.message(
      'Time',
      name: 'time_label',
      desc: '',
      args: [],
    );
  }

  /// `current`
  String get current_lang_label {
    return Intl.message(
      'current',
      name: 'current_lang_label',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language_label {
    return Intl.message(
      'Language',
      name: 'language_label',
      desc: '',
      args: [],
    );
  }

  /// `Select language`
  String get select_lang_label {
    return Intl.message(
      'Select language',
      name: 'select_lang_label',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english_lang_label {
    return Intl.message(
      'English',
      name: 'english_lang_label',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get russian_lang_label {
    return Intl.message(
      'Russian',
      name: 'russian_lang_label',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for internet connection`
  String get waiting_for_wifi_label {
    return Intl.message(
      'Waiting for internet connection',
      name: 'waiting_for_wifi_label',
      desc: '',
      args: [],
    );
  }

  /// `Fail. Check your password and username`
  String get login_fail_label {
    return Intl.message(
      'Fail. Check your password and username',
      name: 'login_fail_label',
      desc: '',
      args: [],
    );
  }

  /// `Fail. Try again later`
  String get signup_fail_label {
    return Intl.message(
      'Fail. Try again later',
      name: 'signup_fail_label',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for internet connection.`
  String get waiting_for_internet_label {
    return Intl.message(
      'Waiting for internet connection.',
      name: 'waiting_for_internet_label',
      desc: '',
      args: [],
    );
  }

  /// `Empty`
  String get empty_label {
    return Intl.message(
      'Empty',
      name: 'empty_label',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru', countryCode: 'RU'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}