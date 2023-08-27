/*
Widget emptyPage = EmptyPage();
int page = 0;
int limit = 10;
var stream;
final ScrollController _scrollController = new ScrollController();

@override
void initState() {
  super.initState();
  _scrollController.addListener(() {
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        page++;
        stream = newStream();
      });
    }
  });
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  stream = newStream();
}

@override
void dispose() {
  _scrollController.dispose();
  super.dispose();
}

Stream<List<NotificationData>>? newStream() {
  return Provider.of<Database>(context, listen: false).getNotNotifiedNotiPaginationStream(page, limit);
}
*/