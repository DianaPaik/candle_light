import 'package:flutter/material.dart';
import '../widgets/default_bottom_bar.dart';
import '../widgets/custom_spinner_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isNavigationHidden = false; // 네비게이션 바 숨김 상태
  String currentType = 'default'; // 현재 네비게이션 타입 ('default', 'number', 'shape')

  int spinnerLongCandleValue = 0; // Long Candle 값 저장
  int spinnerShortCandleValue = 0; // Short Candle 값 저장

  int numberCandleValue1 = 0;
  int numberCandleValue2 = 0;
  int numberCandleValue3 = 0;

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
                    'Long Candle Value: $spinnerLongCandleValue',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'Short Candle Value: $spinnerShortCandleValue',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'Number Candle Value1: $numberCandleValue1',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'Number Candle Value2: $numberCandleValue2',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'Number Candle Value3: $numberCandleValue3',
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
                  if (currentType == 'default')
                    AnimatedSlide(
                      offset: const Offset(0, 0),
                      duration: const Duration(milliseconds: 200),
                      child: DefaultBottomBar(
                        onSwitch: (type) {
                          _switchToCustom(type); // 네비게이션 전환
                        },
                      ),
                    ),
                  if (currentType == 'number')
                    AnimatedSlide(
                      offset: const Offset(0, 0),
                      duration: const Duration(milliseconds: 200),
                      child: CustomSpinnerBar(
                        onSwitch: _switchToDefault, // 네비게이션 전환
                        onSpinnerLongCandleChanged: (value) {
                          setState(() {
                            spinnerLongCandleValue = value; // Long Candle 값 업데이트
                          });
                        },
                        onSpinnerShortCandleChanged: (value) {
                          setState(() {
                            spinnerShortCandleValue = value; // Long Candle 값 업데이트
                          });
                        },
                        onNumberCandleValue1Changed: (value) {
                          setState(() {
                            numberCandleValue1 = value; // Long Candle 값 업데이트
                          });
                        },
                        onNumberCandleValue2Changed: (value) {
                          setState(() {
                            numberCandleValue2 = value; // Short Candle 값 업데이트
                          });
                        },
                        onNumberCandleValue3Changed: (value) {
                          setState(() {
                            numberCandleValue3 = value; // Short Candle 값 업데이트
                          });
                        },

                        spinnerLongCandleValue: spinnerLongCandleValue,
                        spinnerShortCandleValue: spinnerShortCandleValue,
                        numberCandleValue1: numberCandleValue1, // 초기값 전달
                        numberCandleValue2: numberCandleValue2,
                        numberCandleValue3: numberCandleValue3,// 초기값 전

                        type: currentType, // CustomSpinnerBar에 타입 전달
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _switchToCustom(String type) async {
    setState(() {
      currentType = type; // 선택된 타입으로 변경
    });
  }

  Future<void> _switchToDefault() async {
    setState(() {
      currentType = 'default'; // 기본 네비게이션으로 복귀
    });
  }
}
