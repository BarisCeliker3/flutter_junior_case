import 'package:flutter/material.dart';

class PurchaseCard extends StatelessWidget {
  final String coin;
  final String amount;
  final String price;
  final bool selected;
  final VoidCallback? onTap;

  const PurchaseCard({
    Key? key,
    required this.coin,
    required this.amount,
    required this.price,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: selected
                ? [Color(0xFFE11D48), Color(0xFF7F3FFD)]
                : [Color(0xFF2D2D37), Color(0xFF2D2D37)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: selected ? Colors.white : Colors.white24,
            width: 2,
          ),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: Color(0xFFE11D48).withOpacity(0.15),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              coin,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              amount,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}