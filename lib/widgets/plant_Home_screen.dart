import 'package:flutter/material.dart';
import 'package:flutter_application_8/plant_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_8/models/list_model.dart'; 
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PlantHomeScreen extends StatefulWidget {
  const PlantHomeScreen({super.key});

  @override
  State<PlantHomeScreen> createState() => _PlantHomeScreenState();
}

class _PlantHomeScreenState extends State<PlantHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlantCubit>().getPlants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assets/plant_logo.png', errorBuilder: (_, _, _) => const Icon(Icons.eco, color: Color(0xFF2D5A27))),
        ),
        title: const Text(
          'Plant Care', 
          style: TextStyle(color: Color(0xFF1B4314), fontWeight: FontWeight.bold, fontSize: 22)
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
      ),
      body: BlocBuilder<PlantCubit, PlantState>(
        builder: (context, state) {
          if (state is PlantLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2D5A27)),
            );
          }
          
          if (state is PlantError) {
            return Center(
              child: Text('حدث خطأ: ${state.message}'),
            );
          }

          if (state is PlantLoaded) {
            final List<Plant> plants = state.plants;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello, Plant\nParent',
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, height: 1.1, color: Colors.black87),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Your sanctuary is thriving today.',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search your collection...',
                              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildCategoryChip('All Plants', isSelected: true),
                              _buildCategoryChip('Tropical', isSelected: false),
                              _buildCategoryChip('Succulents', isSelected: false),
                              _buildCategoryChip('Ferns', isSelected: false),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      bool isFullWidth = index % 3 == 0;
                      final plant = plants[index];

                      if (isFullWidth) {
                        return BigPlantCard(plant: plant);
                      } else {
                        return SmallPlantCard(plant: plant);
                      }
                    },
                    childCount: plants.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
          }

          return const Center(child: Text('لا توجد بيانات نباتات حالياً'));
        },
      ),
    );
  }

  Widget _buildCategoryChip(String label, {required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        backgroundColor: isSelected ? const Color(0xFF2D5A27) : const Color(0xFFEFEFEF),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        side: BorderSide.none,
      ),
    );
  }
}

class BigPlantCard extends StatelessWidget {
  final Plant plant; 
  const BigPlantCard({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = plant.defaultImage?.regularUrl ?? 'https://via.placeholder.com/350x200';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            child: Image.network(
              imageUrl,
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Icon(Icons.broken_image, size: 50, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    plant.cycle?.toUpperCase() ?? 'TROPICAL', 
                    style: const TextStyle(color: Color(0xFF2D5A27), fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  plant.commonName, 
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SmallPlantCard extends StatelessWidget {
  final Plant plant; 
  const SmallPlantCard({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = plant.defaultImage?.thumbnail ?? 'https://via.placeholder.com/150';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Icon(Icons.broken_image, size: 40, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant.sunlight?.isNotEmpty == true ? plant.sunlight![0] : 'Low Light',
                  style: TextStyle(color: Colors.grey[600], fontSize: 11, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  plant.commonName,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}