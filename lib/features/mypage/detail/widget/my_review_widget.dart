import 'package:cinemarket/features/mypage/viewmodel/review_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:cinemarket/widgets/review_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class MyReviewWidget extends StatefulWidget {
  const MyReviewWidget({super.key,});

  @override
  State<MyReviewWidget> createState() => _MyReviewWidgetState();
}

class _MyReviewWidgetState extends State<MyReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = ReviewViewModel();
        vm.loadReviews();
        return vm;
      },
      child: Consumer<ReviewViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) return Center(child: CircularProgressIndicator());
          if (vm.errorMessage != null)
            return Center(child: Text(vm.errorMessage!));
          if (vm.reviews.isEmpty) return Center(child: Text('리뷰가 없습니다.'));

          return ListView.builder(
            itemCount: vm.reviews.length,
            itemBuilder: (context, index) {
              final review = vm.reviews[index];
              return ReviewItem(
                title: '나의 리뷰',
                productName: review.product.name,
                movieTitle: review.movieTitle,
                productImage: review.product.mainImageUrl,
                initialRating: review.rating.toDouble(),
                initialReviewText: review.comment,
                photoUrls: review.images.map((e) => e.url).toList(),
                isEditing: false,
                //리뷰 수정 페이지로 이동..
                onClick1: () async {
                  final result = await context.push<bool>(
                    '/mypage/detail',
                    extra: {
                      'where': 'fix_review',
                      'review': review,
                    },
                  );
                  if (result == true) {
                    vm.loadReviews();
                  }
                },
                //리뷰 삭제 기능.
                onClick2: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        backgroundColor: Color(0xFF292929),
                        title: const Text('리뷰삭제', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                        content: const Text("리뷰를 삭제 하시겠습니까?", style: TextStyle(color: Colors.white70, fontSize: 18.0)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(false),
                            child: const Text('유지하기', style: TextStyle(color: Colors.red)),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(true),
                            child: const Text('삭제하기', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      );
                    }
                  );

                  if (confirm != true) return;

                  final success = await vm.deleteReviewById(review.id);

                  if (success) {
                    CommonToast.show(context: context, message: '리뷰가 삭제 되었습니다.',type: ToastificationType.success);
                  } else {
                    CommonToast.show(context: context, message: '리뷰 삭제에 실패했습니다.',type: ToastificationType.error);
                  }
                },
              );
            },
          );
        }
      ),
    );
  }
}
