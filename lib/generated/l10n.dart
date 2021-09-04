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

  /// `my tests`
  String get my_tests_bar_title {
    return Intl.message(
      'my tests',
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

  /// `title`
  String get heading_label {
    return Intl.message(
      'title',
      name: 'heading_label',
      desc: '',
      args: [],
    );
  }

  /// `subject`
  String get subject_label {
    return Intl.message(
      'subject',
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

  /// `author`
  String get author_label {
    return Intl.message(
      'author',
      name: 'author_label',
      desc: '',
      args: [],
    );
  }

  /// `created at`
  String get created_at_label {
    return Intl.message(
      'created at',
      name: 'created_at_label',
      desc: '',
      args: [],
    );
  }

  /// `difficulty`
  String get difficulty_label {
    return Intl.message(
      'difficulty',
      name: 'difficulty_label',
      desc: '',
      args: [],
    );
  }

  /// `mark`
  String get mark_label {
    return Intl.message(
      'mark',
      name: 'mark_label',
      desc: '',
      args: [],
    );
  }

  /// `marks`
  String get rating_label {
    return Intl.message(
      'marks',
      name: 'rating_label',
      desc: '',
      args: [],
    );
  }

  /// `single choice`
  String get single_choice_question_label {
    return Intl.message(
      'single choice',
      name: 'single_choice_question_label',
      desc: '',
      args: [],
    );
  }

  /// `true / false`
  String get yes_no_question_label {
    return Intl.message(
      'true / false',
      name: 'yes_no_question_label',
      desc: '',
      args: [],
    );
  }

  /// `short answer`
  String get short_answer_question_label {
    return Intl.message(
      'short answer',
      name: 'short_answer_question_label',
      desc: '',
      args: [],
    );
  }

  /// `correct order`
  String get correct_order_question_label {
    return Intl.message(
      'correct order',
      name: 'correct_order_question_label',
      desc: '',
      args: [],
    );
  }

  /// `multiple choice`
  String get multiple_answer_question_label {
    return Intl.message(
      'multiple choice',
      name: 'multiple_answer_question_label',
      desc: '',
      args: [],
    );
  }

  /// `matching`
  String get matching_question_question_label {
    return Intl.message(
      'matching',
      name: 'matching_question_question_label',
      desc: '',
      args: [],
    );
  }

  /// `take the test`
  String get take_test_label {
    return Intl.message(
      'take the test',
      name: 'take_test_label',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get delete_label {
    return Intl.message(
      'delete',
      name: 'delete_label',
      desc: '',
      args: [],
    );
  }

  /// `enter a new title`
  String get enter_heading_label {
    return Intl.message(
      'enter a new title',
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

  /// `enter a new subject`
  String get enter_subject_label {
    return Intl.message(
      'enter a new subject',
      name: 'enter_subject_label',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get next_label {
    return Intl.message(
      'next',
      name: 'next_label',
      desc: '',
      args: [],
    );
  }

  /// `select one correct answer`
  String get select_one_correct_answer_label {
    return Intl.message(
      'select one correct answer',
      name: 'select_one_correct_answer_label',
      desc: '',
      args: [],
    );
  }

  /// `answer error`
  String get answer_error_label {
    return Intl.message(
      'answer error',
      name: 'answer_error_label',
      desc: '',
      args: [],
    );
  }

  /// `select a correct answer`
  String get select_correct_answer_label {
    return Intl.message(
      'select a correct answer',
      name: 'select_correct_answer_label',
      desc: '',
      args: [],
    );
  }

  /// `true`
  String get yes_label {
    return Intl.message(
      'true',
      name: 'yes_label',
      desc: '',
      args: [],
    );
  }

  /// `false`
  String get no_label {
    return Intl.message(
      'false',
      name: 'no_label',
      desc: '',
      args: [],
    );
  }

  /// `enter a correct answer`
  String get enter_correct_answer_label {
    return Intl.message(
      'enter a correct answer',
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

  /// `field is required`
  String get field_cant_be_empty_label {
    return Intl.message(
      'field is required',
      name: 'field_cant_be_empty_label',
      desc: '',
      args: [],
    );
  }

  /// `place items in the correct order`
  String get place_items_in_the_correct_order_label {
    return Intl.message(
      'place items in the correct order',
      name: 'place_items_in_the_correct_order_label',
      desc: '',
      args: [],
    );
  }

  /// `select all correct answers`
  String get select_all_correct_answers_label {
    return Intl.message(
      'select all correct answers',
      name: 'select_all_correct_answers_label',
      desc: '',
      args: [],
    );
  }

  /// `match all options with correct answers`
  String get match_all_options_with_correct_answers_label {
    return Intl.message(
      'match all options with correct answers',
      name: 'match_all_options_with_correct_answers_label',
      desc: '',
      args: [],
    );
  }

  /// `finish the test`
  String get finish_test_label {
    return Intl.message(
      'finish the test',
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

  /// `the test will be permanently deleted!`
  String get delete_text_warning {
    return Intl.message(
      'the test will be permanently deleted!',
      name: 'delete_text_warning',
      desc: '',
      args: [],
    );
  }

  /// `add new question`
  String get add_question_label {
    return Intl.message(
      'add new question',
      name: 'add_question_label',
      desc: '',
      args: [],
    );
  }

  /// `select type of question`
  String get select_question_type_label {
    return Intl.message(
      'select type of question',
      name: 'select_question_type_label',
      desc: '',
      args: [],
    );
  }

  /// `double tap to delete the question`
  String get use_double_tap_to_delete_label {
    return Intl.message(
      'double tap to delete the question',
      name: 'use_double_tap_to_delete_label',
      desc: '',
      args: [],
    );
  }

  /// `swipe to delete`
  String get swipe_to_delete_label {
    return Intl.message(
      'swipe to delete',
      name: 'swipe_to_delete_label',
      desc: '',
      args: [],
    );
  }

  /// `option deleted`
  String get option_deleted_label {
    return Intl.message(
      'option deleted',
      name: 'option_deleted_label',
      desc: '',
      args: [],
    );
  }

  /// `incorrect option`
  String get incorrect_option_label {
    return Intl.message(
      'incorrect option',
      name: 'incorrect_option_label',
      desc: '',
      args: [],
    );
  }

  /// `correct option`
  String get correct_option_label {
    return Intl.message(
      'correct option',
      name: 'correct_option_label',
      desc: '',
      args: [],
    );
  }

  /// `user's answer`
  String get user_answer {
    return Intl.message(
      'user\'s answer',
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

  /// `the field should be unique`
  String get field_should_be_unique {
    return Intl.message(
      'the field should be unique',
      name: 'field_should_be_unique',
      desc: '',
      args: [],
    );
  }

  /// `leave blank for other answer`
  String get leave_blank_for_other_answer {
    return Intl.message(
      'leave blank for other answer',
      name: 'leave_blank_for_other_answer',
      desc: '',
      args: [],
    );
  }

  /// `quiz should have at least one question!`
  String get quiz_should_have_questions_warning_label {
    return Intl.message(
      'quiz should have at least one question!',
      name: 'quiz_should_have_questions_warning_label',
      desc: '',
      args: [],
    );
  }

  /// `Test not passed`
  String get test_not_completed_label {
    return Intl.message(
      'Test not passed',
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

  /// `continue`
  String get continue_label {
    return Intl.message(
      'continue',
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

  /// `question deleted`
  String get question_deleted_label {
    return Intl.message(
      'question deleted',
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