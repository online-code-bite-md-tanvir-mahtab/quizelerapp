import 'Quize.dart';

class QuizeBrain {
  // Questions for Colour Prediction Quiz
  List<Quize> _colourQuiz = [
    Quize('The color red is associated with danger.', true),
    Quize('Blue is the warmest color.', false),
    Quize('Green symbolizes nature and renewal.', true),
    Quize('Purple is the universal color of love.', false),
    Quize('Yellow often represents happiness and energy.', true),
  ];

  // Questions for Wildlife Quiz
  List<Quize> _wildlifeQuiz = [
    Quize('The cheetah is the fastest land animal.', true),
    Quize('Penguins can fly.', false),
    Quize('An elephant is the largest land mammal.', true),
    Quize('Koalas are native to Africa.', false),
    Quize('The blue whale is the largest animal ever known to exist.', true),
  ];

  // Questions for Math Quiz
  List<Quize> _mathQuiz = [
    Quize('The sum of angles in a triangle is 180 degrees.', true),
    Quize('The square root of 81 is 7.', false),
    Quize('Pi is approximately equal to 3.14.', true),
    Quize('The product of 9 and 9 is 81.', true),
    Quize('In a right triangle, a^2 + b^2 = c^3.', false),
  ];

  // Questions for Word Check Quiz
  List<Quize> _wordQuiz = [
    Quize('The word "apple" is a noun.', true),
    Quize('The word "run" can be used as a verb.', true),
    Quize('The word "blue" is an adverb.', false),
    Quize('The plural of "mouse" is "mice".', true),
    Quize('The word "quickly" is an adjective.', false),
  ];

  // Method to get questions for a specific quiz section
  List<Quize> getQuizzes(String section) {
    switch (section) {
      case 'Colour Prediction':
        return _colourQuiz;
      case 'Wildlife':
        return _wildlifeQuiz;
      case 'Math':
        return _mathQuiz;
      case 'Word Check':
        return _wordQuiz;
      default:
        return [];
    }
  }

  // Method to get a specific question for a section
  String getTheQuestion(String section, int questionNumber) {
    return getQuizzes(section)[questionNumber].mQuize;
  }

  // Method to get the answer for a specific question in a section
  bool getTheAnswer(String section, int questionNumber) {
    return getQuizzes(section)[questionNumber].mAnswer;
  }
}
