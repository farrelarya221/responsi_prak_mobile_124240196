import 'package:get/get.dart';
import '../api/api_service.dart';

class GameController extends GetxController {
  final RxList<dynamic> games = <dynamic>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGames();
  }

  void fetchGames() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final data = await ApiService.fetchGames();
      games.assignAll(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  List<dynamic> get filteredGames {
    if (searchQuery.value.trim().isEmpty) {
      return games;
    }
    return games.where((item) {
      final title = (item['title'] ?? '').toString().toLowerCase();
      return title.contains(searchQuery.value.trim().toLowerCase());
    }).toList();
  }
}
