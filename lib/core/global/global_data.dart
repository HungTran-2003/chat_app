class GlobalData {
  GlobalData._privateConstructor();

  static final GlobalData instance = GlobalData._privateConstructor();
  void dispose() {
    isShowFlushBar = true;
  }

  bool isShowFlushBar = true;
}