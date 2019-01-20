class SubFilter {
  String filterKey = "";
  bool isActive = false;


  SubFilter(this.filterKey,this.isActive);

  bool operator ==(o) => o is SubFilter && this.filterKey == o.filterKey;
  int get hashCode => (filterKey.hashCode);

}
