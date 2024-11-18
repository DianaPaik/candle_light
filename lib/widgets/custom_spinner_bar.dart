import 'package:flutter/material.dart';

class CustomSpinnerBar extends StatefulWidget {
  final VoidCallback onSwitch;
  final ValueChanged<int> onSpinnerLongCandleChanged; // Long Candle 값 전달 콜백
  final ValueChanged<int> onSpinnerShortCandleChanged; // Short Candle 값 전달 콜백

  final ValueChanged<int> onNumberCandleValue1Changed;

  final ValueChanged<int> onNumberCandleValue2Changed;
  final ValueChanged<int> onNumberCandleValue3Changed;
  final int spinnerLongCandleValue; // 초기값
  final int spinnerShortCandleValue; // 초기값

  final int numberCandleValue1;
  final int numberCandleValue2;
  final int numberCandleValue3;

  final String type; // UI 타입 ('default', 'number', 'shape')

  const CustomSpinnerBar({
    super.key,
    required this.onSwitch,
    required this.onSpinnerLongCandleChanged,
    required this.onSpinnerShortCandleChanged,
    required this.onNumberCandleValue1Changed,
    required this.onNumberCandleValue2Changed,
    required this.onNumberCandleValue3Changed,
    required this.spinnerLongCandleValue,
    required this.spinnerShortCandleValue,
    required this.numberCandleValue1,
    required this.numberCandleValue2,
    required this.numberCandleValue3,
    required this.type,
  });

  @override
  _CustomSpinnerBarState createState() => _CustomSpinnerBarState();
}

class _CustomSpinnerBarState extends State<CustomSpinnerBar> {
  late int spinnerLongCandleValue;
  late int spinnerShortCandleValue;

  late int numberCandleValue1;
  late int numberCandleValue2;
  late int numberCandleValue3;

  @override
  void initState() {
    super.initState();
    spinnerLongCandleValue = widget.spinnerLongCandleValue; // 초기값 설정
    spinnerShortCandleValue = widget.spinnerShortCandleValue; // 초기값 설정
    numberCandleValue1 = widget.numberCandleValue1; // 초기값 설정
    numberCandleValue2 = widget.numberCandleValue2; // 초기값 설정
    numberCandleValue3 = widget.numberCandleValue3; // 초기값 설정
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('CustomSpinnerBar'),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.expand_more, color: Colors.black), // 화살표 아이콘
                onPressed: widget.onSwitch, // Back 기능
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (widget.type == 'default') _buildDefaultUI(), // 기본 UI
          if (widget.type == 'number') _buildThreeBoxUI(), // 세 개 박스 UI
        ],
      ),
    );
  }

  // 기본 UI
  Widget _buildDefaultUI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNumberSpinner('Long Candle', spinnerLongCandleValue, (value) {
          setState(() {
            spinnerLongCandleValue = value;
            widget.onSpinnerLongCandleChanged(value); // Long Candle 값 부모에 전달
          });
        }),
        _buildNumberSpinner('Short Candle', spinnerShortCandleValue, (value) {
          setState(() {
            spinnerShortCandleValue = value;
            widget.onSpinnerShortCandleChanged(value); // Short Candle 값 부모에 전달
          });
        }),
      ],
    );
  }

  // 세 개 박스 UI
  Widget _buildThreeBoxUI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNumberSpinner('Box 1', numberCandleValue1, (value) {
          setState(() {
            numberCandleValue1 = value;
            widget.onNumberCandleValue1Changed(value); // Long Candle 값 부모에 전달
          });
        }),
        _buildNumberSpinner('Box 2', numberCandleValue2, (value) {
          setState(() {
            numberCandleValue2 = value;
            widget.onNumberCandleValue2Changed(value); // Short Candle 값 부모에 전달
          });
        }),
        _buildNumberSpinner('Box 3', numberCandleValue3, (value) {
          setState(() {
            numberCandleValue3 = value; // 세 번째 박스 값 업데이트
            widget.onNumberCandleValue3Changed(value);
          });
        }),
      ],
    );
  }

  Widget _buildNumberSpinner(String label, int currentValue, ValueChanged<int> onChanged) {
    return Column(
      children: [
        Text(label),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (currentValue > 0) {
                  onChanged(currentValue - 1);
                }
              },
            ),
            Text(
              '$currentValue',
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (currentValue < 9) {
                  onChanged(currentValue + 1);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
