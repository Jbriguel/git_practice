class StoragesFolders {
  static const String apps = "app_folders";
  static const String abonnements = "abonnements";
  static const String users = "users";
  static const String entreprises_images = "entreprises_images";
  static const String ateliers_images = "ateliers_images";
  static const String modeles_images = "modeles_images";
  static const String modeles_pdf = "modeles_pdf";
  static const String commandes_pdf = "commandes_pdf";
  static const String commandes_images = "commandes_images";
  static const String entreprise_logo = "entreprise_logo";

  static String entreprise_logo_folder(String entreprise_uid) =>
      "$apps/$entreprises_images/$entreprise_uid/$entreprise_logo";
}
