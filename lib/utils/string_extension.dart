extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');

  bool containKeys(String keys){
    List<String> keywords= keys.split(' ');
    for(String key in keywords){
      if(!this.toLowerCase().contains(key.toLowerCase())){
        return false;
      }
    }
    return true;
  }
}
