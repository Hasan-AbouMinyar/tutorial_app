import 'package:flutter/material.dart'; // مكتبة Flutter لإنشاء واجهات المستخدم باستخدام Widgets

void main() {
  runApp(TodoApp()); // استدعاء الدالة الرئيسية لتشغيل التطبيق، وتحديد TodoApp كواجهة البداية
}

class TodoApp extends StatelessWidget { // تعريف تطبيق TodoApp كـ StatelessWidget لأنه لا يحتاج إلى حالة متغيرة
  const TodoApp({super.key}); // مُنشئ (constructor) لتطبيق TodoApp مع مفتاح فريد (key) لتحديد العنصر

  @override
  Widget build(BuildContext context) { // دالة build تُنشئ واجهة المستخدم للتطبيق
    return MaterialApp( // MaterialApp هو Widget رئيسي يوفر إعدادات التطبيق مثل الثيم والصفحة الرئيسية
      debugShowCheckedModeBanner: false, // إخفاء شريط "Debug" الذي يظهر في الزاوية العلوية اليمنى أثناء التطوير
      title: "Task Management", // عنوان التطبيق الذي يظهر في بعض الأنظمة
      theme: ThemeData( // ThemeData لتحديد الثيم الخاص بالتطبيق
        primaryColor: Colors.black, // اللون الأساسي للتطبيق (أسود)
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey[800]), // تحديد اللون الثانوي (رمادي داكن)
        scaffoldBackgroundColor: Colors.white, // لون خلفية التطبيق (أبيض)
        textTheme: TextTheme( // تحديد أنماط النصوص المستخدمة في التطبيق
          bodyLarge: TextStyle(color: Colors.black, fontFamily: 'San Francisco', fontSize: 16), // تنسيق النصوص الكبيرة
          bodyMedium: TextStyle(color: Colors.grey[700], fontFamily: 'San Francisco', fontSize: 14), // تنسيق النصوص المتوسطة
        ),
      ),
      home: HomePage(), // تحديد الصفحة الرئيسية للتطبيق وهي HomePage
    );
  }
}

class HomePage extends StatefulWidget { // تعريف الصفحة الرئيسية كـ StatefulWidget لأنها تحتاج إلى حالة متغيرة
  const HomePage({super.key}); // مُنشئ (constructor) للصفحة الرئيسية مع مفتاح فريد (key)

  @override
  State<HomePage> createState() => _HomePageState(); // إنشاء الحالة الخاصة بالصفحة الرئيسية
}

class _HomePageState extends State<HomePage> { // تعريف الحالة الخاصة بالصفحة الرئيسية
  List<Map<String, dynamic>> tasks = []; // قائمة لتخزين المهام، كل مهمة عبارة عن خريطة تحتوي على الاسم وحالة الإنجاز
  List<Map<String, dynamic>> allTasks = []; // قائمة لتخزين جميع المهام دون تصفية

  void _showAddTaskDialog() { // دالة لعرض نافذة حوار لإضافة مهمة جديدة
    String newTask = ""; // متغير لتخزين اسم المهمة الجديدة

    showDialog( // دالة لعرض نافذة حوار
      context: context, // السياق الحالي للتطبيق
      builder: (context) { // بناء نافذة الحوار
        return AlertDialog( // نافذة حوار من نوع AlertDialog
          title: Text("Add New Task", style: TextStyle(fontWeight: FontWeight.bold)), // عنوان نافذة الحوار
          content: TextField( // حقل إدخال نص لإدخال اسم المهمة
            onChanged: (value) { // استدعاء عند تغيير النص داخل الحقل
              newTask = value; // تحديث اسم المهمة الجديدة عند الكتابة
            },
            decoration: InputDecoration( // تحديد تصميم حقل الإدخال
              hintText: "Enter task name", // نص إرشادي داخل حقل الإدخال
              border: OutlineInputBorder(), // إطار حول حقل الإدخال
            ),
          ),
          actions: [ // أزرار التحكم في نافذة الحوار
            TextButton( // زر نصي
              onPressed: () { // استدعاء عند الضغط على الزر
                Navigator.of(context).pop(); // إغلاق نافذة الحوار
              },
              child: Text("Cancel", style: TextStyle(color: Colors.red)), // نص الزر (إلغاء) مع لون أحمر
            ),
            TextButton( // زر نصي آخر
              onPressed: () { // استدعاء عند الضغط على الزر
                if (newTask.isNotEmpty) { // التحقق من أن النص غير فارغ
                  setState(() { // تحديث حالة التطبيق
                    allTasks.add({"name": newTask, "completed": false}); // إضافة المهمة إلى القائمة الكاملة
                    tasks = List.from(allTasks); // تحديث المهام المعروضة
                  });
                }
                Navigator.of(context).pop(); // إغلاق نافذة الحوار بعد الإضافة
              },
              child: Text("Add", style: TextStyle(color: Colors.blue)), // نص الزر (إضافة) مع لون أزرق
            ),
          ],
        );
      },
    );
  }

  void _toggleTaskCompletion(int index) { // دالة لتبديل حالة الإنجاز للمهمة
    setState(() { // تحديث حالة التطبيق
      tasks[index]["completed"] = !tasks[index]["completed"]; // عكس حالة الإنجاز للمهمة
      allTasks[allTasks.indexOf(tasks[index])]["completed"] = tasks[index]["completed"];
    });
  }

  void _deleteTask(int index) { // دالة لحذف مهمة من القائمة
    setState(() { // تحديث حالة التطبيق
      allTasks.remove(tasks[index]);
      tasks.removeAt(index); // حذف المهمة بناءً على الفهرس
    });
  }

  void _filterTasks(bool showCompleted) { // تصفية المهام بناءً على حالتها (منجزة أو غير منجزة)
    setState(() {
      tasks = allTasks.where((task) => task["completed"] == showCompleted).toList(); // تصفية المهام بناءً على حالتها
    });
  }

  @override
  Widget build(BuildContext context) { // دالة build لإنشاء واجهة المستخدم للصفحة الرئيسية
    return Scaffold( // Scaffold هو Widget يوفر بنية أساسية للصفحة مثل AppBar و Body
      appBar: AppBar( // شريط العنوان في أعلى الصفحة
        title: Text( // عنوان التطبيق
          "Task Management", // نص العنوان
          style: TextStyle(
            fontWeight: FontWeight.bold, // جعل النص عريضًا
            color: Colors.white, // لون النص أبيض
          ),
        ),
        actions: [ // أزرار إضافية في شريط العنوان
          MouseRegion( // إضافة تأثير hover على الأيقونة
            cursor: SystemMouseCursors.click, // تغيير المؤشر عند التمرير فوق الأيقونة
            child: GestureDetector( // إضافة تفاعل عند الضغط على الأيقونة
              onTapDown: (_) {
                setState(() {
                  // تغيير لون الأيقونة مؤقتًا عند الضغط
                  tasks = allTasks.where((task) => task["completed"] == false).toList();
                });
              },
              onTapUp: (_) {
                setState(() {
                  // إعادة اللون الأصلي بعد الضغط
                });
              },
              child: IconButton(
                icon: Icon(Icons.radio_button_unchecked, color: Colors.white), // أيقونة للمهام غير المنجزة
                onPressed: () => _filterTasks(false), // استدعاء دالة تصفية المهام غير المنجزة عند الضغط
                tooltip: "Incomplete Tasks", // نص إرشادي يظهر عند تمرير المؤشر فوق الأيقونة
              ),
            ),
          ),
          MouseRegion( // إضافة تأثير hover على الأيقونة
            cursor: SystemMouseCursors.click, // تغيير المؤشر عند التمرير فوق الأيقونة
            child: GestureDetector( // إضافة تفاعل عند الضغط على الأيقونة
              onTapDown: (_) {
                setState(() {
                  // تغيير لون الأيقونة مؤقتًا عند الضغط
                  tasks = allTasks.where((task) => task["completed"] == true).toList();
                });
              },
              onTapUp: (_) {
                setState(() {
                  // إعادة اللون الأصلي بعد الضغط
                });
              },
              child: IconButton(
                icon: Icon(Icons.check_circle, color: Colors.white), // أيقونة للمهام المنجزة
                onPressed: () => _filterTasks(true), // استدعاء دالة تصفية المهام المنجزة عند الضغط
                tooltip: "Completed Tasks", // نص إرشادي يظهر عند تمرير المؤشر فوق الأيقونة
              ),
            ),
          ),
        ],
        centerTitle: true, // جعل العنوان في منتصف شريط العنوان
        backgroundColor: Colors.black, // لون خلفية شريط العنوان أسود
      ),
      body: tasks.isEmpty // التحقق إذا كانت قائمة المهام فارغة
          ? Center( // إذا كانت القائمة فارغة، عرض رسالة في منتصف الشاشة
              child: Text(
                "No tasks available. Add a task!", // نص الرسالة
                style: TextStyle(fontSize: 18, color: Colors.grey[600]), // تنسيق النص
              ),
            )
          : ListView.builder( // إذا كانت القائمة غير فارغة، عرض المهام باستخدام ListView
              itemCount: tasks.length, // عدد العناصر في القائمة
              itemBuilder: (context, index) { // بناء كل عنصر في القائمة
                return Card( // عنصر من نوع Card لعرض المهمة
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // هوامش حول البطاقة
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // زوايا مستديرة للبطاقة
                  ),
                  child: ListTile( // عنصر من نوع ListTile لعرض تفاصيل المهمة
                    title: Text(
                      tasks[index]["name"], // اسم المهمة
                      style: TextStyle(
                        fontSize: 16, // حجم النص
                        decoration: tasks[index]["completed"]
                            ? TextDecoration.lineThrough // خط يتوسط النص إذا كانت المهمة منجزة
                            : TextDecoration.none, // بدون خط إذا لم تكن منجزة
                      ),
                    ),
                    leading: IconButton( // زر أيقونة في بداية العنصر
                      icon: Icon(
                        tasks[index]["completed"]
                            ? Icons.check_circle // أيقونة منجزة
                            : Icons.radio_button_unchecked, // أيقونة غير منجزة
                        color: tasks[index]["completed"] ? Colors.green : Colors.grey, // لون الأيقونة بناءً على الحالة
                      ),
                      onPressed: () => _toggleTaskCompletion(index), // تبديل حالة الإنجاز عند الضغط
                    ),
                    trailing: IconButton( // زر أيقونة في نهاية العنصر
                      icon: Icon(Icons.delete, color: Colors.red), // أيقونة الحذف
                      onPressed: () => _deleteTask(index), // حذف المهمة عند الضغط
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton( // زر عائم لإضافة مهمة جديدة
        onPressed: _showAddTaskDialog, // استدعاء نافذة إضافة مهمة جديدة عند الضغط
        backgroundColor: Colors.black, // لون خلفية الزر
        child: Icon(Icons.add, color: Colors.white), // أيقونة الزر (إضافة)
      ),
    );
  }
}
