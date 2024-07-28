import 'package:comments_app_assignment/core/app_color.dart';
import 'package:comments_app_assignment/features/auth/presentation/providers/auth_provider.dart';
import 'package:comments_app_assignment/features/home/presentation/providers/comment_provider.dart';
import 'package:comments_app_assignment/global_widgets/app_appbar.dart';
import 'package:comments_app_assignment/global_widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/model/comment_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CommentProvider>(context, listen: false).fetchComments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserAuthProvider userAuthProvider =
        Provider.of<UserAuthProvider>(context, listen: false);

    final commentProvider = Provider.of<CommentProvider>(context);

    return AppScaffold(
      appBar: AppNewAppBar(
        height: 50.h,
        params: AppAppBarModel(
          title: "Comments",
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GestureDetector(
                onTap: userAuthProvider.logout,
                child: const Icon(Icons.exit_to_app, semanticLabel: "Logout"),
              ),
            )
          ],
        ),
      ),
      body: Consumer<CommentProvider>(
        builder: (context, provider, child) => provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : provider.errorMessage.isNotEmpty
                ? Center(
                    child: Text(commentProvider.errorMessage),
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.h),
                      itemCount: commentProvider.comments.length,
                      itemBuilder: (context, index) {
                        return CommentCardWidget(
                          comment: commentProvider.comments[index],
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}

class CommentCardWidget extends StatelessWidget {
  final Comment comment;
  const CommentCardWidget({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundColor: AppColor.greyColor,
              child: Text(
                comment.name[0].toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondaryColor,
                    ),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Name: ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColor.greyColor,
                              fontStyle: FontStyle.italic,
                              fontSize: 14.sp,
                            ),
                      ),
                      Expanded(
                        child: Text(
                          comment.name,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Email: ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColor.greyColor,
                              fontStyle: FontStyle.italic,
                              fontSize: 14.sp,
                            ),
                      ),
                      Expanded(
                        child: Text(
                          comment.email,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    comment.body,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
