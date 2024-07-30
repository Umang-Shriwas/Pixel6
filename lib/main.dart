import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pixel6/user_List_Widget.dart';
import 'package:pixel6/user_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'User Listing App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: UserListingScreen(),
        );
      },
    );
  }
}

class UserListingScreen extends StatefulWidget {
  @override
  _UserListingScreenState createState() => _UserListingScreenState();
}

class _UserListingScreenState extends State<UserListingScreen> {
  final UserController userController = Get.put(UserController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (userController.hasMore.value) {
          userController.fetchUsers();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 690), minTextAdapt: true, splitScreenMode: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'User List',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Filter and Sort UI
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Country'),
                    value: userController.selectedCountry.value,
                    onChanged: (value) {
                      userController.selectedCountry.value = value ?? 'All';
                      userController.applyFiltersAndSorting();
                    },
                    items: userController.countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Gender'),
                    value: userController.selectedGender.value,
                    onChanged: (value) {
                      userController.selectedGender.value = value ?? 'All';
                      userController.applyFiltersAndSorting();
                    },
                    items: userController.genders.map((gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Sort By'),
                    value: userController.sortBy.value,
                    onChanged: (value) {
                      userController.sortBy.value = value ?? 'Name';
                      userController.applyFiltersAndSorting();
                    },
                    items: userController.sortOptions.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (userController.isLoading.value &&
                  userController.filteredUsers.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else if (userController.filteredUsers.isEmpty) {
                return Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 200.w,
                        child: Image.asset("assets/images/notfound.png")),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'No users found',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.sp),
                    ),
                  ],
                ));
              } else {
                return UserListWidget(
                  users: userController.filteredUsers,
                  hasMore: userController.hasMore.value,
                  scrollController: _scrollController,
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
