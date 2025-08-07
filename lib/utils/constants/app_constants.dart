class AppConstants {
  //constant data
  static const String travelJsonData = '''
[
  {
    "id": "TRIP001",
    "title": "Berlin Yaz Tatili",
    "country": "germany",
    "region": "berlin",
    "startDate": "2025-07-15",
    "endDate": "2025-07-25",
    "category": "culture",
    "description": "Berlin'de müzeler, tarihî yapılar ve sokak sanatı keşfi",
    "isFavorite": false,
    "imagePath": "assets/images/berlin.jpg"
  },
  {
    "id": "TRIP002",
    "title": "Viyana Noel Turu",
    "country": "austria",
    "region": "wien",
    "startDate": "2025-12-20",
    "endDate": "2025-12-27",
    "category": "festival",
    "description": "Viyana'nın meşhur Noel pazarları ve klasik müzik konserleri",
    "isFavorite": true,
    "imagePath": "assets/images/vienna.jpg"
  },
  {
    "id": "TRIP003",
    "title": "İsviçre Alpleri Kayak Turu",
    "country": "switzerland",
    "region": "valais",
    "startDate": "2026-02-10",
    "endDate": "2026-02-18",
    "category": "adventure",
    "description": "Zermatt bölgesinde kayak ve doğa yürüyüşleri",
    "isFavorite": false,
    "imagePath": "assets/images/swiss_alps.jpg"
  },
  {
    "id": "TRIP004",
    "title": "Münih Bira Festivali",
    "country": "germany",
    "region": "bayern",
    "startDate": "2025-09-20",
    "endDate": "2025-10-05",
    "category": "festival",
    "description": "Oktoberfest boyunca kültürel etkinlikler ve yerel lezzetler",
    "isFavorite": true,
    "imagePath": "assets/images/munich.jpg"
  },
  {
    "id": "TRIP005",
    "title": "Genève Tarihi Şehirler",
    "country": "switzerland",
    "region": "geneve",
    "startDate": "2027-01-31",
    "endDate": "2027-02-03",
    "category": "art",
    "description": "Müze ve tarihi yer gezileri",
    "isFavorite": false,
    "imagePath": "assets/images/geneva.jpg"
  },
  {
    "id": "TRIP006",
    "title": "Zürich Sanat Haftası",
    "country": "switzerland",
    "region": "zurich",
    "startDate": "2027-07-06",
    "endDate": "2027-07-16",
    "category": "gastronomy",
    "description": "Sakinlik ve doğa yürüyüşleri",
    "isFavorite": true,
    "imagePath": "assets/images/zurich.jpg"
  },
  {
    "id": "TRIP007",
    "title": "Tirol Tarihi Şehirler",
    "country": "austria",
    "region": "tirol",
    "startDate": "2029-11-13",
    "endDate": "2029-11-23",
    "category": "gastronomy",
    "description": "Sakinlik ve doğa yürüyüşleri",
    "isFavorite": true,
    "imagePath": "assets/images/tirol.jpg"
  },
  {
    "id": "TRIP008",
    "title": "Zürich Kayak Haftası",
    "country": "switzerland",
    "region": "zurich",
    "startDate": "2028-04-04",
    "endDate": "2028-04-08",
    "category": "history",
    "description": "Sakinlik ve doğa yürüyüşleri",
    "isFavorite": true,
    "imagePath": "assets/images/zurich_ski.jpg"
  },
  {
    "id": "TRIP009",
    "title": "Tirol Kış Macerası",
    "country": "austria",
    "region": "tirol",
    "startDate": "2027-06-13",
    "endDate": "2027-06-18",
    "category": "gastronomy",
    "description": "Geleneksel tatlarla dolu bir rota",
    "isFavorite": true,
    "imagePath": "assets/images/tirol_winter.jpg"
  },
  {
    "id": "TRIP010",
    "title": "Valais Noel Gezisi",
    "country": "switzerland",
    "region": "valais",
    "startDate": "2025-12-24",
    "endDate": "2025-12-31",
    "category": "history",
    "description": "Sakinlik ve doğa yürüyüşleri",
    "isFavorite": true,
    "imagePath": "assets/images/valais_christmas.jpg"
  },
  {
    "id": "TRIP011",
    "title": "Wien Kültür Turu",
    "country": "austria",
    "region": "wien",
    "startDate": "2027-09-08",
    "endDate": "2027-09-12",
    "category": "festival",
    "description": "Sanat galerileri ve sokak performansları",
    "isFavorite": false,
    "imagePath": "assets/images/vienna_culture.jpg"
  },
  {
    "id": "TRIP012",
    "title": "Bayern Kültür Turu",
    "country": "germany",
    "region": "bayern",
    "startDate": "2027-06-21",
    "endDate": "2027-06-29",
    "category": "art",
    "description": "Sakinlik ve doğa yürüyüşleri",
    "isFavorite": false,
    "imagePath": "assets/images/bayern_culture.jpg"
  },
  {
    "id": "TRIP013",
    "title": "Vorarlberg Kış Macerası",
    "country": "austria",
    "region": "vorarlberg",
    "startDate": "2029-11-15",
    "endDate": "2029-11-18",
    "category": "festival",
    "description": "Geleneksel tatlarla dolu bir rota",
    "isFavorite": false,
    "imagePath": "assets/images/vorarlberg_winter.jpg"
  },
  {
    "id": "TRIP014",
    "title": "Bayern Noel Gezisi",
    "country": "germany",
    "region": "bayern",
    "startDate": "2029-05-22",
    "endDate": "2029-05-26",
    "category": "gastronomy",
    "description": "Geleneksel tatlarla dolu bir rota",
    "isFavorite": true,
    "imagePath": "assets/images/bayern_christmas.jpg"
  },
  {
    "id": "TRIP015",
    "title": "Hamburg Kış Macerası",
    "country": "germany",
    "region": "hamburg",
    "startDate": "2026-12-30",
    "endDate": "2027-01-08",
    "category": "festival",
    "description": "Bölgedeki doğal güzelliklerin keşfi",
    "isFavorite": false,
    "imagePath": "assets/images/hamburg_winter.jpg"
  },
  {
    "id": "TRIP016",
    "title": "Hamburg Yaz Tatili",
    "country": "germany",
    "region": "hamburg",
    "startDate": "2029-08-17",
    "endDate": "2029-08-24",
    "category": "gastronomy",
    "description": "Festival coşkusunun yaşandığı dolu dolu günler",
    "isFavorite": true,
    "imagePath": "assets/images/hamburg_summer.jpg"
  },
  {
    "id": "TRIP017",
    "title": "Genève Festival Günleri",
    "country": "switzerland",
    "region": "geneve",
    "startDate": "2027-08-16",
    "endDate": "2027-08-22",
    "category": "nature",
    "description": "Geleneksel tatlarla dolu bir rota",
    "isFavorite": true,
    "imagePath": "assets/images/geneva_festival.jpg"
  },
  {
    "id": "TRIP018",
    "title": "Sachsen Kültür Turu",
    "country": "germany",
    "region": "sachsen",
    "startDate": "2028-08-31",
    "endDate": "2028-09-10",
    "category": "nature",
    "description": "Bölgedeki doğal güzelliklerin keşfi",
    "isFavorite": false,
    "imagePath": "assets/images/sachsen_culture.jpg"
  },
  {
    "id": "TRIP019",
    "title": "Vorarlberg Festival Günleri",
    "country": "austria",
    "region": "vorarlberg",
    "startDate": "2026-12-30",
    "endDate": "2027-01-02",
    "category": "festival",
    "description": "Yerel mutfağın tadımı",
    "isFavorite": true,
    "imagePath": "assets/images/vorarlberg_festival.jpg"
  },
  {
    "id": "TRIP020",
    "title": "Bern Festival Günleri",
    "country": "switzerland",
    "region": "bern",
    "startDate": "2027-02-22",
    "endDate": "2027-02-25",
    "category": "festival",
    "description": "Kültürel etkinliklerle dolu bir hafta",
    "isFavorite": false,
    "imagePath": "assets/images/bern_festival.jpg"
  },
  {
    "id": "TRIP021",
    "title": "Wien Festival Günleri",
    "country": "austria",
    "region": "wien",
    "startDate": "2029-02-13",
    "endDate": "2029-02-20",
    "category": "history",
    "description": "Sakinlik ve doğa yürüyüşleri",
    "isFavorite": false,
    "imagePath": "assets/images/vienna_festival.jpg"
  },
  {
    "id": "TRIP022",
    "title": "Tirol Yaz Tatili",
    "country": "austria",
    "region": "tirol",
    "startDate": "2028-05-18",
    "endDate": "2028-05-22",
    "category": "festival",
    "description": "Yerel mutfağın tadımı",
    "isFavorite": false,
    "imagePath": "assets/images/tirol_summer.jpg"
  },
  {
    "id": "TRIP023",
    "title": "Berlin Noel Gezisi",
    "country": "germany",
    "region": "berlin",
    "startDate": "2026-09-18",
    "endDate": "2026-09-21",
    "category": "history",
    "description": "Sanat galerileri ve sokak performansları",
    "isFavorite": false,
    "imagePath": "assets/images/berlin_christmas.jpg"
  }
]
''';

  //filters and ui view type chose
  static const String favoritesKey = 'favorite_trip_ids';
  static const String filterCountryKey = 'filter_country';
  static const String filterRegionKey = 'filter_region';
  static const String filterCategoryKey = 'filter_category';
  static const String filterStartDateKey = 'filter_start_date';
  static const String filterEndDateKey = 'filter_end_date';
  static const String viewModeKey = 'view_mode'; // list or grid
}
