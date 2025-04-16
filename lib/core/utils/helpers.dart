String getCategoryImage(String category) {
  category = category.toLowerCase();

  if (category.contains('market')) {
    return 'assets/market.png';
  } else if (category.contains('restaurant')) {
    return 'assets/resturant.png';
  } else {
    return 'assets/store.png';
  }
}
