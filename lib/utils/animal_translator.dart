class AnimalTranslator {
  static const searchNames = {
    'лиса': 'fox',
    'лев': 'lion',
    'дельфин': 'dolphin',
    'панда': 'panda',
    'тигр': 'tiger',
    'волк': 'wolf',
    'медведь': 'bear',
    'слон': 'elephant',
    'жираф': 'giraffe',
    'обезьяна': 'monkey',
    'орёл': 'eagle',
    'акула': 'shark',
    'кит': 'whale',
    'лошадь': 'horse',
    'кошка': 'cat',
    'собака': 'dog',
  };

  static const animalNames = {
    'fox': 'Лиса',
    'red fox': 'Рыжая лиса',
    'fennec fox': 'Фенек',
    'arctic fox': 'Песец',
    'american foxhound': 'Американский фоксхаунд',
    'cross fox': 'Крестовка',
    'darwin’s fox': 'Дарвиновская лисица',
    "darwin's fox": 'Дарвиновская лисица',
    'english foxhound': 'Английский фоксхаунд',
    'fox snakes': 'Лисьи полозы',
    'fox squirrel': 'Лисья белка',
    'fox terrier': 'Фокстерьер',
    'golden-crowned flying fox': 'Золотокрылая летучая лисица',
    'gray fox': 'Серая лисица',
    'kit fox': 'Американский корсак',
    'marble fox': 'Мраморная лисица',
    'smooth fox terrier': 'Гладкошёрстный фокстерьер',
    'tibetan fox': 'Тибетская лисица',
    'toy fox terrier': 'Той-фокстерьер',
    'wire fox terrier': 'Жесткошёрстный фокстерьер',
    'lion': 'Лев',
    'cape lion': 'Капский лев',
    'golden lion tamarin': 'Золотистая львиная игрунка',
    'lion’s mane jellyfish': 'Медуза «львиная грива»',
    "lion's mane jellyfish": 'Медуза «львиная грива»',
    'lionfish': 'Крылатка',
    'mountain lion': 'Горный лев',
    'sea lion': 'Морской лев',
    'dolphin': 'Дельфин',
    'bottlenose dolphin': 'Афалина',
    'amazon river dolphin (pink dolphin)': 'Амазонский речной дельфин',
    'dusky dolphin': 'Тёмный дельфин',
    'mahi mahi (dolphin fish)': 'Махи-махи',
    'panda': 'Панда',
    'giant panda bear': 'Большая панда',
    'red panda': 'Красная панда',
    'tiger': 'Тигр',
    'wolf': 'Волк',
    'bear': 'Медведь',
    'elephant': 'Слон',
    'giraffe': 'Жираф',
    'monkey': 'Обезьяна',
    'eagle': 'Орёл',
    'shark': 'Акула',
    'whale': 'Кит',
    'horse': 'Лошадь',
    'cat': 'Кошка',
    'dog': 'Собака',
  };

  static const classes = {
    'mammalia': 'Млекопитающие',
    'aves': 'Птицы',
    'reptilia': 'Пресмыкающиеся',
    'amphibia': 'Земноводные',
    'actinopterygii': 'Лучепёрые рыбы',
    'chondrichthyes': 'Хрящевые рыбы',
    'insecta': 'Насекомые',
    'arachnida': 'Паукообразные',
    'scyphozoa': 'Сцифоидные медузы',
  };

  static const locations = {
    'africa': 'Африка',
    'asia': 'Азия',
    'europe': 'Европа',
    'north-america': 'Северная Америка',
    'south-america': 'Южная Америка',
    'oceania': 'Океания',
    'antarctica': 'Антарктида',
    'eurasia': 'Евразия',
    'central-america': 'Центральная Америка',
    'ocean': 'Мировой океан',
  };

  static String searchQuery(String value) {
    return searchNames[value.toLowerCase()] ?? value;
  }

  static String animalName(String value) {
    final exactName = animalNames[value.toLowerCase()];
    if (exactName != null) return exactName;

    var result = value;
    const words = {
      'Dolphin': 'дельфин',
      'Panda': 'панда',
      'Tiger': 'тигр',
      'Wolf': 'волк',
      'Bear': 'медведь',
      'Elephant': 'слон',
      'Giraffe': 'жираф',
      'Monkey': 'обезьяна',
      'Eagle': 'орёл',
      'Shark': 'акула',
      'Whale': 'кит',
      'Horse': 'лошадь',
      'Fox': 'лиса',
      'Lion': 'лев',
      'Red': 'красная',
      'Arctic': 'арктическая',
      'African': 'африканский',
      'Asian': 'азиатский',
      'Mountain': 'горный',
      'Sea': 'морской',
      'River': 'речной',
      'White': 'белый',
      'Black': 'чёрный',
      'Giant': 'большая',
      'Common': 'обыкновенный',
    };
    for (final entry in words.entries) {
      result = result.replaceAll(
        RegExp('\\b${entry.key}\\b', caseSensitive: false),
        entry.value,
      );
    }
    return result[0].toUpperCase() + result.substring(1);
  }

  static String animalClass(String value) {
    return classes[value.toLowerCase()] ?? value;
  }

  static String location(String value) {
    return locations[value.toLowerCase()] ?? value;
  }

  static String diet(String value) {
    final lower = value.toLowerCase();
    if (lower.contains('omnivore')) return 'Всеядное';
    if (lower.contains('carnivore')) return 'Плотоядное';
    if (lower.contains('herbivore')) return 'Травоядное';
    if (lower.contains('insectivore')) return 'Насекомоядное';
    return value;
  }

  static String habitat(String value) {
    const exactHabitats = {
      'plains': 'Равнины',
      'lowland tropical forest': 'Равнинные тропические леса',
      'open woodland, scrub, grassland': 'Редколесье, кустарники и луга',
      'cooler ocean waters': 'Прохладные океанические воды',
      'tropical reefs and rocky crevices':
          'Тропические рифы и скалистые расщелины',
      'forest and mountainous regions': 'Лесные и горные районы',
      'coastal waters and rocky shorelines':
          'Прибрежные воды и скалистые берега',
      'caves and forests': 'Пещеры и леса',
      'desert, grasslands': 'Пустыни и луга',
      'forests and plains': 'Леса и равнины',
      'forests, grasslands, tundra, prairie, deserts, and mountains':
          'Леса, луга, тундра, прерии, пустыни и горы',
      'forests, prairies, deserts, mountains, cities, suburbs, tundra, scrub, near rivers, farms':
          'Леса, прерии, пустыни, горы, города, тундра и территории возле рек',
      'human captivity': 'Содержание человеком',
      'leaf nests and tree dens': 'Гнёзда из листьев и дупла деревьев',
      'polar forest regions': 'Полярные лесные районы',
      'sandy and semi-arid desert': 'Песчаные и полузасушливые пустыни',
      'temperate rainforests, shrubland':
          'Умеренные дождевые леса и кустарники',
      'tibetan plateau': 'Тибетское нагорье',
      'woodland areas and urban parks': 'Лесные районы и городские парки',
      "all of the world's oceans, rivers in asia and south america":
          'Все океаны мира, реки Азии и Южной Америки',
      'cooler waters near continental shelves':
          'Прохладные воды возле материкового шельфа',
      'large tropical rivers and estuaries': 'Большие тропические реки и устья',
      'temperate, tropical, and subtropical waters':
          'Умеренные, тропические и субтропические воды',
      'warm harbours and bays': 'Тёплые гавани и заливы',
      'high-altitude mountain forest': 'Высокогорные леса',
      'high-altitude, moist bamboo forest':
          'Влажные высокогорные бамбуковые леса',
    };
    final exactHabitat = exactHabitats[value.toLowerCase()];
    if (exactHabitat != null) return exactHabitat;

    var result = value;
    const words = {
      'Tropical forests': 'Тропические леса',
      'Temperate forests': 'Умеренные леса',
      'Arctic tundra': 'Арктическая тундра',
      'Coastal waters': 'Прибрежные воды',
      'Various habitats': 'Различные места обитания',
      'Forests': 'Леса',
      'Forest': 'Лес',
      'Grasslands': 'Луга',
      'Grassland': 'Луг',
      'Mountains': 'Горы',
      'Mountain': 'Горы',
      'Deserts': 'Пустыни',
      'Desert': 'Пустыня',
      'Oceans': 'Океаны',
      'Ocean': 'Океан',
      'Rivers': 'Реки',
      'River': 'Река',
      'Wetlands': 'Болотистая местность',
      'Freshwater': 'Пресные водоёмы',
    };
    for (final entry in words.entries) {
      result = result.replaceAll(entry.key, entry.value);
      result = result.replaceAll(entry.key.toLowerCase(), entry.value);
    }
    return result;
  }

  static String lifespan(String value) {
    var result = value
        .replaceAll(RegExp(r'years?', caseSensitive: false), 'лет')
        .replaceAll(RegExp(r'months?', caseSensitive: false), 'месяцев')
        .replaceAll(RegExp(r'days?', caseSensitive: false), 'дней');
    const words = {
      'one': 'один',
      'seven': 'семь',
      'unknown': 'неизвестно',
      'approximately': 'примерно',
      'up to': 'до',
      'in captivity': 'в неволе',
      'in the wild': 'в дикой природе',
      'to': 'до',
    };
    for (final entry in words.entries) {
      result = result.replaceAll(
        RegExp('\\b${entry.key}\\b', caseSensitive: false),
        entry.value,
      );
    }
    return result;
  }
}
