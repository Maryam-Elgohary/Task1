import 'dart:io';
import 'dart:math';

// A list of words to choose from
const fruits = [
  'apple',
  'banana',
  'orange',
  'pear',
  'grape',
  'melon',
  'cherry',
  'mango',
  'lemon',
  'lime'
];

// The number of guesses allowed
const maxGuesses = 10;

void main() {
  // Create a random number generator
  var rng = Random();

  // Pick a random word from the list
  var word = fruits[rng.nextInt(fruits.length)];

  // Create a list of underscores with the same length as the word
  var hiddenWord = List.filled(word.length, '_');

  // Create a set of guessed letters
  var guessedLetters = <String>{};

  // Create a variable to store the number of guesses left
  var guessesLeft = maxGuesses;

  // Print a welcome message
  print('Welcome to Hangman!');

  // Start the game loop
  while (true) {
    // Print the hidden word and the guesses left
    print('\n${hiddenWord.join(' ')}');
    print('Guesses left: $guessesLeft');

    // Prompt the user for a letter
    print('Enter a letter:');
    var input = stdin.readLineSync();

    // Check if the input is valid
    if (input == null ||
        input.length != 1 ||
        !input.contains(RegExp('[a-z]'))) {
      print('Invalid input. Please enter a single lowercase letter.');
      continue;
    }

    // Check if the letter has already been guessed
    if (guessedLetters.contains(input)) {
      print('You have already guessed that letter.');
      continue;
    }

    // Add the letter to the guessed letters set
    guessedLetters.add(input);

    // Check if the letter is in the word
    if (word.contains(input)) {
      print('Good guess!');

      // Update the hidden word with the correct letter
      for (var i = 0; i < word.length; i++) {
        if (word[i] == input) {
          hiddenWord[i] = input;
        }
      }

      // Check if the user has won
      if (!hiddenWord.contains('_')) {
        print('\n${hiddenWord.join(' ')}');
        print('You win!');
        break;
      }
    } else {
      print('Sorry, that letter is not in the word.');

      // Decrease the guesses left by one
      guessesLeft--;

      // Check if the user has lost
      if (guessesLeft == 0) {
        print('You lose!');
        print('The word was $word.');
        break;
      }
    }
  }
}
