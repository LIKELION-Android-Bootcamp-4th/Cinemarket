import 'dart:convert';

import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:cinemarket/features/auth/viewmodel/my_page_viewmodel.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  late MyPageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MyPageViewModel();
    _viewModel.addListener(_onViewModelChanged);
    _viewModel.initialize();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child:
                _viewModel.hasToken
                    ? _buildLoggedInView()
                    : _buildLoggedOutView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoggedInView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.widgetBackground,
              ),
              child:
              _viewModel.profileImage != null &&
                  _viewModel.profileImage!.isNotEmpty
                  ? ClipOval(
                child: Image.memory(
                  base64Decode(_viewModel.profileImage.toString()),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.widgetBackground,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    );
                  },
                ),
              )
                  : Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.widgetBackground,
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _viewModel.nickname ?? 'nickName',
                      style: AppTextStyle.headline,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: 4),

                SizedBox(
                  width: 250,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _viewModel.email ?? 'user@example.com',
                      style: AppTextStyle.headline,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),


              ],
            ),
          ],
        ),
        const SizedBox(height: 60),
        _buildMenuItem(
          title: '회원 정보 수정',
          textStyle: AppTextStyle.body,
          onTap: () {
            print('회원 정보 수정 클릭');
            context.push('/mypage/detail', extra: 'edit_profile');
          },
        ),
        _buildMenuItem(
          title: '배송 조회',
          textStyle: AppTextStyle.body,
          onTap: () {
            print('배송 조회 클릭');
            context.push('/mypage/detail', extra: 'order_tracking');
          },
        ),

        _buildMenuItem(
          title: '주문 내역',
          textStyle: AppTextStyle.body,
          onTap: () {
            print('주문 내역 클릭');
            context.push('/mypage/detail', extra: 'order_history');
          },
        ),
        _buildMenuItem(
          title: '리뷰 목록',
          textStyle: AppTextStyle.body,
          onTap: () {
            print('나의 리뷰 목록 클릭');
            context.push('/mypage/detail', extra: 'my_review');
          },
        ),
        _buildMenuItem(
          title: '로그아웃',
          textStyle: AppTextStyle.body.copyWith(color: Colors.grey),
          onTap: () async {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  backgroundColor: AppColors.widgetBackground,
                  title: Text(
                    '로그아웃',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  content: Text(
                    "로그아웃 하시겠습니까?",
                    style: TextStyle(color: Colors.white70, fontSize: 18.0),
                  ),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: Text(
                              '로그인 유지하기',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                            },
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            child: Text(
                              '로그아웃',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              Navigator.of(dialogContext).pop();
                              try {
                                await _viewModel.logout();
                                CommonToast.show(
                                  context: context,
                                  message: "로그아웃 되었습니다.",
                                  type: ToastificationType.success,
                                );
                              } catch (e) {
                                CommonToast.show(
                                  context: context,
                                  message: "로그아웃 실패: $e",
                                  type: ToastificationType.error,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildLoggedOutView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildMenuItem(
          title: '로그인하기',
          textStyle: AppTextStyle.headline,
          onTap: () {
            print('로그인하기 클릭');
            context.push(
              '/login',
              extra: () {
                _viewModel.onLoginSuccess();
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String title,
    required TextStyle textStyle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(title, style: textStyle),
      ),
    );
  }
}
