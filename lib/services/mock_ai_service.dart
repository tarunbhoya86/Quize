// lib/services/mock_ai_service.dart

import 'dart:math';

enum AiChallengeCategory {
  android, flutter, java, movie, php, politics, sports, python, science,
}

class MockAiService {
  final Map<String, String> _knowledgeBase = {
    'what is flutter?': 'Flutter is an open-source UI software development kit created by Google. It is used to develop cross-platform applications for Android, iOS, Linux, macOS, Windows, Google Fuchsia, and the web from a single codebase.',
    'who made this app?': 'This app was built as a demonstration of Flutter capabilities, integrating state management with Provider and various UI elements.',
    'what is dart?': 'Dart is a client-optimized programming language for apps on multiple platforms. It is developed by Google and is used to build mobile, desktop, server, and web applications.',
    'how does provider work?': 'Provider is a wrapper around InheritedWidget to make them easier to use and more reusable. It simplifies state management by allowing you to provide a value deep down in the widget tree and allowing any descendant to access it.',
    'what is the capital of france?': 'The capital of France is Paris. You can find this in the General Knowledge quiz!',
  };

  final Map<AiChallengeCategory, List<Map<String, dynamic>>> _aiQuizQuestions = {
    AiChallengeCategory.android: [
      {
        'question': 'What are the main components of an Android application?',
        'keywords': ['activity', 'service', 'broadcast receiver', 'content provider', 'application']
      },
      {
        'question': 'Explain the Android Activity Lifecycle.',
        'keywords': ['oncreate', 'onstart', 'onresume', 'onpause', 'onstop', 'ondestroy']
      },
      {
        'question': 'What is the purpose of an Intent?',
        'keywords': ['communication', 'component', 'start activity', 'service', 'data passing']
      },
      {
        'question': 'What is the difference between a `FrameLayout` and a `LinearLayout`?',
        'keywords': ['layout', 'ui design', 'single child', 'horizontal', 'vertical', 'views']
      },
      {
        'question': 'What is a Fragment and why is it used?',
        'keywords': ['modular UI', 'reusability', 'activity', 'tablet layout', 'lifecycle']
      },
      {
        'question': 'How does a `RecyclerView` work?',
        'keywords': ['list', 'efficiency', 'viewholder', 'adapter', 'scrolling', 'performance']
      },
      {
        'question': 'What is Gradle and what is its role in Android development?',
        'keywords': ['build system', 'dependency management', 'automation', 'plugin', 'script']
      },
      {
        'question': 'How do you handle background tasks in Android?',
        'keywords': ['thread', 'asynctask', 'coroutine', 'service', 'workmanager']
      },
      {
        'question': 'What is the purpose of the `AndroidManifest.xml` file?',
        'keywords': ['manifest', 'permissions', 'components', 'metadata', 'application configuration']
      },
      {
        'question': 'How do you persist data in Android?',
        'keywords': ['sharedpreferences', 'sqlite', 'room database', 'file storage', 'data storage']
      }
    ],
    AiChallengeCategory.flutter: [
      {
        'question': 'Explain the concept of "Hot Reload" in Flutter.',
        'keywords': ['instant changes', 'code modification', 'UI', 'state preservation', 'development speed']
      },
      {
        'question': 'What is the difference between a `StatelessWidget` and a `StatefulWidget`?',
        'keywords': ['immutability', 'state', 'data', 'change', 'rebuild']
      },
      {
        'question': 'What is the Widget Tree?',
        'keywords': ['ui hierarchy', 'nested widgets', 'layout', 'parent-child', 'rendering']
      },
      {
        'question': 'How is a Flutter app rendered?',
        'keywords': ['skia engine', 'GPU', 'pixel', 'rendering pipeline', 'performance']
      },
      {
        'question': 'What is the purpose of the `pubspec.yaml` file?',
        'keywords': ['dependencies', 'assets', 'configuration', 'package management', 'yaml']
      },
      {
        'question': 'What is a key?',
        'keywords': ['widget identity', 'state preservation', 'widget tree', 'reordering', 'performance']
      },
      {
        'question': 'How do you manage state in a Flutter app?',
        'keywords': ['provider', 'bloc', 'getx', 'inheritedwidget', 'state management']
      },
      {
        'question': 'How does Flutter handle platform-specific code?',
        'keywords': ['platform channels', 'plugins', 'native code', 'iOS', 'Android']
      },
      {
        'question': 'What is the role of the `build` method?',
        'keywords': ['widget tree', 'layout', 'ui', 'render', 'context']
      },
      {
        'question': 'Explain the difference between a `package` and a `plugin`.',
        'keywords': ['dart code', 'platform-specific code', 'native functionality', 'dependency', 'repository']
      }
    ],
    AiChallengeCategory.java: [
      {
        'question': 'What is the main advantage of using the `final` keyword in Java?',
        'keywords': ['immutability', 'inheritance', 'polymorphism', 'constant', 'method overriding'],
      },
      {
        'question': 'What is the primary difference between `ArrayList` and `LinkedList`?',
        'keywords': ['data structure', 'performance', 'random access', 'sequential access', 'memory allocation'],
      },
      {
        'question': 'Explain the concept of "garbage collection" in Java.',
        'keywords': ['memory management', 'automatic', 'object', 'heap', 'unreferenced'],
      },
      {
        'question': 'What are the main pillars of Object-Oriented Programming (OOP) in Java?',
        'keywords': ['encapsulation', 'inheritance', 'polymorphism', 'abstraction', 'reusability'],
      },
      {
        'question': 'What is the purpose of the `static` keyword?',
        'keywords': ['class-level', 'instance', 'memory', 'variable', 'method', 'shareable'],
      },
      {
        'question': 'What is an exception in Java, and how is it handled?',
        'keywords': ['runtime error', 'try-catch', 'throw', 'checked', 'unchecked', 'exception handling'],
      },
      {
        'question': 'Explain the difference between `interface` and `abstract class`.',
        'keywords': ['multiple inheritance', 'method implementation', 'contract', 'partial implementation', 'fields'],
      },
      {
        'question': 'What is multithreading, and why is it used?',
        'keywords': ['concurrency', 'multiple threads', 'parallel processing', 'CPU utilization', 'responsiveness'],
      },
      {
        'question': 'What is the purpose of the `super` keyword?',
        'keywords': ['parent class', 'constructor', 'method overriding', 'inheritance', 'variable'],
      },
      {
        'question': 'How does Java achieve platform independence?',
        'keywords': ['JVM', 'bytecode', 'compile once', 'run anywhere', 'platform-specific'],
      },
    ],
    AiChallengeCategory.sports: [
      {
        "question": "What is the difference between a penalty kick in football and a free kick?",
        "keywords": ["football", "foul", "penalty box", "direct shot", "set piece"]
      },
      {
        "question": "Explain the role of a 'googly' in cricket and who invented it.",
        "keywords": ["cricket", "bowling", "leg-spin", "wrong'un", "Bernard Bosanquet"]
      },
      {
        "question": "What are the five main strokes in swimming, and what is the difference between them?",
        "keywords": ["swimming", "freestyle", "breaststroke", "butterfly", "backstroke", "medley"]
      },
      {
        "question": "Describe the main rules of a 'tie-break' in tennis.",
        "keywords": ["tennis", "set", "scoring", "service", "advantage", "deciding game"]
      },
      {
        "question": "How is a 'hat-trick' defined in various sports, such as hockey and football?",
        "keywords": ["scoring", "consecutive", "achievement", "hockey", "football", "player"]
      },
      {
        "question": "What are the different types of pitches in baseball and how do they differ?",
        "keywords": ["baseball", "pitching", "fastball", "curveball", "slider", "changeup"]
      },
      {
        "question": "Explain the concept of a 'triple-double' in basketball.",
        "keywords": ["basketball", "statistics", "points", "rebounds", "assists", "double-digits"]
      },
      {
        "question": "What is the 'offside rule' in football, and why is it important?",
        "keywords": ["football", "position", "attacking player", "defence", "fair play", "rule"]
      },
      {
        "question": "How does the 'handicap' system work in golf?",
        "keywords": ["golf", "scoring", "player ability", "fair competition", "course rating", "adjustment"]
      },
      {
        "question": "What are the main events in a decathlon and a heptathlon?",
        "keywords": ["athletics", "track and field", "multi-event", "running", "jumping", "throwing"]
      }
    ],
    AiChallengeCategory.movie: [
      {
        "question": "What are the main themes explored in Christopher Nolan's 'Interstellar'?",
        "keywords": ["space travel", "love", "time dilation", "science fiction", "humanity"]
      },
      {
        "question": "How did 'The Matrix' revolutionize the science fiction and action genres?",
        "keywords": ["visual effects", "bullet time", "philosophy", "cyberpunk", "reality"]
      },
      {
        "question": "What is the cultural significance of 'Forrest Gump'?",
        "keywords": ["historical events", "American history", "life lessons", "destiny", "iconic character"]
      },
      {
        "question": "What elements make 'Pulp Fiction' a groundbreaking film?",
        "keywords": ["non-linear narrative", "dialogue", "crime genre", "pop culture", "Quentin Tarantino"]
      },
      {
        "question": "How does 'The Lord of the Rings' trilogy build its fantasy world?",
        "keywords": ["world-building", "mythology", "character archetypes", "good vs evil", "epic scale"]
      },
      {
        "question": "What are the key conflicts in the movie 'Parasite'?",
        "keywords": ["class struggle", "social commentary", "inequality", "comedy", "thriller"]
      },
      {
        "question": "Explain the psychological journey of the main character in 'Joker'.",
        "keywords": ["mental health", "social alienation", "origin story", "villain", "Joaquin Phoenix"]
      },
      {
        "question": "What are the core concepts of 'Inception'?",
        "keywords": ["dreams", "subconscious mind", "heist", "layers of reality", "mind-bending"]
      },
      {
        "question": "What makes 'Spirited Away' a classic of animated cinema?",
        "keywords": ["Studio Ghibli", "spirit world", "coming-of-age", "Japanese culture", "animation"]
      },
      {
        "question": "How does 'Whiplash' explore the theme of obsession and ambition?",
        "keywords": ["music", "perfection", "abusive relationship", "drama", "psychological"]
      }
    ],
    AiChallengeCategory.php: [
      {
        'question': 'What is the primary role of PHP in web development?',
        'keywords': ['server-side scripting', 'dynamic content', 'database interaction', 'web pages', 'backend']
      },
      {
        'question': 'What is the difference between `include()` and `require()`?',
        'keywords': ['file inclusion', 'error handling', 'fatal error', 'warning', 'script execution']
      },
      {
        'question': 'How do you handle sessions in PHP?',
        'keywords': ['session start', 'state', 'user information', 'server-side', 'global variable']
      },
      {
        'question': 'What is the purpose of the  _GET and _POST superglobal arrays?',
        'keywords': ['form data', 'url parameter', 'query string', 'request method', 'data submission']
      },
      {
        'question': 'What are the main advantages of using a framework like Laravel or Symfony?',
        'keywords': ['structure', 'code reusability', 'security', 'maintenance', 'rapid development']
      },
      {
        'question': 'How do you connect to a database in PHP?',
        'keywords': ['pdo', 'mysqli', 'database connection', 'sql query', 'data retrieval']
      },
      {
        'question': 'What is Composer in PHP?',
        'keywords': ['dependency management', 'package manager', 'libraries', 'autoloader', 'project setup']
      },
      {
        'question': 'How do you perform exception handling in PHP?',
        'keywords': ['try-catch', 'exception', 'error handling', 'throw', 'runtime error']
      },
      {
        'question': 'What is the difference between `echo` and `print`?',
        'keywords': ['output', 'return value', 'performance', 'statement', 'expression']
      },
      {
        'question': 'What is the `__construct()` method?',
        'keywords': ['constructor', 'class', 'object creation', 'initialization', 'default']
      }
    ],
    // FIX: Removed duplicate entries for science, politics, and python from here
    AiChallengeCategory.science: [
      {
        "question": "What is the primary function of DNA?",
        "keywords": ["genetic information", "heredity", "nucleic acid", "double helix", "chromosomes"]
      },
      {
        "question": "What is the difference between a physical change and a chemical change?",
        "keywords": ["physical change", "chemical change", "composition", "reversibility", "new substance"]
      },
      {
        "question": "What is Newton's First Law of Motion?",
        "keywords": ["inertia", "object at rest", "object in motion", "external force", "momentum"]
      },
      {
        "question": "Explain the concept of 'pH' and what it measures.",
        "keywords": ["acidity", "alkalinity", "hydrogen ions", "scale", "neutral"]
      },
      {
        "question": "What is the difference between speed and velocity?",
        "keywords": ["speed", "velocity", "scalar", "vector", "direction", "magnitude"]
      },
      {
        "question": "What are the three main types of rocks?",
        "keywords": ["igneous", "sedimentary", "metamorphic", "geology", "rock cycle"]
      },
      {
        "question": "What is the role of photosynthesis in the ecosystem?",
        "keywords": ["photosynthesis", "carbon dioxide", "oxygen", "glucose", "producers"]
      },
      {
        "question": "What is the basic unit of life?",
        "keywords": ["cell", "organism", "biology", "membrane", "cytoplasm"]
      },
      {
        "question": "Explain the difference between series and parallel circuits.",
        "keywords": ["series circuit", "parallel circuit", "current", "voltage", "resistance"]
      },
      {
        "question": "What is the process of a liquid turning into a gas?",
        "keywords": ["evaporation", "boiling", "vaporization", "phase change", "temperature"]
      }
    ],
    AiChallengeCategory.politics: [
      {
        "question": "What are the key differences between Democracy and Dictatorship?",
        "keywords": ["power", "government", "citizen participation", "freedom", "elections"]
      },
      {
        "question": "Explain the relationship between Fundamental Rights and Directive Principles of State Policy in the Indian Constitution.",
        "keywords": ["rights", "duties", "welfare state", "constitution", "justice"]
      },
      {
        "question": "What are the main differences between a Parliamentary System and a Presidential System of government?",
        "keywords": ["head of government", "separation of powers", "executive", "legislative", "accountability"]
      },
      {
        "question": "Describe the roles and functions of Political Parties and Pressure Groups.",
        "keywords": ["representation", "policy making", "public opinion", "influence", "elections"]
      },
      {
        "question": "What is the difference between a Federal System and a Unitary System?",
        "keywords": ["power distribution", "central government", "state government", "constitution", "governance"]
      },
      {
        "question": "Explain the concepts of Nationalism and Internationalism.",
        "keywords": ["sovereignty", "identity", "global cooperation", "conflict", "ideology"]
      },
      {
        "question": "What are the main functions and powers of the Election Commission of India?",
        "keywords": ["elections", "conduct", "fairness", "model code of conduct", "voter registration"]
      },
      {
        "question": "Explain the importance of the concepts of 'Rights' and 'Justice' in modern politics.",
        "keywords": ["equality", "liberty", "social justice", "political justice", "legal justice"]
      },
      {
        "question": "How has Globalization impacted political systems?",
        "keywords": ["sovereignty", "global governance", "economic interdependence", "cultural change", "power dynamics"]
      },
      {
        "question": "What is a Constitutional Government, and what are its key features?",
        "keywords": ["rule of law", "limited government", "constitution", "rights protection", "checks and balances"]
      }
    ],
    AiChallengeCategory.python: [
      {
        'question': 'What is the difference between a list and a tuple?',
        'keywords': ['data structure', 'mutability', 'immutable', 'sequence', 'performance']
      },
      {
        'question': 'Explain the use of the `__init__` method.',
        'keywords': ['constructor', 'class', 'initialization', 'object', 'instance']
      },
      {
        'question': 'What is a decorator in Python?',
        'keywords': ['function modification', 'wrapper', 'syntax', 'behavior', 'function as argument']
      },
      {
        'question': 'How does Python handle memory management?',
        'keywords': ['garbage collection', 'automatic', 'reference counting', 'memory allocation', 'deallocation']
      },
      {
        'question': 'What is the purpose of the `yield` keyword?',
        'keywords': ['generator', 'iteration', 'state', 'lazy evaluation', 'memory efficiency']
      },
      {
        'question': 'What is a dictionary in Python?',
        'keywords': ['key-value pair', 'hash map', 'unordered', 'mutable', 'data structure']
      },
      {
        'question': 'Explain the concept of duck typing in Python.',
        'keywords': ['dynamic typing', 'behavior', 'interface', 'polymorphism', 'type checking']
      },
      {
        'question': 'What is the Global Interpreter Lock (GIL)?',
        'keywords': ['single thread', 'multithreading', 'concurrency', 'performance', 'CPython']
      },
      {
        'question': 'What is the difference between `range()` and `xrange()`?',
        'keywords': ['iteration', 'memory', 'generator', 'list', 'Python 2', 'Python 3']
      },
      {
        'question': 'How do you handle exceptions in Python?',
        'keywords': ['try-except', 'error handling', 'finally', 'exception', 'traceback']
      }
    ],
  };

  List<AiChallengeCategory> get availableCategories => _aiQuizQuestions.keys.toList();

  Future<String> getAnswer(String question) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final cleanQuestion = question.toLowerCase().trim().replaceAll('?', '');
    if (_knowledgeBase.containsKey(cleanQuestion)) {
      return _knowledgeBase[cleanQuestion]!;
    } else {
      return "I'm sorry, I'm just a mock AI and my knowledge is limited.";
    }
  }

  Future<Map<String, dynamic>> getAiChallengeQuestion(AiChallengeCategory category) async {
    await Future.delayed(const Duration(milliseconds: 750));
    final random = Random();
    // This null check prevents a crash if a category is in the enum but not the map
    final questionsForCategory = _aiQuizQuestions[category];
    if (questionsForCategory == null || questionsForCategory.isEmpty) {
      return {
        'question': 'No questions found for this category.',
        'keywords': [],
      };
    }
    return questionsForCategory[random.nextInt(questionsForCategory.length)];
  }

  Map<String, dynamic> evaluateAnswerAccuracy({
    required String userAnswer,
    required List<dynamic> keywords,
  }) {
    if (keywords.isEmpty) return {'accuracy': 100.0, 'foundKeywords': [], 'missedKeywords': []};

    final cleanAnswer = userAnswer.toLowerCase();
    final foundKeywords = <String>{};

    for (String keyword in keywords.cast<String>()) {
      if (cleanAnswer.contains(keyword)) {
        foundKeywords.add(keyword);
      }
    }

    double accuracy = (foundKeywords.length / keywords.length) * 100;

    return {
      'accuracy': accuracy,
      'foundKeywords': foundKeywords.toList(),
      'missedKeywords': keywords.where((kw) => !foundKeywords.contains(kw)).toList(),
    };
  }
}