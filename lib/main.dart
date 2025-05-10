import 'package:flutter/material.dart';

// الدالة الرئيسية لتشغيل التطبيق
void main() {
  runApp(const MyApp());
}

// مكون التطبيق الرئيسي
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Card', // عنوان التطبيق
      theme: ThemeData(primarySwatch: Colors.blue), // تحديد موضوع التطبيق
      home: const ProductCard(), // تحديد الشاشة الرئيسية
    );
  }
}

// مكون بطاقة المنتج (يستخدم StatefulWidget لأنه يحتوي على حالة متغيرة)
class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // المتغيرات التي تخزن الكمية وسعر المنتج
  int quantity = 1; // الكمية الافتراضية
  double price = 50.0; // السعر الافتراضي

  // دالة لزيادة الكمية عند الضغط على زر "زيادة الكمية"
  void increaseQuantity() {
    setState(() {
      quantity++; // زيادة الكمية بمقدار 1
    });
  }

  // دالة تعرض رسالة عند الشراء
  void buyProduct() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('شراء المنتج'), // عنوان نافذة التنبيه
        content: Text('تم شراء المنتج بكمية: $quantity'), // محتوى النافذة
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // غلق النافذة عند الضغط
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بطاقة المنتج')), // شريط العنوان
      body: Padding(
        padding: const EdgeInsets.all(16.0), // حواف حول البطاقة
        child: Card(
          elevation: 5, // ارتفاع البطاقة عن الخلفية
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // زوايا مستديرة
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0), // حواف داخل البطاقة
            child: Column(
              mainAxisSize: MainAxisSize.min, // جعل العمود بحجم المحتوى فقط
              crossAxisAlignment: CrossAxisAlignment.start, // محاذاة لليسار
              children: [
                // نص يعرض اسم المنتج
                const Text(
                  'منتج رائع',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10), // مسافة بين النص والسعر
                // نص يعرض سعر المنتج
                Text(
                  'السعر: \$${price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),
                const SizedBox(height: 10), // مسافة بين السعر والأزرار
                Row(
                  children: [
                    // زر الشراء
                    ElevatedButton(
                      onPressed: buyProduct, // استدعاء دالة الشراء عند الضغط
                      child: const Text('شراء'),
                    ),
                    const SizedBox(width: 10), // مسافة بين الأزرار
                    // زر زيادة الكمية
                    ElevatedButton(
                      onPressed: increaseQuantity, // استدعاء دالة الزيادة
                      child: const Text('+ زيادة الكمية'),
                    ),
                    const SizedBox(width: 10), // مسافة قبل عرض الكمية
                    // نص يعرض الكمية الحالية
                    Text(
                      'الكمية: $quantity',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
