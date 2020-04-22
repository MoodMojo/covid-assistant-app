class AssetUtil {
  static String assetImage(int amount) {
    switch (amount) {
      case 200:
        return 'assets/hand-png.png';
      default:
        return 'assets/custom_ml.png';
    }
  }
}
