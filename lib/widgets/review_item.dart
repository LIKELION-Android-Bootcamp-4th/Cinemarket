import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatefulWidget {
  const ReviewItem({
    super.key,
    this.title = '',
    required this.productName,
    required this.movieTitle,
    this.productImage,
    this.initialRating = 0,
    this.initialReviewText = '',
    this.photoUrls = const [],
    this.onClick1,
    this.isClicked1 = false,
    this.onClick2,
    this.isClicked2 = false,
    this.isEditing = false,
    this.likeCount = 0,
  });

  final String title;
  final String productName;
  final String movieTitle;
  final String? productImage;
  final double initialRating;
  final String initialReviewText;
  final List<String> photoUrls;
  final VoidCallback? onClick1;
  final bool isClicked1;
  final VoidCallback? onClick2;
  final bool isClicked2;
  final bool isEditing;
  final int likeCount;

  @override
  State<StatefulWidget> createState() {
    return _ReviewItemState();
  }
}

class _ReviewItemState extends State<ReviewItem> {
  late double _currentRating;
  bool _isExpanded = false;
  late int _likeCount;
  late bool _isClicked1;
  late bool _isClicked2;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
    _likeCount = widget.likeCount;
    _isClicked1 = widget.isClicked1;
    _isClicked2 = widget.isClicked2;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProductInfo(),
          const SizedBox(height: 16.0),
          _buildStarRating(),
          const SizedBox(height: 16.0),
          _buildPhotoPreview(),
          const SizedBox(height: 16.0),
          _buildReviewText(),
          const SizedBox(height: 16.0),
          _buildActionButtons(context),
          const SizedBox(height: 24.0),
          Divider(thickness: 1,color: AppColors.widgetBackground,)
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showImageDialog(context, widget.productImage!),
          // 상품 이미지
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child:
                (widget.productImage != null && widget.productImage!.isNotEmpty)
                    ? Image.network(
                      widget.productImage!,
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: AppColors.widgetBackground,
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: const Icon(
                            Icons.broken_image,
                            color: AppColors.innerWidget,
                            size: 40,
                          ),
                        );
                      },
                    )
                    : Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: AppColors.widgetBackground,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: const Icon(
                        Icons.image_not_supported,
                        color: AppColors.widgetBackground,
                      ),
                    ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.productName, style: AppTextStyle.body),
              const SizedBox(height: 8.0),
              Text(widget.movieTitle, style: AppTextStyle.bodySmall),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStarRating() {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          child: Icon(
            index < _currentRating ? Icons.star : Icons.star_border,
            color: Colors.amberAccent,
            size: 36.0,
          ),
        );
      }),
    );
  }

  Widget _buildPhotoPreview() {
    if (widget.photoUrls.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.photoUrls.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8.0),
        itemBuilder: (context, index) {
          final url = widget.photoUrls[index];
          return GestureDetector(
            onTap: () => _showImageDialog(context, url),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: Image.network(
                url,
                width: 60.0,
                height: 60.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.widgetBackground,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(
                      Icons.broken_image,
                      color: AppColors.innerWidget,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviewText() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF292929),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Text(
            widget.initialReviewText.isNotEmpty
                ? widget.initialReviewText
                : "작성된 리뷰가 없습니다.",
            maxLines: _isExpanded ? null : 6,
            overflow:
                _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: AppTextStyle.body,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    String button1;
    String button2;

    if (widget.title == '나의 리뷰') {
      button1 = '수정';
      button2 = '삭제';
    } else if (widget.title == '리뷰 목록') {
      // button1 = _likeCount == 0 ? '좋아요' : '좋아요 $_likeCount';
      button1 = '좋아요';
      button2 = '싫어요';
    } else {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed:
                _isClicked2
                    ? null
                    : () {
                      if (widget.title == '리뷰 목록') {
                        setState(() {
                          _isClicked1 = !_isClicked1;

                          _isClicked1 ? _likeCount += 1 : _likeCount -= 1;
                        });
                        _isClicked1 ? CommonToast.show(context: context, message: '리뷰 좋아요 완료 !') : CommonToast.show(context: context, message: '리뷰 좋아요 해제 !');
                  }
                      widget.onClick1?.call();
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _isClicked1 && (_isClicked2 == false)
                      ? AppColors.textPoint
                      : AppColors.widgetBackground,
              disabledBackgroundColor: AppColors.widgetBackground,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            child: Text(button1, style: AppTextStyle.bodySmall),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: ElevatedButton(
            onPressed:
                _isClicked1
                    ? null
                    : () {
                      if (widget.title == '리뷰 목록') {
                        setState(() {
                          _isClicked2 = !_isClicked2;
                        });
                        _isClicked2 ? CommonToast.show(context: context, message: '리뷰 싫어요 완료 !') : CommonToast.show(context: context, message: '리뷰 싫어요 해제 !');
                      }
                      widget.onClick2?.call();
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _isClicked2 && (_isClicked1 == false)
                      ? AppColors.pointAccent
                      : AppColors.widgetBackground,
              disabledBackgroundColor: AppColors.widgetBackground,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            child: Text(button2, style: AppTextStyle.bodySmall),
          ),
        ),
      ],
    );
  }

  /// 이미지를 크게 보여주는 다이얼로그
  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              InteractiveViewer(
                panEnabled: true,
                boundaryMargin: const EdgeInsets.all(20),
                minScale: 0.5,
                maxScale: 4,
                child: Image.network(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.widgetBackground,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(
                        Icons.broken_image,
                        color: AppColors.innerWidget,
                        size: 100,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.widgetBackground,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
