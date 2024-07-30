import 'package:get/get.dart';
import 'package:pixel6/apiservice.dart';
import 'package:pixel6/usermodel.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  var filteredUsers = <User>[].obs;
  var isLoading = true.obs;
  var limit = 10;
  var skip = 0;
  var hasMore = true.obs;

  final ApiService apiService = ApiService();

  var selectedCountry = 'All'.obs;
  var selectedGender = 'All'.obs;
  var sortBy = 'All'.obs;

  final List<String> countries = ['All', 'United States', 'India', 'UK'];
  final List<String> genders = ['All', 'male', 'female'];
  final List<String> sortOptions = ['Name', 'ID', 'Age', 'All'];

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      var fetchedUsers = await apiService.fetchUsers(limit, skip);
      if (fetchedUsers.isNotEmpty) {
        users.addAll(fetchedUsers);
        applyFiltersAndSorting(); // Apply filter and sorting after fetching data
        skip += limit;
      } else {
        hasMore(false);
      }
    } finally {
      isLoading(false);
    }
  }

  void applyFiltersAndSorting() {
    List<User> tempUsers = List.from(users);

    if (selectedCountry.value != 'All') {
      tempUsers = tempUsers
          .where((user) => user.address.country == selectedCountry.value)
          .toList();
    }

    if (selectedGender.value != 'All') {
      tempUsers = tempUsers
          .where((user) => user.gender == selectedGender.value)
          .toList();
    }

    if (sortBy.value == 'Name') {
      tempUsers.sort((a, b) => a.firstName.compareTo(b.firstName));
    } else if (sortBy.value == 'ID') {
      tempUsers.sort((a, b) => a.id.compareTo(b.id));
    } else if (sortBy.value == 'Age') {
      tempUsers.sort((a, b) => a.age.compareTo(b.age));
    }
    // No sorting if sortBy is 'All'

    filteredUsers.assignAll(tempUsers);
  }
}
