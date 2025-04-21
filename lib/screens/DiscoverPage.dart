import 'package:flutter/material.dart';
import 'package:project/generated/l10n.dart';
import 'package:project/models/categorymodel.dart';
import 'package:project/components/Categories_news.dart';

class DiscoverPage extends StatelessWidget {
  DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Categorymodel> categoryList = [
      Categorymodel(CategoryName: S.of(context).business, CategoryImage: "assets/images/business.jpg"),
      Categorymodel(CategoryName: S.of(context).entertainment, CategoryImage: "assets/images/entertainment.jpg"),
      Categorymodel(CategoryName: S.of(context).science, CategoryImage: "assets/images/science.jpg"),
      Categorymodel(CategoryName: S.of(context).sports, CategoryImage: "assets/images/sports.jpg"),
      Categorymodel(CategoryName: S.of(context).health, CategoryImage: "assets/images/health.jpg"),
      Categorymodel(CategoryName: S.of(context).technology, CategoryImage: "assets/images/tech.jpg"),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Text(
              S.of(context).discover, // استخدم الترجمة هنا بدل النص الثابت لو تحب
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              S.of(context).newsFromAllAroundTheWorld, // نفس الشيء هنا
              style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: categoryList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: constraints.maxWidth > 600 ? 1.2 : 1.5,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriesNews(category: categoryList[index].CategoryName),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(categoryList[index].CategoryImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              categoryList[index].CategoryName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
