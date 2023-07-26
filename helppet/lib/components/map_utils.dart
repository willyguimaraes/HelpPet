import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

void openMapsForVeterinarians() async {
  // data atual
  DateTime now = DateTime.now();

  //Checa se está em horario comercial
  bool isBusinessHours = now.hour >= 8 && now.hour < 18;

  // Define a pesquisa que será feita no Google Maps de acordo com o horario atual
  String searchQuery = isBusinessHours ? 'veterinario' : 'veterinario 24 horas';

  //Pega a posição atual do dispositivo
  Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  // Montando a URI
  double latitude = currentPosition.latitude;
  double longitude = currentPosition.longitude;
  Uri uri = Uri.parse(
      "geo:$latitude,$longitude?q=${Uri.encodeComponent(searchQuery)}");

  if (await canLaunchUrl(uri)) {
    // Abre o Google Maps com a pesquisa de veterinários
    await launchUrl(uri);
  } else {
    // Caso não existam aplicativos capazes de lidar com a URI, mostra uma mensagem de erro
    throw 'Não foi possível abrir o Google Maps.';
  }
}
