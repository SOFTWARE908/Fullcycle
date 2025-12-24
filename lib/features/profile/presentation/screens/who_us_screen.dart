import 'package:flutter/material.dart';

class WhoUsScreen extends StatelessWidget {
  const WhoUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تعرف عنا',
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionText(
              text:
                  'شركة FullCycleهي شركة سعودية متخصصة في مجال إدارة الفعاليات، '
                  'تهدف إلى تقديم خدمات لوجستية وتشغيلية واستشارية متطورة، '
                  'تعتمد على أعلى معايير الجودة والاحترافية.',
            ),
            SizedBox(height: 16),
            _SectionText(
              text:
                  'نعمل على تشكيل وتنفيذ عمليات الفعاليات بأسلوب احترافي يضمن '
                  'تحقيق تجربة مميزة، من خلال التخطيط الدقيق، والتنفيذ المتكامل، '
                  'والاهتمام بأدق التفاصيل.',
            ),
            SizedBox(height: 16),
            _SectionText(
              text: 'نسعى في FullCycleإلى دعم نجاح الفعاليات بمختلف أنواعها، '
                  'وتقديم حلول عملية ومبتكرة تسهم في رفع كفاءة التشغيل '
                  'وتحقيق التميز في إدارة وتنظيم الفعاليات.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionText extends StatelessWidget {
  final String text;

  const _SectionText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.right,
      style: const TextStyle(
        fontSize: 16,
        height: 1.7,
        color: Colors.black87,
      ),
    );
  }
}
