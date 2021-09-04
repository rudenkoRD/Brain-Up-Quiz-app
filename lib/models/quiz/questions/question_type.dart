import 'package:schoollearning/generated/l10n.dart';

enum QuestionType {
  TRUE_FALSE,
  MULTIPLE_CHOICE,
  SINGLE_CHOICE,
  MATCHING,
  SHORT_ANSWER,
  ORDERING,
}

extension QuestionTypeExtension on QuestionType {
  String name(context) {
    switch (this) {
      case QuestionType.MATCHING:
        return S.of(context)
            .matching_question_question_label;
      case QuestionType.TRUE_FALSE :
        return S.of(context)
            .yes_no_question_label;
      case QuestionType.MULTIPLE_CHOICE :
        return S.of(context)
            .multiple_answer_question_label;
      case QuestionType.SINGLE_CHOICE :
        return S.of(context)
            .single_choice_question_label;
      case QuestionType.SHORT_ANSWER :
        return S.of(context)
            .short_answer_question_label;
      case QuestionType.ORDERING :
        return S.of(context)
            .correct_order_question_label;
      default: return 'error';
    }
  }

  int get typeId {
    switch (this) {
      case QuestionType.TRUE_FALSE :
        return 0;
      case QuestionType.MULTIPLE_CHOICE :
        return 1;
      case QuestionType.SINGLE_CHOICE :
        return 2;
      case QuestionType.MATCHING:
        return 3;
      case QuestionType.SHORT_ANSWER :
        return 4;
      case QuestionType.ORDERING :
        return 5;
      default: return -1;
    }
  }
}
