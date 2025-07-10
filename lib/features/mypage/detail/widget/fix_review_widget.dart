import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class FixReviewWidget extends StatefulWidget {
  const FixReviewWidget({super.key, int? int});

  @override
  State<StatefulWidget> createState() => _FixReviewWidgetState();
}

class _FixReviewWidgetState extends State<FixReviewWidget> {
  int _selectedStar = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    _selectedStar = 1;
    super.initState();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProductInfo(),
                SizedBox(height: 32),
                Divider(
                  height: 5.0,
                  thickness: 5.0,
                  color: AppColors.widgetBackground,
                ),
                SizedBox(height: 32),
                Text(
                  "상품에 만족 하셨나요 ?",
                  style: AppTextStyle.section,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                _buildStarRating(),
                SizedBox(height: 24),
                Text(
                  "어떤 점이 좋았나요 ?",
                  style: AppTextStyle.section,
                  textAlign: TextAlign.center,
                ),
                _buildReviewTextField(),
                _buildSelectPicture(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectPicture() {
    return Container(
      padding: EdgeInsets.all(24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.widgetBackground,
          minimumSize: Size(double.infinity, 70.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          print("hi");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 35,
              color: AppColors.textPrimary,
            ),
            SizedBox(width: 5,),
            Text("사진 첨부하기", style: AppTextStyle.section),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewTextField() {
    return Container(
      padding: EdgeInsets.all(24),
      child: TextField(
        controller: _reviewController,
        maxLines: 6,
        decoration: InputDecoration(
          hintText: '리뷰를 작성해주세요.',
          hintStyle: AppTextStyle.body,
          contentPadding: EdgeInsets.all(16),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _selectedStar ? Icons.star : Icons.star_border,
            color:
                index < _selectedStar
                    ? AppColors.selectedStar
                    : AppColors.unselectedStar.withOpacity(0.5),
            size: 50,
          ),
          onPressed: () {
            setState(() {
              _selectedStar = index + 1;
            });
          },
        );
      }),
    );
  }
}

Widget _buildProductInfo() {
  return Container(
    padding: EdgeInsets.all(24),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Image.network(
            "https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616",
            height: 130,
            width: 130,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("상품명", style: AppTextStyle.body),
              SizedBox(height: 4.0),
              Text("상품설명", style: AppTextStyle.body),
              SizedBox(height: 4.0),
              Text("선택옵션", style: AppTextStyle.body),
            ],
          ),
        ),
      ],
    ),
  );
}
