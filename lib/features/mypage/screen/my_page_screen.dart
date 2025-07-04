import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  bool _hasToken = true;

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
                //_hasToken 값에 따라 보여지는 뷰 선택
                child: _hasToken ? _buildLoggedInView() : _buildLoggedOutView(),
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
        const Row(
          children: [
            CircleAvatar(radius: 40, backgroundColor: Color(0xFF292929)),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('nickName', style: AppTextStyle.headline),
                SizedBox(height: 4),
                Text('user@example.com', style: AppTextStyle.headline),
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
            print('리뷰 목록 클릭');
            context.push('/mypage/detail', extra: 'my_review');
          },
        ),
        _buildMenuItem(
          title: '로그아웃',
          textStyle: AppTextStyle.body.copyWith(color: Colors.grey),
          onTap: () {
            //로그아웃 눌렀을 때 dialog로 더블체크
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  backgroundColor: Color(0xFF292929),
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
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                              setState(() {
                                _hasToken = false;
                              });
                              //todo 로그아웃 API
                              if (_hasToken == false) {
                                print("로그아웃 로직");
                                Fluttertoast.showToast(
                                  msg: "로그아웃 되었습니다.",
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 14.0,
                                );
                              }
                              print('로그아웃 클릭');
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
            /*setState(() {
              _hasToken = true;
            });*/
            //todo 로그인 API
            print('로그인하기 클릭');
            context.push(
              '/login',
              extra: () {
                setState(() {
                  _hasToken = true;
                });
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
