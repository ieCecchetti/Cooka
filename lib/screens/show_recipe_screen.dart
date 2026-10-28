import 'package:flutter/material.dart';
import 'package:cooka/models/recipe.dart';
import 'package:cooka/models/ingredient.dart';
import 'package:cooka/theme/app_theme.dart';
import 'package:intl/intl.dart';

class ShowRecipeScreen extends StatelessWidget {
  final Recipe recipe;
  final Map<String, Ingredient> ingredientMap;

  const ShowRecipeScreen({
    super.key,
    required this.recipe,
    required this.ingredientMap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
            SliverAppBar(
              expandedHeight: 260,
              pinned: true,
              floating: false,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  // 80.0 is the default collapsed height of the SliverAppBar
                  final bool isCollapsed = constraints.biggest.height <= kToolbarHeight + MediaQuery.of(context).padding.top + 10;
                  return FlexibleSpaceBar(
                    title: Text(
                      recipe.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCollapsed ? Colors.brown[900] : Colors.white,
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        recipe.imagesUrl.isNotEmpty && recipe.imagesUrl.first.isNotEmpty
                            ? _ImageGallery(images: recipe.imagesUrl)
                            : Container(color: Theme.of(context).primaryColor),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color.fromRGBO(0, 0, 0, 0.2),
                                Color.fromRGBO(0, 0, 0, 0.5),
                                Color.fromRGBO(0, 0, 0, 0.8), // More dark at the bottom
                              ],
                              stops: [0.0, 0.5, 0.8, 1.0],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      recipe.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoChip(
                        icon: Icons.timer,
                        label: "${recipe.prepTime} min",
                      ),
                      _InfoChip(
                        icon: Icons.people,
                        label: "${recipe.servings} servings",
                      ),
                      _InfoChip(
                        icon: Icons.leaderboard,
                        label: recipe.difficulty.name[0].toUpperCase() +
                            recipe.difficulty.name.substring(1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Categories
                  if (recipe.category.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: recipe.category
                          .map((cat) => Chip(
                                label: Text(cat.title),
                                backgroundColor: Colors.brown[100],
                              ))
                          .toList(),
                    ),
                  const SizedBox(height: 18),

                  // Ancient Paper Ingredients List
                  _AncientPaperSection(
                    title: "Ingredients",
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recipe.ingredientIds.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1, color: Colors.brown),
                      itemBuilder: (context, idx) {
                        final id = recipe.ingredientIds[idx];
                        final ingredient = ingredientMap[id];
                        final measured = recipe.measuredIngredients[id];
                        return ListTile(
                          leading: const Icon(Icons.circle,
                              size: 12, color: Colors.brown),
                          title: Text(
                            ingredient != null ? ingredient.name : "Unknown",
                            style: const TextStyle(
                                fontSize: 18),
                          ),
                          subtitle: measured != null
                              ? Text(
                                  "${measured.quantity} ${measured.unit.name}",
                                  style: const TextStyle(
                                      ),
                                )
                              : null,
                          trailing: ingredient?.imageUrl != null &&
                                  ingredient!.imageUrl.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    ingredient.imageUrl,
                                    width: 36,
                                    height: 36,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                )
                              : null,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Steps
                  _AncientPaperSection(
                    title: "Preparation Steps",
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recipe.steps.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1, color: Colors.brown),
                      itemBuilder: (context, idx) {
                        final step = recipe.steps[idx];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.brown[200],
                            child: Text(
                              "${idx + 1}",
                              style: const TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(
                            step.title,
                            style: const TextStyle(
                                
                            fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                step.description,
                                style: const TextStyle(
                                    ),
                              ),
                              if (step.time != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.timer,
                                          size: 16, color: Colors.brown),
                                      const SizedBox(width: 4),
                                      Text("${step.time} min",
                                          style: const TextStyle(
                                              )),
                                    ],
                                  ),
                                ),
                              if (step.image != null && step.image!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      step.image!,
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.broken_image),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Last updated
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Last updated: ${DateFormat.yMMMd().format(recipe.lastUpdated)}",
                      style: TextStyle(
                        
                            fontSize: 14,
                        color: Colors.brown[400],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Carousel for SliverAppBar background
class _ImageGallery extends StatefulWidget {
  final List<String> images;
  const _ImageGallery({required this.images});

  @override
  State<_ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<_ImageGallery> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: widget.images.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, idx) => Hero(
            tag: 'recipe-image-${widget.images[idx]}',
            child: Image.network(
              widget.images[idx],
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, size: 48),
              ),
            ),
          ),
        ),
        if (widget.images.length > 1)
          Positioned(
            bottom: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (idx) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == idx ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == idx
                        ? Colors.brown[700]
                        : Colors.brown[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// Info chip for quick facts
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: Colors.brown[700], size: 20),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.brown[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

// Ancient paper styled section
class _AncientPaperSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _AncientPaperSection({required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        border: Border.all(color: Colors.brown, width: 2),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/paper-line.jpeg'),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: handwritten(fontSize: 30, color: AppColors.accent)),
          Container(
            margin: const EdgeInsets.only(top: 2, bottom: 10),
            height: 2,
            width: 90,
            color: AppColors.accent,
          ),
          child,
        ],
      ),
    );
  }
}