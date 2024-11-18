import 'package:flutter/material.dart';
import '../widgets/default_bottom_bar.dart';
import '../widgets/custom_spinner_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDefaultBottomBarVisible = true; // 현재 표시 중인 바
  bool isNavigationHidden = false; // 네비게이션 바 숨김 상태

  int spinner1Value = 0; // Spinner1 값 저장
  int spinner2Value = 0; // Spinner2 값 저장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 카메라 화면 (추후 내장 카메라 연동)
          GestureDetector(
            onTap: () {
              // 화면 클릭 시 네비게이션과 버튼 활성화
              if (isNavigationHidden) {
                setState(() {
                  isNavigationHidden = false;
                });
              }
            },
            child: Container(
              color: Colors.black, // 카메라 화면 대체용
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '카메라 미리보기 영역',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  // Spinner 값 출력
                  Text(
                    'Long Candle Value: $spinner1Value',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'Short Candle Value: $spinner2Value',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          // 하트 버튼
          if (!isNavigationHidden)
            Positioned(
              right: 20,
              bottom: 90, // 네비게이션 바로 위에 위치
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    isNavigationHidden = true; // 네비게이션 바 숨기기
                  });
                },
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.favorite),
              ),
            ),

          // 네비게이션 바
          if (!isNavigationHidden)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Stack(
                children: [
                  if (isDefaultBottomBarVisible)
                    AnimatedSlide(
                      offset: const Offset(0, 0),
                      duration: const Duration(milliseconds: 200),
                      child: DefaultBottomBar(
                        onSwitch: _switchToCustom, // 네비게이션 전환
                      ),
                    ),
                  if (!isDefaultBottomBarVisible)
                    AnimatedSlide(
                      offset: const Offset(0, 0),
                      duration: const Duration(milliseconds: 200),
                      child: CustomSpinnerBar(
                        onSwitch: _switchToDefault, // 네비게이션 전환
                        onSpinner1Changed: (value) {
                          setState(() {
                            spinner1Value = value; // Spinner1 값 업데이트
                          });
                        },
                        onSpinner2Changed: (value) {
                          setState(() {
                            spinner2Value = value; // Spinner2 값 업데이트
                          });
                        },
                        spinner1Value: spinner1Value, // 초기값 전달
                        spinner2Value: spinner2Value, // 초기값 전달
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _switchToCustom() async {
    if (!isDefaultBottomBarVisible) return; // 이미 전환 중이면 무시
    await _animateNavigation(() {
      isDefaultBottomBarVisible = false; // Default -> Custom
    });
  }

  Future<void> _switchToDefault() async {
    if (isDefaultBottomBarVisible) return; // 이미 전환 중이면 무시
    await _animateNavigation(() {
      isDefaultBottomBarVisible = true; // Custom -> Default
    });
  }

  Future<void> _animateNavigation(VoidCallback updateState) async {
    setState(() {}); // 애니메이션 시작 전 상태 갱신
    await Future.delayed(const Duration(milliseconds: 200)); // 애니메이션 대기
    setState(updateState); // 애니메이션 완료 후 상태 갱신
  }
}
