// lib/providers/classic_quiz_provider.dart

import 'package:flutter/material.dart';
import '../models/question_model.dart';

// NEW: An enum for the new quiz categories
enum ClassicQuizCategory { generalKnowledge, science, history, android, flutter, java, movie, politics, python, sports  }

class ClassicQuizProvider with ChangeNotifier {
  // NEW: Changed from a single list to a map of categories to question lists
  final Map<ClassicQuizCategory, List<Question>> _allClassicQuestions = {
    ClassicQuizCategory.android: [
      Question(
        questionText: 'Which file specifies the layout of an Android app screen?',
        options: ['MainActivity.java', 'AndroidManifest.xml', 'activity_main.xml', 'styles.xml'],
        correctAnswer: 'activity_main.xml',
      ),
      Question(
          questionText:   'Which component is responsible for the UI in Android?',
          options: [  'Activity',   'Service ',   'BroadcastReceiver',   'ContentProvider'],
          correctAnswer:   'Activity'
      ),
      Question(
          questionText:   'Which method is called when an Activity is created?',
          options: [  'onStart()',   'onCreate()',   'onResume()',   'onPause()'],
          correctAnswer:   'onCreate()'
      ),
      Question(
          questionText:   'Which folder stores drawable images in Android?',
          options: [  'res/drawable',   'res/layou',   'res/values',   'res/raw'],
          correctAnswer :   'res/drawable'
      ),
      Question(
          questionText:   'Which file contains essential information about an app?  ',
          options: [  'build.gradle  ',   'AndroidManifest.xml  ',   'activity_main.xml  ',   'strings.xml  '],
          correctAnswer :   'AndroidManifest.xml  '
      ),
      Question(
          questionText:   'Which layout arranges elements in a single column or row?  ',
          options: [  'RelativeLayout  ',   'LinearLayout  ',   'ConstraintLayout  ',   'FrameLayout  '],
          correctAnswer :   'LinearLayout  '
      ),
      Question(
          questionText  :   'Which component is used to run tasks in the background?  ',
          options  : [  'Activity  ',   'Service  ',   'Intent  ',   'BroadcastReceiver  '],
          correctAnswer  :   'Service  '
      ),
      Question(
          questionText  :   'Which is not a type of Android storage?  ',
          options  : [  'Internal Storage  ',   'External Storage  ',   'SQLite Database  ',   'Oracle DB  '],
          correctAnswer  :   'Oracle DB  '
      ),
      Question(
          questionText  :   'Which method is used to start a new Activity?  ',
          options  : [  'startService()  ',   'startActivity()  ',   'onStart()  ',   'startIntent()  '],
          correctAnswer  :   'startActivity()  '
      ),
      Question(
          questionText  :   'Which Android component listens for system-wide messages?  ',
          options : [  'Service  ',   'ContentProvider  ',   'BroadcastReceiver  ',   'Fragment  '],
          correctAnswer :   'BroadcastReceiver  '
      ),
      Question(
          questionText:   'Which XML file is used to define string constants?  ',
          options : [  'styles.xml  ',   'colors.xml  ',   'strings.xml  ',   'dimens.xml  '],
          correctAnswer  :   'strings.xml  '
      ),
      Question(
          questionText :   'Which database is built into Android?  ',
          options  : [  'PostgreSQL  ',   'MongoDB  ',   'SQLite  ',   'MySQL  '],
          correctAnswer  :   'SQLite  '
      ),
    ],
    ClassicQuizCategory.science: [
      Question(
          questionText: 'What is the chemical symbol for water?',
          options: ['O2', 'H2O', 'CO2', 'HO2'],
          correctAnswer: 'H2O'
      ),
      Question(
          questionText: 'Which planet is known as the Red Planet?',
          options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
          correctAnswer: 'Mars'
      ),
      Question(
          questionText: 'What is the speed of light in vacuum?',
          options: ['3 × 10^6 m/s', '3 × 10^8 m/s', '3 × 10^5 m/s', '3 × 10^7 m/s'],
          correctAnswer: '3 × 10^8 m/s'
      ),
      Question(
          questionText: 'Who proposed the theory of relativity?',
          options: ['Isaac Newton', 'Albert Einstein', 'Niels Bohr', 'Galileo Galilei'],
          correctAnswer: 'Albert Einstein'
      ),
      Question(
          questionText: 'What is the powerhouse of the cell?',
          options: ['Nucleus', 'Mitochondria', 'Ribosome', 'Chloroplast'],
          correctAnswer: 'Mitochondria'
      ),
      Question(
          questionText: 'Which gas is most abundant in Earth’s atmosphere?',
          options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
          correctAnswer: 'Nitrogen'
      ),
      Question(
          questionText: 'What is the boiling point of water at sea level?',
          options: ['90°C', '100°C', '120°C', '80°C'],
          correctAnswer: '100°C'
      ),
      Question(
          questionText: 'Which blood cells help in fighting infections?',
          options: ['Red Blood Cells', 'White Blood Cells', 'Platelets', 'Plasma'],
          correctAnswer: 'White Blood Cells'
      ),
      Question(
          questionText: 'What is the hardest natural substance on Earth?',
          options: ['Gold', 'Iron', 'Diamond', 'Quartz'],
          correctAnswer: 'Diamond'
      ),
      Question(
          questionText: 'Which part of the plant conducts photosynthesis?',
          options: ['Roots', 'Stem', 'Leaves', 'Flowers'],
          correctAnswer: 'Leaves'
      ),
      Question(
          questionText: 'What is the unit of electric current?',
          options: ['Watt', 'Volt', 'Ampere', 'Ohm'],
          correctAnswer: 'Ampere'
      ),
      Question(
          questionText: 'Which scientist discovered penicillin?',
          options: ['Louis Pasteur', 'Alexander Fleming', 'Marie Curie', 'Gregor Mendel'],
          correctAnswer: 'Alexander Fleming'
      ),
      Question(
          questionText: 'Which vitamin is produced when human skin is exposed to sunlight?',
          options: ['Vitamin A', 'Vitamin B12', 'Vitamin C', 'Vitamin D'],
          correctAnswer: 'Vitamin D'
      ),
      Question(
          questionText: 'What is the smallest unit of matter?',
          options: ['Molecule', 'Atom', 'Proton', 'Neutron'],
          correctAnswer: 'Atom'
      ),
      Question(
          questionText: 'Which organ in the human body purifies blood?',
          options: ['Heart', 'Lungs', 'Kidney', 'Liver'],
          correctAnswer: 'Kidney'
      ),
    ],
    ClassicQuizCategory.history: [
      Question(
          questionText: 'Who was the first President of the United States?',
          options: ['Thomas Jefferson', 'Abraham Lincoln', 'George Washington', 'John Adams'],
          correctAnswer: 'George Washington'
      ),
      Question(
          questionText: 'In which year did World War II end?',
          options: ['1942', '1945', '1947', '1950'],
          correctAnswer: '1945'
      ),
      Question(
          questionText: 'Who was the first Emperor of China?',
          options: ['Qin Shi Huang', 'Han Wudi', 'Sun Yat-sen', 'Kublai Khan'],
          correctAnswer: 'Qin Shi Huang'
      ),
      Question(
          questionText: 'Which Indian leader launched the Salt March in 1930?',
          options: ['Sardar Patel', 'Jawaharlal Nehru', 'Mahatma Gandhi', 'Subhas Chandra Bose'],
          correctAnswer: 'Mahatma Gandhi'
      ),
      Question(
          questionText: 'Who discovered America in 1492?',
          options: ['Vasco da Gama', 'Christopher Columbus', 'Ferdinand Magellan', 'Marco Polo'],
          correctAnswer: 'Christopher Columbus'
      ),
      Question(
          questionText: 'Which civilization built the pyramids?',
          options: ['Greek', 'Roman', 'Egyptian', 'Mayan'],
          correctAnswer: 'Egyptian'
      ),
      Question(
          questionText: 'Who was the first woman to fly solo across the Atlantic Ocean?',
          options: ['Valentina Tereshkova', 'Amelia Earhart', 'Sally Ride', 'Bessie Coleman'],
          correctAnswer: 'Amelia Earhart'
      ),
      Question(
          questionText: 'The Great Wall of China was primarily built to protect against which group?',
          options: ['Mongols', 'Romans', 'Japanese', 'Huns'],
          correctAnswer: 'Mongols'
      ),
      Question(
          questionText: 'Who was the first Mughal emperor of India?',
          options: ['Akbar', 'Babur', 'Shah Jahan', 'Humayun'],
          correctAnswer: 'Babur'
      ),
      Question(
          questionText: 'Which country was divided into East and West during the Cold War?',
          options: ['France', 'Germany', 'Italy', 'Spain'],
          correctAnswer: 'Germany'
      ),
      Question(
          questionText: 'Who was the British Prime Minister during most of World War II?',
          options: ['Neville Chamberlain', 'Winston Churchill', 'Clement Attlee', 'Harold Macmillan'],
          correctAnswer: 'Winston Churchill'
      ),
      Question(
          questionText: 'Which empire was ruled by Genghis Khan?',
          options: ['Roman Empire', 'Ottoman Empire', 'Mongol Empire', 'Persian Empire'],
          correctAnswer: 'Mongol Empire'
      ),
      Question(
          questionText: 'In which year did India gain independence from British rule?',
          options: ['1945', '1946', '1947', '1950'],
          correctAnswer: '1947'
      ),
      Question(
          questionText: 'Who was the first woman Prime Minister of India?',
          options: ['Sarojini Naidu', 'Pratibha Patil', 'Indira Gandhi', 'Sonia Gandhi'],
          correctAnswer: 'Indira Gandhi'
      ),
      Question(
          questionText: 'Which war was fought between the North and South regions of the United States?',
          options: ['World War I', 'American Civil War', 'War of Independence', 'Vietnam War'],
          correctAnswer: 'American Civil War'
      ),
    ],
    ClassicQuizCategory.generalKnowledge: [
      Question(
          questionText: "Which is the largest continent in the world?",
          options: ["Africa", "Asia", "Europe", "North America"],
          correctAnswer: "Asia"
      ),
      Question(
          questionText: "Who was the first man to step on the moon?",
          options: ["Buzz Aldrin", "Yuri Gagarin", "Neil Armstrong", "Michael Collins"],
          correctAnswer: "Neil Armstrong"
      ),
      Question(
          questionText: "Which is the smallest country in the world by area?",
          options: ["Monaco", "San Marino", "Vatican City", "Malta"],
          correctAnswer: "Vatican City"
      ),
      Question(
          questionText: "What is the capital of Japan?",
          options: ["Seoul", "Beijing", "Tokyo", "Kyoto"],
          correctAnswer: "Tokyo"
      ),
      Question(
          questionText: "Which ocean is the largest?",
          options: ["Indian Ocean", "Atlantic Ocean", "Pacific Ocean", "Arctic Ocean"],
          correctAnswer: "Pacific Ocean"
      ),
      Question(
          questionText: "Who is known as the Father of the Nation in India?",
          options: ["Jawaharlal Nehru", "Subhas Chandra Bose", "Mahatma Gandhi", "Sardar Patel"],
          correctAnswer: "Mahatma Gandhi"
      ),
      Question(
          questionText: "Which planet is known as the 'Morning Star'?",
          options: ["Mars", "Venus", "Jupiter", "Mercury"],
          correctAnswer: "Venus"
      ),
      Question(
          questionText: "What is the currency of the United Kingdom?",
          options: ["Euro", "Dollar", "Pound Sterling", "Franc"],
          correctAnswer: "Pound Sterling"
      ),
      Question(
          questionText: "Which country is known as the 'Land of the Rising Sun'?",
          options: ["China", "India", "Japan", "Thailand"],
          correctAnswer: "Japan"
      ),
      Question(
          questionText: "Which is the longest river in the world?",
          options: ["Amazon", "Yangtze", "Nile", "Ganges"],
          correctAnswer: "Nile"
      ),
      Question(
          questionText: "Which is the national sport of Japan?",
          options: ["Cricket", "Baseball", "Sumo Wrestling", "Karate"],
          correctAnswer: "Sumo Wrestling"
      ),
      Question(
          questionText: "Mount Everest lies on the border of which two countries?",
          options: ["India and China", "India and Nepal", "Nepal and China", "Bhutan and China"],
          correctAnswer: "Nepal and China"
      ),
      Question(
          questionText: "Which organ in the human body is primarily responsible for pumping blood?",
          options: ["Lungs", "Heart", "Kidney", "Liver"],
          correctAnswer: "Heart"
      ),
      Question(
          questionText: "Which festival is known as the 'Festival of Lights' in India?",
          options: ["Holi", "Diwali", "Eid", "Christmas"],
          correctAnswer: "Diwali"
      ),
      Question(
          questionText: "Who invented the telephone?",
          options: ["Alexander Graham Bell", "Thomas Edison", "Nikola Tesla", "Guglielmo Marconi"],
          correctAnswer: "Alexander Graham Bell"
      ),
    ],
    ClassicQuizCategory.flutter: [
      Question(
          questionText: "Which programming language is used to develop Flutter apps?",
          options: ["Java", "Dart", "Kotlin", "Swift"],
          correctAnswer: "Dart"
      ),
      Question(
          questionText: "Which widget is the root of all Flutter apps?",
          options: ["Scaffold", "MaterialApp", "Container", "AppBar"],
          correctAnswer: "MaterialApp"
      ),
      Question(
          questionText: "Which widget is used to create a scrollable list in Flutter?",
          options: ["Column", "ListView", "Row", "Stack"],
          correctAnswer: "ListView"
      ),
      Question(
          questionText: "Which function is the entry point of every Flutter app?",
          options: ["init()", "main()", "start()", "runApp()"],
          correctAnswer: "main()"
      ),
      Question(
          questionText: "Which widget is used for flexible layouts?",
          options: ["Expanded", "Flexible", "SizedBox", "Both Expanded and Flexible"],
          correctAnswer: "Both Expanded and Flexible"
      ),
      Question(
          questionText: "Which state management approach is built into Flutter?",
          options: ["Provider", "Redux", "setState()", "Bloc"],
          correctAnswer: "setState()"
      ),
      Question(
          questionText: "Which widget is used to add padding around another widget?",
          options: ["SizedBox", "Container", "Padding", "Align"],
          correctAnswer: "Padding"
      ),
      Question(
          questionText: "Which widget is used for creating tab navigation?",
          options: ["TabBar", "Drawer", "BottomNavigationBar", "Navigator"],
          correctAnswer: "TabBar"
      ),
      Question(
          questionText: "Which widget is used to display dynamic data lists?",
          options: ["Column", "ListView.builder", "Row", "Stack"],
          correctAnswer: "ListView.builder"
      ),
      Question(
          questionText: "Which Flutter widget is used for material design visual layout structure?",
          options: ["Container", "Scaffold", "Card", "AppBar"],
          correctAnswer: "Scaffold"
      ),
      Question(
          questionText: "Which widget helps in navigating between screens?",
          options: ["Navigator", "Scaffold", "AppBar", "MaterialApp"],
          correctAnswer: "Navigator"
      ),
      Question(
          questionText: "Which method is used to rebuild a widget with new state?",
          options: ["setData()", "setState()", "update()", "refresh()"],
          correctAnswer: "setState()"
      ),
      Question(
          questionText: "Which widget is used for creating card-like UI?",
          options: ["Scaffold", "Card", "Container", "Stack"],
          correctAnswer: "Card"
      ),
      Question(
          questionText: "Which Flutter widget is used to align child widgets?",
          options: ["Align", "Center", "Positioned", "All of the above"],
          correctAnswer: "All of the above"
      ),
      Question(
          questionText: "Which widget is commonly used for infinite scrolling lists?",
          options: ["ListView", "GridView", "PageView", "CustomScrollView"],
          correctAnswer: "ListView"
      ),
      Question(
          questionText: "Which widget is used to create grid layouts in Flutter?",
          options: ["ListView", "Row", "GridView", "Stack"],
          correctAnswer: "GridView"
      ),
      Question(
          questionText: "Which widget allows us to overlay widgets on top of each other?",
          options: ["Stack", "Column", "Row", "Scaffold"],
          correctAnswer: "Stack"
      ),
      Question(
          questionText: "Which widget is used for handling user gestures?",
          options: ["GestureDetector", "InkWell", "Both GestureDetector and InkWell", "Listener"],
          correctAnswer: "Both GestureDetector and InkWell"
      ),
      Question(
          questionText: "Which function is used to start the Flutter application?",
          options: ["runApp()", "startApp()", "main()", "initApp()"],
          correctAnswer: "runApp()"
      ),
      Question(
          questionText: "Which widget can hold only one child?",
          options: ["Container", "Stack", "Row", "Column"],
          correctAnswer: "Container"
      ),
      Question(
          questionText: "Which widget is used for adding themes to an app?",
          options: ["Scaffold", "MaterialApp", "ThemeData", "AppBar"],
          correctAnswer: "MaterialApp"
      ),
      Question(
          questionText: "Which Flutter widget is used to make text scrollable?",
          options: ["ListView", "SingleChildScrollView", "ScrollableText", "Expanded"],
          correctAnswer: "SingleChildScrollView"
      ),
      Question(
          questionText: "Which function is called when the stateful widget is inserted in the widget tree?",
          options: ["initState()", "build()", "dispose()", "createState()"],
          correctAnswer: "initState()"
      ),
      Question(
          questionText: "Which widget is used to show a circular loading indicator?",
          options: ["ProgressBar", "CircularProgressIndicator", "Loader", "ActivityIndicator"],
          correctAnswer: "CircularProgressIndicator"
      ),
      Question(
          questionText: "Which Flutter command is used to build release APK?",
          options: ["flutter build apk", "flutter run", "flutter install", "flutter create apk"],
          correctAnswer: "flutter build apk"
      ),
      Question(
          questionText: "Which function is called when a state object is permanently removed?",
          options: ["initState()", "dispose()", "deactivate()", "build()"],
          correctAnswer: "dispose()"
      ),
      Question(
          questionText: "Which widget is used for creating responsive designs?",
          options: ["MediaQuery", "LayoutBuilder", "Expanded", "All of the above"],
          correctAnswer: "All of the above"
      ),
      Question(
          questionText: "Which Flutter widget is used to create buttons with ripple effects?",
          options: ["FlatButton", "ElevatedButton", "InkWell", "All of the above"],
          correctAnswer: "All of the above"
      ),
      Question(
          questionText: "Which widget is used for horizontal or vertical scrolling?",
          options: ["ScrollView", "ListView", "PageView", "CustomScrollView"],
          correctAnswer: "ScrollView"
      ),
      Question(
          questionText: "Which Flutter widget is used to manage form input validation?",
          options: ["TextField", "Form", "TextFormField", "Both Form and TextFormField"],
          correctAnswer: "Both Form and TextFormField"
      ),
    ],
    ClassicQuizCategory.movie: [
      Question(
          questionText: "Which movie won the first Academy Award for Best Picture?",
          options: ["Wings", "Gone with the Wind", "Casablanca", "The Jazz Singer"],
          correctAnswer: "Wings"
      ),
      Question(
          questionText: "Who directed the movie 'Jurassic Park'?",
          options: ["James Cameron", "Steven Spielberg", "George Lucas", "Ridley Scott"],
          correctAnswer: "Steven Spielberg"
      ),
      Question(
          questionText: "Which actor played Jack Dawson in 'Titanic'?",
          options: ["Brad Pitt", "Leonardo DiCaprio", "Johnny Depp", "Matt Damon"],
          correctAnswer: "Leonardo DiCaprio"
      ),
      Question(
          questionText: "Which movie features the quote, 'May the Force be with you'?",
          options: ["The Matrix", "Star Wars", "Avatar", "Lord of the Rings"],
          correctAnswer: "Star Wars"
      ),
      Question(
          questionText: "Which animated movie features a character named Woody?",
          options: ["Shrek", "Toy Story", "Frozen", "Finding Nemo"],
          correctAnswer: "Toy Story"
      ),
      Question(
          questionText: "Who won the Academy Award for Best Actress for 'La La Land'?",
          options: ["Natalie Portman", "Emma Stone", "Jennifer Lawrence", "Anne Hathaway"],
          correctAnswer: "Emma Stone"
      ),
      Question(
          questionText: "Which movie is about a clownfish searching for his son?",
          options: ["Shark Tale", "Finding Nemo", "The Little Mermaid", "Moana"],
          correctAnswer: "Finding Nemo"
      ),
      Question(
          questionText: "Which director is famous for the 'Dark Knight Trilogy'?",
          options: ["Martin Scorsese", "Christopher Nolan", "Quentin Tarantino", "Zack Snyder"],
          correctAnswer: "Christopher Nolan"
      ),
      Question(
          questionText: "Which 1994 movie features a character named Forrest Gump?",
          options: ["Good Will Hunting", "Forrest Gump", "Cast Away", "Rain Man"],
          correctAnswer: "Forrest Gump"
      ),
      Question(
          questionText: "Who played Iron Man in the Marvel Cinematic Universe?",
          options: ["Chris Evans", "Robert Downey Jr.", "Mark Ruffalo", "Chris Hemsworth"],
          correctAnswer: "Robert Downey Jr."
      ),
      Question(
          questionText: "Which movie franchise features the character Captain Jack Sparrow?",
          options: ["Harry Potter", "Pirates of the Caribbean", "Lord of the Rings", "The Hobbit"],
          correctAnswer: "Pirates of the Caribbean"
      ),
      Question(
          questionText: "Which is the highest-grossing film of all time (as of 2023)?",
          options: ["Titanic", "Avatar", "Avengers: Endgame", "The Lion King"],
          correctAnswer: "Avatar"
      ),
      Question(
          questionText: "Who directed the movie 'Inception'?",
          options: ["Christopher Nolan", "James Cameron", "Steven Spielberg", "Peter Jackson"],
          correctAnswer: "Christopher Nolan"
      ),
      Question(
          questionText: "Which Pixar film tells the story of emotions inside a young girl's mind?",
          options: ["Up", "Soul", "Inside Out", "Coco"],
          correctAnswer: "Inside Out"
      ),
      Question(
          questionText: "Which Indian movie became the first to win an Oscar for Best Original Song ('Naatu Naatu')?",
          options: ["Lagaan", "RRR", "Slumdog Millionaire", "Baahubali"],
          correctAnswer: "RRR"
      ),
    ],
    ClassicQuizCategory.java: [
      Question(
          questionText: "Which of the following is not a Java keyword?",
          options: ["static", "Boolean", "volatile", "synchronized"],
          correctAnswer: "Boolean"
      ),
      Question(
          questionText: "Which method is the entry point of a Java program?",
          options: ["start()", "run()", "main()", "init()"],
          correctAnswer: "main()"
      ),
      Question(
          questionText: "Which operator is used to compare two objects in Java?",
          options: ["==", "equals()", "compare()", "==="],
          correctAnswer: "equals()"
      ),
      Question(
          questionText: "Which package contains the Scanner class?",
          options: ["java.util", "java.io", "java.net", "java.sql"],
          correctAnswer: "java.util"
      ),
      Question(
          questionText: "Which keyword is used to inherit a class in Java?",
          options: ["this", "base", "extends", "super"],
          correctAnswer: "extends"
      ),
      Question(
          questionText: "Which collection class allows duplicate elements?",
          options: ["Set", "Map", "List", "HashSet"],
          correctAnswer: "List"
      ),
      Question(
          questionText: "Which access modifier makes a member accessible only within the same package?",
          options: ["private", "public", "protected", "default (no modifier)"],
          correctAnswer: "default (no modifier)"
      ),
      Question(
          questionText: "Which of these is used for multiple inheritance in Java?",
          options: ["abstract classes", "interfaces", "packages", "enums"],
          correctAnswer: "interfaces"
      ),
      Question(
          questionText: "Which method in Object class returns the runtime class of an object?",
          options: ["getName()", "getClass()", "getType()", "classOf()"],
          correctAnswer: "getClass()"
      ),
      Question(
          questionText: "Which keyword is used to prevent a variable from being changed?",
          options: ["final", "const", "static", "immutable"],
          correctAnswer: "final"
      ),
      Question(
          questionText: "Which class is used to handle files in Java?",
          options: ["FileInputStream", "File", "Scanner", "Reader"],
          correctAnswer: "File"
      ),
      Question(
          questionText: "Which exception is thrown when dividing by zero?",
          options: ["NullPointerException", "ArithmeticException", "NumberFormatException", "IllegalArgumentException"],
          correctAnswer: "ArithmeticException"
      ),
      Question(
          questionText: "Which of the following is true about abstract classes?",
          options: ["They cannot have constructors", "They can contain both abstract and concrete methods", "They must only contain abstract methods", "They cannot extend other classes"],
          correctAnswer: "They can contain both abstract and concrete methods"
      ),
      Question(
          questionText: "Which thread method is used to pause a thread?",
          options: ["wait()", "pause()", "sleep()", "stop()"],
          correctAnswer: "sleep()"
      ),
      Question(
          questionText: "Which keyword is used to call the parent class constructor?",
          options: ["super", "this", "extends", "parent"],
          correctAnswer: "super"
      ),
      Question(
          questionText: "Which collection guarantees natural ordering?",
          options: ["HashSet", "TreeSet", "LinkedList", "ArrayList"],
          correctAnswer: "TreeSet"
      ),
      Question(
          questionText: "Which interface is implemented by all collection classes?",
          options: ["Collection", "Iterable", "Comparator", "Serializable"],
          correctAnswer: "Iterable"
      ),
      Question(
          questionText: "Which of the following is true about constructors in Java?",
          options: ["They can return values", "They cannot be overloaded", "They must have the same name as the class", "They must be declared static"],
          correctAnswer: "They must have the same name as the class"
      ),
      Question(
          questionText: "Which of the following cannot be overridden?",
          options: ["abstract method", "final method", "static method", "Both final and static"],
          correctAnswer: "Both final and static"
      ),
      Question(
          questionText: "Which stream is used for character input in Java?",
          options: ["InputStream", "Reader", "Scanner", "File"],
          correctAnswer: "Reader"
      ),
      Question(
          questionText: "Which method is automatically called when an object is garbage collected?",
          options: ["delete()", "finalize()", "dispose()", "destroy()"],
          correctAnswer: "finalize()"
      ),
      Question(
          questionText: "Which of the following is a wrapper class in Java?",
          options: ["int", "Integer", "char", "float"],
          correctAnswer: "Integer"
      ),
      Question(
          questionText: "Which keyword is used to handle exceptions in Java?",
          options: ["catch", "try", "throw", "All of the above"],
          correctAnswer: "All of the above"
      ),
      Question(
          questionText: "Which type of class cannot be instantiated?",
          options: ["abstract class", "inner class", "subclass", "final class"],
          correctAnswer: "abstract class"
      ),
      Question(
          questionText: "Which keyword is used to create a subclass object?",
          options: ["super", "extends", "new", "class"],
          correctAnswer: "new"
      ),
      Question(
          questionText: "Which Java keyword prevents inheritance?",
          options: ["final", "static", "sealed", "const"],
          correctAnswer: "final"
      ),
      Question(
          questionText: "Which method is used to start a thread in Java?",
          options: ["init()", "run()", "start()", "execute()"],
          correctAnswer: "start()"
      ),
      Question(
          questionText: "Which class provides methods for manipulating strings?",
          options: ["StringBuffer", "StringBuilder", "String", "All of the above"],
          correctAnswer: "All of the above"
      ),
      Question(
          questionText: "Which Java collection class allows key-value pairs?",
          options: ["Set", "List", "Map", "Queue"],
          correctAnswer: "Map"
      ),
      Question(
          questionText: "Which loop is guaranteed to execute at least once?",
          options: ["for", "while", "do-while", "enhanced for"],
          correctAnswer: "do-while"
      ),
    ],
    ClassicQuizCategory.python: [
      Question(
          questionText: "Which of the following is not a valid Python data type?",
          options: ["list", "tuple", "dict", "array"],
          correctAnswer: "array"
      ),
      Question(
          questionText: "Which keyword is used to define a function in Python?",
          options: ["function", "def", "fun", "lambda"],
          correctAnswer: "def"
      ),
      Question(
          questionText: "What is the output of type([])?",
          options: ["list", "<class 'list'>", "[]", "array"],
          correctAnswer: "<class 'list'>"
      ),
      Question(
          questionText: "Which operator is used for floor division in Python?",
          options: ["/", "//", "%", "**"],
          correctAnswer: "//"
      ),
      Question(
          questionText: "Which keyword is used for exception handling in Python?",
          options: ["try", "catch", "throw", "except"],
          correctAnswer: "except"
      ),
      Question(
          questionText: "Which built-in function returns the length of an object?",
          options: ["size()", "count()", "length()", "len()"],
          correctAnswer: "len()"
      ),
      Question(
          questionText: "What is the default return value of a function with no return statement?",
          options: ["0", "None", "False", "Null"],
          correctAnswer: "None"
      ),
      Question(
          questionText: "Which of the following is immutable in Python?",
          options: ["list", "set", "tuple", "dict"],
          correctAnswer: "tuple"
      ),
      Question(
          questionText: "Which function converts a string into a list of words?",
          options: ["split()", "strip()", "join()", "partition()"],
          correctAnswer: "split()"
      ),
      Question(
          questionText: "Which statement is used to define an anonymous function?",
          options: ["def", "lambda", "fun", "inline"],
          correctAnswer: "lambda"
      ),
      Question(
          questionText: "Which operator is used to check identity in Python?",
          options: ["==", "is", "in", "==="],
          correctAnswer: "is"
      ),
      Question(
          questionText: "Which function is used to get user input in Python 3?",
          options: ["raw_input()", "scan()", "input()", "read()"],
          correctAnswer: "input()"
      ),
      Question(
          questionText: "Which module in Python supports regular expressions?",
          options: ["regex", "pyregex", "re", "regexp"],
          correctAnswer: "re"
      ),
      Question(
          questionText: "Which keyword is used to define a class in Python?",
          options: ["define", "class", "object", "struct"],
          correctAnswer: "class"
      ),
      Question(
          questionText: "Which statement is used to handle multiple exceptions?",
          options: ["except (Error1, Error2):", "except Error1 and Error2:", "catch Error1, Error2:", "handle Error1, Error2:"],
          correctAnswer: "except (Error1, Error2):"
      ),
      Question(
          questionText: "Which keyword is used to import modules in Python?",
          options: ["package", "include", "import", "using"],
          correctAnswer: "import"
      ),
      Question(
          questionText: "Which method is called automatically when an object is created?",
          options: ["__create__()", "__init__()", "__start__()", "__constructor__()"],
          correctAnswer: "__init__()"
      ),
      Question(
          questionText: "Which operator is used for exponentiation in Python?",
          options: ["^", "**", "exp", "pow"],
          correctAnswer: "**"
      ),
      Question(
          questionText: "Which of the following is used to define a block of code in Python?",
          options: ["Braces Question()", "Parentheses ()", "Indentation", "Semicolon"],
          correctAnswer: "Indentation"
      ),
      Question(
          questionText: "Which of the following is a Python tuple?",
          options: ["[1,2,3]", "Question(1,2,3)", "(1,2,3)", "<1,2,3>"],
          correctAnswer: "(1,2,3)"
      ),
      Question(
          questionText: "Which method removes an item from a list?",
          options: ["delete()", "remove()", "pop()", "Both remove() and pop()"],
          correctAnswer: "Both remove() and pop()"
      ),
      Question(
          questionText: "Which of the following is not a Python keyword?",
          options: ["pass", "eval", "assert", "raise"],
          correctAnswer: "eval"
      ),
      Question(
          questionText: "Which statement is used to skip an iteration in a loop?",
          options: ["stop", "skip", "continue", "break"],
          correctAnswer: "continue"
      ),
      Question(
          questionText: "Which data type is returned by input() in Python 3?",
          options: ["int", "string", "float", "depends on input"],
          correctAnswer: "string"
      ),
      Question(
          questionText: "Which function is used to read a file line by line?",
          options: ["read()", "readline()", "readlines()", "scan()"],
          correctAnswer: "readline()"
      ),
      Question(
          questionText: "Which of the following is a Python dictionary?",
          options: ["Question(1: 'one', 2: 'two')", "[1, 'one', 2, 'two']", "(1, 'one', 2, 'two')", "Question(1,2,3,4)"],
          correctAnswer: "Question(1: 'one', 2: 'two')"
      ),
      Question(
          questionText: "Which Python function returns the absolute value?",
          options: ["fabs()", "abs()", "absolute()", "math.abs()"],
          correctAnswer: "abs()"
      ),
      Question(
          questionText: "Which keyword is used for defining inheritance in Python?",
          options: ["extends", "inherits", "super", "class Child(Parent)"],
          correctAnswer: "class Child(Parent)"
      ),
      Question(
          questionText: "Which method adds an element at the end of a list?",
          options: ["push()", "add()", "append()", "insert()"],
          correctAnswer: "append()"
      ),
      Question(
          questionText: "Which operator is used for membership testing?",
          options: ["==", "in", "is", "has"],
          correctAnswer: "in"
      ),
    ],
    ClassicQuizCategory.politics: [
      Question(
          questionText: "Who is known as the Father of the Indian Constitution?",
          options: ["Mahatma Gandhi", "B. R. Ambedkar", "Jawaharlal Nehru", "Sardar Patel"],
          correctAnswer: "B. R. Ambedkar"
      ),
      Question(
          questionText: "Which is the highest law-making body in India?",
          options: ["Lok Sabha", "Rajya Sabha", "Parliament", "Supreme Court"],
          correctAnswer: "Parliament"
      ),
      Question(
          questionText: "Who was the first Prime Minister of India?",
          options: ["Mahatma Gandhi", "Sardar Patel", "Jawaharlal Nehru", "Rajendra Prasad"],
          correctAnswer: "Jawaharlal Nehru"
      ),
      Question(
          questionText: "Which political system does the United States follow?",
          options: ["Monarchy", "Dictatorship", "Federal Presidential Republic", "Parliamentary Democracy"],
          correctAnswer: "Federal Presidential Republic"
      ),
      Question(
          questionText: "Which Article of the Indian Constitution gives the right to freedom of speech and expression?",
          options: ["Article 14", "Article 19", "Article 21", "Article 32"],
          correctAnswer: "Article 19"
      ),
      Question(
          questionText: "Who appoints the Chief Justice of India?",
          options: ["Prime Minister", "President", "Lok Sabha", "Rajya Sabha"],
          correctAnswer: "President"
      ),
      Question(
          questionText: "Which body conducts elections in India?",
          options: ["Supreme Court", "Election Commission of India", "Parliament", "Lok Sabha"],
          correctAnswer: "Election Commission of India"
      ),
      Question(
          questionText: "Who is the head of the state in India?",
          options: ["Prime Minister", "President", "Chief Justice", "Governor"],
          correctAnswer: "President"
      ),
      Question(
          questionText: "What is the minimum age to become the Prime Minister of India?",
          options: ["18 years", "21 years", "25 years", "35 years"],
          correctAnswer: "25 years"
      ),
      Question(
          questionText: "Which political ideology advocates for classless and stateless society?",
          options: ["Liberalism", "Socialism", "Communism", "Capitalism"],
          correctAnswer: "Communism"
      ),
      Question(
          questionText: "In which year did India adopt its Constitution?",
          options: ["1947", "1949", "1950", "1952"],
          correctAnswer: "1950"
      ),
      Question(
          questionText: "What type of government exists in the United Kingdom?",
          options: ["Presidential Republic", "Absolute Monarchy", "Constitutional Monarchy", "Dictatorship"],
          correctAnswer: "Constitutional Monarchy"
      ),
      Question(
          questionText: "Which political thinker is associated with the concept of the 'Social Contract'?",
          options: ["Karl Marx", "John Locke", "Jean-Jacques Rousseau", "Thomas Hobbes"],
          correctAnswer: "Jean-Jacques Rousseau"
      ),
      Question(
          questionText: "Which Indian leader gave the slogan 'Quit India'?",
          options: ["Subhas Chandra Bose", "Mahatma Gandhi", "Jawaharlal Nehru", "Bhagat Singh"],
          correctAnswer: "Mahatma Gandhi"
      ),
      Question(
          questionText: "Which is the upper house of the Indian Parliament?",
          options: ["Lok Sabha", "Rajya Sabha", "Legislative Assembly", "Supreme Court"],
          correctAnswer: "Rajya Sabha"
      ),
    ],
    ClassicQuizCategory.sports: [
      Question(
          questionText: "Which country won the FIFA World Cup in 2018?",
          options: ["Brazil", "Germany", "France", "Argentina"],
          correctAnswer: "France"
      ),
      Question(
          questionText: "Who has won the most Grand Slam tennis titles (men’s singles) as of 2023?",
          options: ["Roger Federer", "Rafael Nadal", "Novak Djokovic", "Pete Sampras"],
          correctAnswer: "Novak Djokovic"
      ),
      Question(
          questionText: "In which sport is the term 'LBW' used?",
          options: ["Football", "Hockey", "Cricket", "Tennis"],
          correctAnswer: "Cricket"
      ),
      Question(
          questionText: "Which country hosted the 2016 Summer Olympics?",
          options: ["China", "Brazil", "UK", "Japan"],
          correctAnswer: "Brazil"
      ),
      Question(
          questionText: "Who is known as the 'King of Football'?",
          options: ["Cristiano Ronaldo", "Lionel Messi", "Pele", "Diego Maradona"],
          correctAnswer: "Pele"
      ),
      Question(
          questionText: "Which cricketer is called the 'God of Cricket'?",
          options: ["Virat Kohli", "Sachin Tendulkar", "Brian Lara", "Ricky Ponting"],
          correctAnswer: "Sachin Tendulkar"
      ),
      Question(
          questionText: "Which NBA player is famously known as 'King James'?",
          options: ["Kobe Bryant", "LeBron James", "Michael Jordan", "Stephen Curry"],
          correctAnswer: "LeBron James"
      ),
      Question(
          questionText: "In which sport is the Ryder Cup contested?",
          options: ["Tennis", "Golf", "Cricket", "Baseball"],
          correctAnswer: "Golf"
      ),
      Question(
          questionText: "Which country has won the most Olympic gold medals in hockey?",
          options: ["Australia", "India", "Germany", "Netherlands"],
          correctAnswer: "India"
      ),
      Question(
          questionText: "How many players are there in a football (soccer) team on the field?",
          options: ["9", "10", "11", "12"],
          correctAnswer: "11"
      ),
      Question(
          questionText: "Who holds the record for the fastest 100m sprint?",
          options: ["Usain Bolt", "Carl Lewis", "Yohan Blake", "Tyson Gay"],
          correctAnswer: "Usain Bolt"
      ),
      Question(
          questionText: "Which country won the ICC Cricket World Cup in 2011?",
          options: ["India", "Australia", "Sri Lanka", "England"],
          correctAnswer: "India"
      ),
      Question(
          questionText: "What is the national sport of Canada?",
          options: ["Ice Hockey", "Lacrosse", "Baseball", "Basketball"],
          correctAnswer: "Lacrosse"
      ),
      Question(
          questionText: "Who won the Ballon d’Or in 2022?",
          options: ["Lionel Messi", "Robert Lewandowski", "Karim Benzema", "Kylian Mbappé"],
          correctAnswer: "Karim Benzema"
      ),
      Question(
          questionText: "Which sport uses terms like 'love', 'deuce', and 'ace'?",
          options: ["Badminton", "Tennis", "Volleyball", "Squash"],
          correctAnswer: "Tennis"
      ),
    ],
  };

  ClassicQuizCategory? _selectedCategory;
  List<Question> _currentQuizQuestions = [];
  int _currentQuestionIndex = 0;
  bool _quizCompleted = false;
  int _score = 0;
  final Map<int, String> _userAnswers = {};

  Color? selectedCategoryColor;

  ClassicQuizCategory? get selectedCategory => _selectedCategory;
  int get currentQuestionIndex => _currentQuestionIndex;
  bool get quizCompleted => _quizCompleted;
  int get totalQuestions => _currentQuizQuestions.length;
  Question get currentQuestion => _currentQuizQuestions.isNotEmpty ? _currentQuizQuestions[_currentQuestionIndex] : Question(questionText: '', options: [], correctAnswer: '');
  Map<int, String> get userAnswers => _userAnswers;
  List<Question> get questions => _currentQuizQuestions;
  int get score => _score;

  void selectCategory(ClassicQuizCategory category, Color color) {
    _selectedCategory = category;
    selectedCategoryColor = color;
    _currentQuizQuestions = List.from(_allClassicQuestions[category]!);
    _currentQuizQuestions.shuffle();
    resetQuiz();
    notifyListeners();
  }

  void selectAnswer(String answer) {
    _userAnswers[_currentQuestionIndex] = answer;
    notifyListeners();
  }

  void submitAndMoveNext() {
    if (_userAnswers.containsKey(_currentQuestionIndex) &&
        _userAnswers[_currentQuestionIndex] == _currentQuizQuestions[_currentQuestionIndex].correctAnswer) {
      _score++;
    }

    if (_currentQuestionIndex < _currentQuizQuestions.length - 1) {
      _currentQuestionIndex++;
    } else {
      _quizCompleted = true;
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _quizCompleted = false;
    _userAnswers.clear();
  }
}