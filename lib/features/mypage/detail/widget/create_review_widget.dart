import 'dart:io';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/mypage/model/orderdetail/order_detail_item.dart';
import 'package:cinemarket/features/mypage/model/review_request.dart';
import 'package:cinemarket/features/mypage/viewmodel/review_viewmodel.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class CreateReviewWidget extends StatefulWidget {
  final OrderDetailItem orderItem;

  const CreateReviewWidget({super.key, required this.orderItem});

  @override
  State<CreateReviewWidget> createState() => _CreateReviewWidgetState();
}

class _CreateReviewWidgetState extends State<CreateReviewWidget> {
  int _selectedStar = 1;
  final TextEditingController _reviewController = TextEditingController();
  List<XFile> _newImages = [];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> picked = await picker.pickMultiImage();

    if (picked.isEmpty) return;

    final remainingSlots = 5 - _newImages.length;

    if (remainingSlots <= 0) {
      CommonToast.show(
        context: context,
        message: '이미지는 최대 5장까지 첨부할 수 있습니다.',
        type: ToastificationType.warning,
      );
      return;
    }

    final imagesToAdd = picked.take(remainingSlots).toList();

    setState(() {
      _newImages.addAll(imagesToAdd);
    });

    if (picked.length > imagesToAdd.length) {
      CommonToast.show(
        context: context,
        message: '최대 5장까지만 첨부됩니다. 일부 이미지는 제외되었습니다.',
        type: ToastificationType.info,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReviewViewModel(),
      child: Consumer<ReviewViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: const CommonAppBar(title: "리뷰 작성"),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildProductInfo(),
                      const SizedBox(height: 32),
                      const Divider(thickness: 1.0, color: AppColors.widgetBackground,),
                      const SizedBox(height: 32),
                      Text('상품에 만족 하셨나요?', style: AppTextStyle.section, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      _buildStarRating(),
                      const SizedBox(height: 24),
                      Text('어떤 점이 좋았나요', style: AppTextStyle.section, textAlign: TextAlign.center),
                      _buildReviewTextField(),
                      const SizedBox(height: 16),
                      _buildPhotoPreview(),
                      _buildSelectPicture(),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 55),
                          ),
                          onPressed: () async {
                            final vm = context.read<ReviewViewModel>();

                            if (_reviewController.text.trim().isEmpty) {
                              CommonToast.show(
                                context: context,
                                message: '리뷰 내용을 입력해주세요.',
                                type: ToastificationType.warning,
                              );
                              return;
                            }

                            if (_newImages.length > 5) {
                              CommonToast.show(
                                context: context,
                                message: '이미지는 최대 5개까지 업로드 가능합니다.',
                                type: ToastificationType.warning,
                              );
                              return;
                            }

                            final List<MultipartFile> imageFiles = [];
                            for (final image in _newImages) {
                              final file = File(image.path);
                              final fileName = image.name;

                              imageFiles.add(await MultipartFile.fromFile(
                                file.path,
                                filename: fileName,
                              ));
                            }

                            final request = ReviewRequest(
                              rating: _selectedStar,
                              comment: _reviewController.text,
                              images: imageFiles,
                              orderId: null, // optional
                            );

                            final success = await vm.submitReview(
                              productId: widget.orderItem.id,
                              request: request,
                            );

                            if (success) {
                              CommonToast.show(
                                context: context,
                                message: '리뷰가 등록되었습니다.',
                                type: ToastificationType.success,
                              );
                              Navigator.pop(context, true); // <-- 정상적으로 뒤로 이동
                            } else {
                              CommonToast.show(
                                context: context,
                                message: vm.errorMessage ?? '리뷰 등록에 실패했습니다.',
                                type: ToastificationType.error,
                              );
                            }

                          }
                          ,
                          child: const Text("리뷰 등록하기"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          );
        },
      ),
    );
  }

  Widget _buildProductInfo() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: Image.network(
              widget.orderItem.productImage ?? '',
              height: 130,
              width: 130,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.orderItem.productName ?? '상품명 없음', style: AppTextStyle.bodyLarge,maxLines: 2, overflow: TextOverflow.ellipsis,),
                const SizedBox(height: 10),
                // Text(widget.orderItem.movieTitle ?? '', style: AppTextStyle.body),

                Text(widget.orderItem.quantity.toString() + '개', style: AppTextStyle.body)
                // 가격..
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewTextField() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: TextField(
        controller: _reviewController,
        maxLines: 6,
        decoration: InputDecoration(
          hintText: '리뷰를 작성해주세요.',
          hintStyle: AppTextStyle.body,
          contentPadding: const EdgeInsets.all(16),
          fillColor: AppColors.widgetBackground,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: AppTextStyle.body,
      ),
    );
  }

  Widget _buildStarRating() {
    return Center(
      child: RatingBar.builder(
        initialRating: _selectedStar.toDouble(),
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemSize: 50,
        unratedColor: AppColors.unselectedStar.withOpacity(0.5),
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: AppColors.selectedStar,
        ),
        onRatingUpdate: (rating) {
          setState(() {
            _selectedStar = rating.toInt();
          });
        },
      ),
    );
  }

  Widget _buildPhotoPreview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _newImages.asMap().entries.map((entry) {
          final index = entry.key;
          final image = entry.value;

          return Stack(
            children: [
              Image.file(
                File(image.path),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _newImages.removeAt(index);
                    });
                  },
                  child: const Icon(Icons.cancel, color: Colors.red),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }


  Widget _buildSelectPicture() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.widgetBackground,
          minimumSize: const Size(double.infinity, 70.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onPressed: _pickImages,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt_outlined, size: 35, color: AppColors.textPrimary),
            const SizedBox(width: 5),
            Text("사진 첨부하기", style: AppTextStyle.section),
          ],
        ),
      ),
    );
  }
}
