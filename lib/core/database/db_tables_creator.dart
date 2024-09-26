import 'package:sqflite/sqflite.dart';

import 'db_config.dart';

class DbTablesCreator {
  static Future<void> createUserTable(Database db) async {
    await db.execute('''
         CREATE TABLE IF NOT EXISTS ${DbConfig.clientTable_name}(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uid TEXT NOT NULL UNIQUE,
            photoUrl TEXT,
            iconName TEXT,
            nomComplet TEXT,
            phone TEXT,
            email TEXT,
            adresse TEXT,
            informationsSuppelementaires TEXT,
            mesures TEXT,
            isDeleted INTEGER,
            createdAt TEXT DEFAULT CURRENT_DATE,
            updatedAt TEXT DEFAULT CURRENT_DATE
        )
    ''');
  }

  static Future<void> createModeleTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DbConfig.modeleTable_name} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uid TEXT NOT NULL UNIQUE,
        imgPath TEXT,
        name TEXT,
        description TEXT,
        genderType TEXT,
        creatorId TEXT,
        createdAt TEXT,
        modifiedAt TEXT
      )
    ''');
  }

  static Future<void> createModProprietyTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DbConfig.modProprietyTable_name} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uid TEXT NOT NULL UNIQUE,
        modeleUid TEXT,
        proprietyUid TEXT,
        FOREIGN KEY(modeleUid) REFERENCES Modele(uid),
        FOREIGN KEY(proprietyUid) REFERENCES Propriety(uid)
       )
    ''');
  }

  static Future<void> createProprietyTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS ${DbConfig.proprietyTable_name} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      uid TEXT NOT NULL UNIQUE,
      name TEXT,
      value TEXT
    )
    ''');
  }

  /// Create the Commande table in the database
  ///
  /// The table Commande has the following columns:
  ///
  /// - id: INTEGER PRIMARY KEY AUTOINCREMENT
  /// - uid: TEXT NOT NULL UNIQUE
  /// - clientUid: TEXT
  /// - deliveryDate: TEXT
  /// - details: TEXT
  /// - price: REAL
  /// - advance: REAL
  /// - createdAt: TEXT DEFAULT CURRENT_DATE
  /// - updatedAt: TEXT DEFAULT CURRENT_DATE
  ///
  /// The table has a foreign key constraint on the clientUid column
  /// that references the uid column of the Client table.
  ///
  /// The table is created with the following SQL query:
  ///
  /// 
  static Future<void> createCommandeTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS ${DbConfig.commandeTable_name} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      uid TEXT NOT NULL UNIQUE,
      clientUid TEXT,   
      deliveryDate TEXT,
      details TEXT,
      price REAL,   
      advance REAL,  
      createdAt TEXT DEFAULT CURRENT_DATE,
      updatedAt TEXT DEFAULT CURRENT_DATE,
      FOREIGN KEY(clientUid) REFERENCES ${DbConfig.clientTable_name}(uid)
    )
  ''');
  }

  /// Cr e la table [Habit] si elle n'existe pas
  /// La table [Habit] contient les informations suivantes :
  /// 
  /// - [id] : Identifiant unique de l'habit
  /// - [uid] : Identifiant unique de l'habit
  /// - [image] : Chemin de l'image de l'habit
  /// - [commandeUid] : Identifiant unique de la commande li e  l'habit
  /// - [modeleUid] : Identifiant unique du mod le li  l'habit
  /// - [name] : Nom de l'habit
  /// - [details] : D etails de l'habit
  /// - [price] : Prix de l'habit
  /// - [createdAt] : Date de cr ation de l'habit
  /// - [updatedAt] : Date de derni re mise  jour de l'habit
  /// 
  /// La cl  trang re de la table [Habit] est [id]
  /// Les cl s  trang res de la table [Habit] sont :
  /// - [commandeUid] vers la table [Commande]
  /// - [modeleUid] vers la table [Modele]
  static Future<void> createHabitTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS ${DbConfig.habitTable_name} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      uid TEXT NOT NULL UNIQUE,
      image TEXT,
      commandeUid TEXT, 
      modeleUid TEXT,    
      name TEXT,
      details TEXT,
      price REAL,      
      createdAt TEXT DEFAULT CURRENT_DATE,
      updatedAt TEXT DEFAULT CURRENT_DATE,
      FOREIGN KEY(commandeUid) REFERENCES ${DbConfig.commandeTable_name}(uid) ON DELETE CASCADE,
      FOREIGN KEY(modeleUid) REFERENCES ${DbConfig.modeleTable_name}(uid)
    )
  ''');
  }

  static Future<void> createHabitProprietyTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS ${DbConfig.habitProprietyTable_name} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      habitUid TEXT,     
      name TEXT,        
      value TEXT,    
      createdAt TEXT DEFAULT CURRENT_DATE,
      updatedAt TEXT DEFAULT CURRENT_DATE, 
      FOREIGN KEY(habitUid) REFERENCES ${DbConfig.habitTable_name}(uid) ON DELETE CASCADE
    )
  ''');
  }
}
