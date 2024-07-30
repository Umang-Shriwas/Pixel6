import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel6/usermodel.dart';

class UserListWidget extends StatelessWidget {
  final List<User> users;
  final bool hasMore;
  final ScrollController scrollController;

  const UserListWidget({
    required this.users,
    required this.hasMore,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: users.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < users.length) {
          final user = users[index];
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xff00999E),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 1,
                            blurRadius: 1.h)
                      ],
                      borderRadius: BorderRadius.circular(20.r)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(user.imageUrl),
                    ),
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Age: ${user.age},',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Gender: ${user.gender}',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          ' ${user.company.title}',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Country: ${user.address.country}',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return LoadingIndicator(); // Show the loader at the end of the list
        }
      },
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
