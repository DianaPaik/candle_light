import 'package:flutter/material.dart';

class DefaultBottomBar extends StatelessWidget {
  final ValueChanged<String> onSwitch; // String 타입 전달 콜백

  const DefaultBottomBar({super.key, required this.onSwitch});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;

    return Container(
      key: const ValueKey('DefaultBottomBar'),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildButtonColumn(color, Icons.call, '초', () => onSwitch('default')), // 기본 UI
          _buildButtonColumn(color, Icons.near_me, '숫자초', () => onSwitch('number')), // 숫자 UI
          _buildButtonColumn(color, Icons.share, '모양초', () => onSwitch('shape')), // 모양 UI
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label, VoidCallback onPressed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon, color: color),
          onPressed: onPressed,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}
