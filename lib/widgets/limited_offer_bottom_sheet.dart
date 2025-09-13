import 'package:flutter/material.dart';

class LimitedOfferBottomSheet extends StatelessWidget {
  const LimitedOfferBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Color(0xFF18181B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Sınırlı Teklif!',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 13),
          const Text(
            'Bu fırsatı kaçırmayın!\nSize özel paket seçenekleri:',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15.5,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22),
          _OfferPackageTile(
            title: "3.375 Jeton",
            price: "₺799,90",
            highlight: true,
            onTap: () {},
          ),
          const SizedBox(height: 14),
          _OfferPackageTile(
            title: "2.000 Jeton",
            price: "₺499,90",
            highlight: false,
            onTap: () {},
          ),
          const SizedBox(height: 14),
          _OfferPackageTile(
            title: "1.000 Jeton",
            price: "₺299,90",
            highlight: false,
            onTap: () {},
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white54,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                letterSpacing: 0.1,
              ),
            ),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }
}

class _OfferPackageTile extends StatelessWidget {
  final String title;
  final String price;
  final bool highlight;
  final VoidCallback onTap;

  const _OfferPackageTile({
    required this.title,
    required this.price,
    required this.highlight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = highlight
        ? const LinearGradient(
            colors: [Color(0xFF7F3FFD), Color(0xFFE11D48)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : const LinearGradient(
            colors: [Color(0xFF232326), Color(0xFF18181B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: gradient,
          border: Border.all(
            color: highlight ? Colors.white : Colors.white24,
            width: 2,
          ),
          boxShadow: highlight
              ? [
                  BoxShadow(
                    color: const Color(0xFFE11D48).withOpacity(0.14),
                    blurRadius: 16,
                    offset: const Offset(0, 7),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(highlight ? 1 : 0.92),
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 7, horizontal: 18),
              decoration: BoxDecoration(
                color: highlight
                    ? Colors.white.withOpacity(0.20)
                    : Colors.white.withOpacity(0.10),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: highlight
                      ? Colors.white.withOpacity(0.45)
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}