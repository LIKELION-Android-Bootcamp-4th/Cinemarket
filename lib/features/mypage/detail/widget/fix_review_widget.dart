import 'dart:io';

import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/mypage/model/review.dart';
import 'package:cinemarket/features/mypage/viewmodel/review_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class FixReviewWidget extends StatefulWidget {
  final Review review;
  const FixReviewWidget({super.key, required this.review});

  @override
  State<StatefulWidget> createState() => _FixReviewWidgetState();
}

class _FixReviewWidgetState extends State<FixReviewWidget> {
  int _selectedStar = 1;
  final TextEditingController _reviewController = TextEditingController();

  late List<String> _keepImageIds;
  List<XFile> _newImages = [];

  @override
  void initState() {
    super.initState();
    _selectedStar = widget.review.rating;
    _reviewController.text = widget.review.comment;
    _keepImageIds = widget.review.images.map((e) => e.id).toList();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> picked = await picker.pickMultiImage();

    final totalImages = _keepImageIds.length + _newImages.length;

    if (picked.isNotEmpty) {
      if (totalImages + picked.length > 5) {
        final available = 5 - totalImages;
        if (available <= 0) {
          CommonToast.show(
            context: context,
            message: '이미지는 최대 5개까지 첨부할 수 있습니다.',
            type: ToastificationType.error,
          );
          return;
        }

        setState(() {
          _newImages.addAll(picked.take(available));
        });

        CommonToast.show(
          context: context,
          message: '$available장 추가되었습니다. 최대 5장까지 가능합니다.',
          type: ToastificationType.info,
        );
      } else {
        setState(() {
          _newImages.addAll(picked);
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReviewViewModel(),
      child: Consumer<ReviewViewModel>(
        builder: (context, vm, child) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildProductInfo(),
                      const SizedBox(height: 32),
                      const Divider(
                        height: 5.0,
                        thickness: 5.0,
                        color: AppColors.widgetBackground,
                      ),
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
                            final success = await vm.updateReview(
                              reviewId: widget.review.id,
                              rating: _selectedStar,
                              comment: _reviewController.text,
                              keepImageIds: _keepImageIds,
                              newImages:
                              _newImages.map((e) => File(e.path)).toList(),
                            );
                            if (success) {
                              CommonToast.show(
                                context: context,
                                message: '리뷰가 수정되었습니다.',
                                type: ToastificationType.success,
                              );
                              Navigator.pop(context,true);
                            } else {
                              CommonToast.show(
                                context: context,
                                message: '리뷰 수정에 실패했습니다.',
                                type: ToastificationType.error,
                              );
                            }
                          },
                          child: const Text("리뷰 수정하기"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      )
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
              widget.review.product.mainImageUrl,
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
                Text(widget.review.product.name, style: AppTextStyle.body),
                const SizedBox(height: 4.0),
                Text(widget.review.movieTitle, style: AppTextStyle.body),
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
    final keptImages = widget.review.images.where((e) => _keepImageIds.contains(e.id)).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          //기존 이미지
          ...keptImages.map((e) => Stack(
            children: [
              Image.network(e.url, width: 100, height: 100, fit: BoxFit.cover),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _keepImageIds.remove(e.id);
                    });
                  },
                  child: const Icon(Icons.cancel, color: Colors.red),
                ),
              ),
            ],
          )),

          //새로 추가한 이미지도 삭제 가능하도록 변경
          ..._newImages.asMap().entries.map((entry) {
            final index = entry.key;
            final image = entry.value;
            return Stack(
              children: [
                Image.file(File(image.path), width: 100, height: 100, fit: BoxFit.cover),
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
          }),
        ],
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