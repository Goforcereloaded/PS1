$words2 = @(
    # Equipes de France
    "PSG", "Marseille", "Lyon", "Monaco", "Lille", "Rennes", "Nice", "Strasbourg", "Montpellier", 
    "Nantes", "Saint-Etienne", "Reims", "Bordeaux", "Angers", "Metz", "Brest", "Troyes", "Lorient", 
    "Clermont", "Lens", "Ajaccio", "Auxerre", "Bastia", "Guingamp", "Nancy", "Valenciennes", "Sochaux", 
    "Dijon",

    # Equipes de Belgique
    "Anderlecht", "Club Brugge", "Genk", "Gent", "Standard Liege", "Royal Antwerp", "Charleroi", 
    "Zulte Waregem", "KV Mechelen", "OH Leuven", "Eupen", "Cercle Brugge", "Sint-Truiden", 
    "KV Kortrijk", "Waasland-Beveren", "Seraing", "Beerschot", "Westerlo", "Union Saint-Gilloise", 
    "Mouscron",

    # Equipes des Pays-Bas
    "Ajax", "PSV", "Feyenoord", "AZ", "Utrecht", "Vitesse", "Twente", "Groningen", "Heerenveen", 
    "Willem II", "Heracles", "Fortuna Sittard", "Sparta Rotterdam", "PEC Zwolle", "RKC Waalwijk", 
    "VVV-Venlo", "Emmen", "ADO Den Haag", "Cambuur", "NEC Nijmegen", "Go Ahead Eagles",

    # Equipes d'Allemagne
    "Bayern Munich", "Borussia Dortmund", "RB Leipzig", "Bayer Leverkusen", "Borussia Monchengladbach", 
    "Wolfsburg", "Eintracht Frankfurt", "Union Berlin", "Freiburg", "Hoffenheim", "Stuttgart", 
    "Augsburg", "Hertha Berlin", "Mainz", "Werder Bremen", "Arminia Bielefeld", "Koln", "Schalke", 
    "Hannover", "Nuremberg", "Paderborn",

    # Equipes d'Angleterre
    "Liverpool", "Manchester City", "Manchester United", "Chelsea", "Arsenal", "Tottenham", 
    "Leicester City", "West Ham", "Everton", "Aston Villa", "Newcastle United", "Wolverhampton", 
    "Crystal Palace", "Southampton", "Brighton", "Burnley", "Watford", "Norwich City", "Leeds United", 
    "Sheffield United", "Fulham", "Bournemouth", "Derby County", "Blackburn Rovers",

    # Equipes d'Espagne
    "Real Madrid", "Barcelona", "Atletico Madrid", "Sevilla", "Villarreal", "Real Sociedad", 
    "Real Betis", "Athletic Bilbao", "Valencia", "Celta Vigo", "Espanyol", "Getafe", "Osasuna", 
    "Granada", "Elche", "Cadiz", "Levante", "Mallorca", "Real Zaragoza", "Real Oviedo", "Las Palmas",

    # Equipes d'Italie
    "Juventus", "Inter Milan", "AC Milan", "Napoli", "Roma", "Lazio", "Atalanta", "Fiorentina", 
    "Torino", "Sampdoria", "Bologna", "Udinese", "Sassuolo", "Genoa", "Cagliari", "Verona", 
    "Spezia", "Salernitana", "Empoli", "Venezia", "Benevento", "Parma",

    # Equipes du Portugal
    "Porto", "Benfica", "Sporting", "Braga", "Vitoria Guimaraes", "Maritimo", "Boavista", 
    "Pacos Ferreira", "Belenenses", "Estoril", "Moreirense", "Gil Vicente", "Tondela", 
    "Santa Clara", "Arouca", "Vizela", "Famalicao", "Casa Pia", "Farense", "Academica", "Feirense",

    # Equipes de Russie
    "Zenit", "Spartak Moscow", "CSKA Moscow", "Lokomotiv Moscow", "Krasnodar", "Rostov", 
    "Rubin Kazan", "Dynamo Moscow", "Ural", "Akhmat Grozny", "Arsenal Tula", "Khimki", 
    "Sochi", "Tambov", "Ufa", "Krylia Sovetov", "Orenburg", "Nizhny Novgorod",

    # Equipes de Turquie
    "Galatasaray", "Fenerbahce", "Besiktas", "Trabzonspor", "Basaksehir", "Sivasspor", 
    "Alanyaspor", "Gaziantep", "Antalyaspor", "Konyaspor", "Goztepe", "Kayserispor", 
    "Rizespor", "Kasimpasa", "Ankaragucu", "Genclerbirligi", "Erzurumspor", "Hatayspor", 
    "Yeni Malatyaspor", "Denizlispor", "Adanaspor",

    # Equipes de Suisse
    "Young Boys", "Basel", "Zurich", "Lugano", "Servette", "St. Gallen", "Sion", "Luzern", 
    "Grasshoppers", "Thun", "Winterthur", "Lausanne", "Schaffhausen",

    # Equipes d'Autriche
    "Red Bull Salzburg", "Rapid Vienna", "Austria Vienna", "Sturm Graz", "LASK", "Wolfsberger", 
    "Hartberg", "Ried", "Admira", "Altach", "Mattersburg", "Wacker Innsbruck", "Blau-Weiss Linz",

    # Equipes de Suede
    "Malmo", "AIK", "Djurgarden", "Hammarby", "Goteborg", "Norrkoping", "Elfsborg", 
    "Hacken", "Sirius", "Orebro", "Degerfors", "Varbergs", "Mjallby",

    # Equipes de Norvege
    "Molde", "Rosenborg", "Bodo/Glimt", "Viking", "Valerenga", "Kristiansund", "Sarpsborg", 
    "Odd", "Stabaek", "Tromso", "HamKam", "Ranheim", "Mjondalen",

    # Equipes de Danemark
    "Copenhagen", "Midtjylland", "Brondby", "Aarhus", "Nordsjaelland", "Randers", 
    "Odense", "Sonderjyske", "Horsens", "Lyngby", "Viborg", "Esbjerg", "Silkeborg",

    # Equipes de Grece
    "Olympiakos", "PAOK", "AEK Athens", "Panathinaikos", "Aris", "OFI Crete", 
    "Asteras Tripolis", "Atromitos", "Lamia", "Volos", "Ionikos", "Apollon Smyrnis", 
    "PAS Giannina",

    # Equipes de Pologne
    "Legia Warsaw", "Lech Poznan", "Slask Wroclaw", "Piast Gliwice", "Jagiellonia", 
    "Pogon Szczecin", "Rakow Czestochowa", "Wisla Krakow", "Gornik Zabrze", "Zaglebie Lubin", 
    "LKS Lodz", "Arka Gdynia", "GKS Tychy",

    # Equipes de Republique Tcheque
    "Slavia Prague", "Sparta Prague", "Viktoria Plzen", "Jablonec", "Slovan Liberec", 
    "Mlada Boleslav", "Banik Ostrava", "Sigma Olomouc", "Teplice", "Karvina", 
    "Hradec Kralove", "Pardubice", "Bohemians 1905",

    # Equipes de Hongrie
    "Ferencvaros", "MOL Fehervar", "Puskas Akademia", "Ujpest", "Honved", "MTK Budapest", 
    "Zalaegerszeg", "Kisvarda", "Paks", "Mezokovesd", "Debrecen", "Gyirmot", "Szeged",

    # Equipes de Croatie
    "Dinamo Zagreb", "Hajduk Split", "Rijeka", "Osijek", "Lokomotiva", "Slaven Belupo", 
    "Istra", "Varazdin", "Sibenik", "Gorica", "Dragovoljac", "Inter Zapresic", "Cibalia",

    # Equipes de Serbie
    "Red Star Belgrade", "Partizan", "Vojvodina", "Cukaricki", "Radnicki Nis", 
    "Napredak", "Spartak Subotica", "Proleter", "Mladost", "Javor",

    # Equipes de Bulgarie
    "Ludogorets", "CSKA Sofia", "Levski Sofia", "Botev Plovdiv", "Lokomotiv Plovdiv", 
    "Cherno More", "Arda", "Beroe", "Slavia Sofia", "Tsarsko Selo",

    # Equipes de Roumanie
    "Steaua Bucharest", "CFR Cluj", "Universitatea Craiova", "Astra Giurgiu", 
    "Viitorul Constanta", "Dinamo Bucharest", "Gaz Metan", "Botosani", "Sepsi", "Chindia Targoviste",

    # Equipes de Slovaquie
    "Slovan Bratislava", "DAC Dunajska Streda", "Zilina", "Trnava", "Ruzomberok", 
    "Nitra", "Senica", "Pohronie", "Michalovce", "Sered",
	
    # Equipes de Slovenie
    "Maribor", "Olimpija Ljubljana", "Domzale", "Celje", "Mura", "Koper", 
    "Bravo", "Aluminij", "Tabor Sezana", "Gorica",
	
	# Equipes d'Ecosse
	"Celtic", "Rangers", "Aberdeen", "Hearts", "Hibernian", "Motherwell", "Dundee United", "Livingston", "St Johnstone", "Ross County", "Kilmarnock", "St Mirren",
	
	# Equipes d'Ukraine
	"Shakhtar Donetsk", "Dynamo Kiev", "Zorya Luhansk", "Vorskla Poltava", "Desna Chernihiv", "Dnipro-1", "Kolos Kovalivka", "Mariupol", "Olexandriya", "Karpaty Lviv",
	
	# Equipes de Finlande
	"HJK Helsinki", "KuPS", "Inter Turku", "SJK", "Ilves", "Honka", "Lahti", "Haka", "Mariehamn", "KTP",
	
	# Equipes de Bosnie-Herzegovine
	"Zeljeznicar", "Sarajevo", "Borac Banja Luka", "Siroki Brijeg", "Zrinjski", "Tuzla City", "Velez Mostar", "Sloboda Tuzla", "Radnik Bijeljina", "Olimpik Sarajevo"
)