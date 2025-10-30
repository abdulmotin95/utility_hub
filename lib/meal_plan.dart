import 'package:flutter/material.dart';

class Meal {
  String name;
  String description;
  int calories;
  String imageUrl;
  String mealType;

  Meal({
    required this.name,
    required this.description,
    required this.calories,
    required this.mealType,
    required this.imageUrl,
  });
}


List<Meal> sampleMeals = [
  Meal(
    name: 'Oatmeal with Fruits',
    description: 'Healthy breakfast with oats, banana, and berries.',
    calories: 350,
    mealType: 'Breakfast',
    imageUrl: 'https://i.imgur.com/Y1wqVh1.jpg',
  ),
  Meal(
    name: 'Grilled Chicken Salad',
    description: 'Lunch with grilled chicken, lettuce, and veggies.',
    calories: 450,
    mealType: 'Lunch',
    imageUrl: 'https://i.imgur.com/Tw5QKjA.jpg',
  ),
  Meal(
    name: 'Quinoa & Veggies',
    description: 'Dinner with quinoa and mixed vegetables.',
    calories: 400,
    mealType: 'Dinner',
    imageUrl: 'https://i.imgur.com/pN9C1D2.jpg',
  ),
  Meal(
    name: 'Protein Shake',
    description: 'Snack with whey protein, milk, and banana.',
    calories: 200,
    mealType: 'Snack',
    imageUrl: 'https://i.imgur.com/x3A7pGZ.jpg',
  ),
  Meal(
    name: 'Avocado Toast',
    description: 'Toast with avocado, egg, and cherry tomatoes.',
    calories: 320,
    mealType: 'Breakfast',
    imageUrl: 'https://i.imgur.com/0aF6hA7.jpg',
  ),
  Meal(
    name: 'Greek Yogurt Parfait',
    description: 'Yogurt with granola, honey, and berries.',
    calories: 280,
    mealType: 'Breakfast',
    imageUrl: 'https://i.imgur.com/6LZ8J0u.jpg',
  ),
  Meal(
    name: 'Turkey Sandwich',
    description: 'Whole grain bread with turkey and veggies.',
    calories: 400,
    mealType: 'Lunch',
    imageUrl: 'https://i.imgur.com/ZXB2F0U.jpg',
  ),
  Meal(
    name: 'Veggie Wrap',
    description: 'Wrap filled with mixed vegetables and hummus.',
    calories: 350,
    mealType: 'Lunch',
    imageUrl: 'https://i.imgur.com/2QHc8VJ.jpg',
  ),
  Meal(
    name: 'Grilled Salmon',
    description: 'Salmon fillet with steamed veggies.',
    calories: 500,
    mealType: 'Dinner',
    imageUrl: 'https://i.imgur.com/pjYl8yS.jpg',
  ),
  Meal(
    name: 'Chicken Stir Fry',
    description: 'Chicken with broccoli, carrots, and rice.',
    calories: 450,
    mealType: 'Dinner',
    imageUrl: 'https://i.imgur.com/H0q6h0E.jpg',
  ),
  Meal(
    name: 'Almonds & Walnuts',
    description: 'Handful of mixed nuts for a quick snack.',
    calories: 180,
    mealType: 'Snack',
    imageUrl: 'https://i.imgur.com/8m9N7Qw.jpg',
  ),
  Meal(
    name: 'Fruit Smoothie',
    description: 'Blended banana, mango, and berries smoothie.',
    calories: 220,
    mealType: 'Snack',
    imageUrl: 'https://i.imgur.com/7gG6RZk.jpg',
  ),
  Meal(
    name: 'Pancakes with Syrup',
    description: 'Fluffy pancakes topped with maple syrup.',
    calories: 400,
    mealType: 'Breakfast',
    imageUrl: 'https://i.imgur.com/VqH6dXU.jpg',
  ),
  Meal(
    name: 'Egg Muffins',
    description: 'Baked egg muffins with spinach and cheese.',
    calories: 300,
    mealType: 'Breakfast',
    imageUrl: 'https://i.imgur.com/9o9zD2m.jpg',
  ),
  Meal(
    name: 'Caprese Salad',
    description: 'Tomato, mozzarella, and basil with olive oil.',
    calories: 350,
    mealType: 'Lunch',
    imageUrl: 'https://i.imgur.com/PCn5E8m.jpg',
  ),
  Meal(
    name: 'Sushi Rolls',
    description: 'Assorted sushi rolls with rice and fish.',
    calories: 400,
    mealType: 'Lunch',
    imageUrl: 'https://i.imgur.com/J7Zjq6Y.jpg',
  ),
  Meal(
    name: 'Beef Steak',
    description: 'Grilled beef steak with side salad.',
    calories: 550,
    mealType: 'Dinner',
    imageUrl: 'https://i.imgur.com/v2L1s1A.jpg',
  ),
  Meal(
    name: 'Veggie Pasta',
    description: 'Whole wheat pasta with tomato sauce and veggies.',
    calories: 420,
    mealType: 'Dinner',
    imageUrl: 'https://i.imgur.com/Tl7OXo3.jpg',
  ),
  Meal(
    name: 'Trail Mix',
    description: 'Mix of dried fruits and nuts.',
    calories: 200,
    mealType: 'Snack',
    imageUrl: 'https://i.imgur.com/gJbqRrl.jpg',
  ),
  Meal(
    name: 'Cheese & Crackers',
    description: 'Sliced cheese with whole grain crackers.',
    calories: 250,
    mealType: 'Snack',
    imageUrl: 'https://i.imgur.com/NQxPqWc.jpg',
  ),
  Meal(
    name: 'Chia Pudding',
    description: 'Chia seeds pudding with almond milk and berries.',
    calories: 280,
    mealType: 'Breakfast',
    imageUrl: 'https://i.imgur.com/AoRxj7d.jpg',
  ),
  Meal(
    name: 'Tofu Stir Fry',
    description: 'Tofu with mixed vegetables and soy sauce.',
    calories: 400,
    mealType: 'Dinner',
    imageUrl: 'https://i.imgur.com/3bWkKJl.jpg',
  ),
  Meal(
    name: 'Hummus & Veggies',
    description: 'Carrot and cucumber sticks with hummus dip.',
    calories: 180,
    mealType: 'Snack',
    imageUrl: 'https://i.imgur.com/6WdT7G2.jpg',
  ),
];

class DietPlanScreen extends StatefulWidget {
  const DietPlanScreen({super.key});

  @override
  State<DietPlanScreen> createState() => _DietPlanScreenState();
}
class _DietPlanScreenState extends State<DietPlanScreen> {
  String selectedMealType = 'All';
  List<String> mealTypes = ['All', 'Breakfast', 'Lunch', 'Dinner', 'Snack'];

  @override
  Widget build(BuildContext context) {
    List<Meal> filteredMeals = selectedMealType == 'All'
        ? sampleMeals
        : sampleMeals
        .where((meal) => meal.mealType == selectedMealType)
        .toList();

    int totalCalories =
    filteredMeals.fold(0, (sum, meal) => sum + meal.calories);

    final Gradient backgroundGradient = const LinearGradient(
      colors: [
        Color(0xFF5C91D4),
        Color(0xFF4451C8),
        Color(0xFF1F4ABE),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet Plan / Meal Suggestions'),
        backgroundColor: const Color(0xFF5C91D4),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: selectedMealType,
                isExpanded: true,
                underline: const SizedBox(),
                items: mealTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(
                      type,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedMealType = val!;
                  });
                },
              ),
            ),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total Calories: $totalCalories kcal',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: filteredMeals.length,
                itemBuilder: (context, index) {
                  final meal = filteredMeals[index];
                  bool isLeft = index % 2 == 0;
                  return Align(
                    alignment:
                    isLeft ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black.withOpacity(0.25),
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: backgroundGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(meal.imageUrl),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      meal.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      meal.description,
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFA726),
                                      Color(0xFFFF7043)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${meal.calories} kcal',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
