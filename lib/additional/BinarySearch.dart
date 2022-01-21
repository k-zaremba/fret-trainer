void main() {
  List<double> arr = [0, 1, 3, 4, 5, 8, 9, 22];
  double userValue = 0.499;
  int min = 0; // min index
  int max = arr.length - 1;
  print(BinarySearch.binarySearch(arr, userValue, min, max));
}

class BinarySearch {
  static double binarySearch(List<double> arr, double userValue, int min,
      int max) {
    int mid = 0;
    int minidx = min;
    int maxidx = max;

    while (maxidx >= minidx) {
      print('min $minidx');
      print('max $maxidx');
      mid = ((maxidx + minidx) / 2).floor();
      if (userValue == arr[mid]) {
        print('your item is at index: ${mid}');
        break;
      } else if (userValue > arr[mid]) {
        minidx = mid + 1;
      } else {
        maxidx = mid - 1;
      }
    }

    if (mid > 0) {
      if ((arr[mid - 1] - userValue).abs() < (arr[mid] - userValue).abs()) {
        return arr[mid - 1];
      } else {
        return arr[mid];
      }
    }

    if (0 <= mid) {
      if ((arr[mid] - userValue).abs() < (arr[mid + 1] - userValue).abs()) {
        return arr[mid];
      } else {
        return arr[mid + 1];
      }
    }

    return arr[mid];
  }
}