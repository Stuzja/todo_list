import 'list_notes.dart';
import 'note.dart';

addNote(String title, String text, DateTime date) {
  listWaiting.add(Note(
    title: title,
    text: text,
    completed: false,
    id: count + 1,
    date: date,
  ));
  count++;
}

deleteNote(int id) {
  if (listWaiting.where((element) => element.id == id).isNotEmpty) {
    listWaiting.removeWhere((element) => element.id == id);
  } else {
    listReady.removeWhere((element) => element.id == id);
  }
}

editNote(int id, String title, String text, DateTime date) {
  var index = listWaiting.indexWhere((element) => element.id == id);
  listWaiting[index].title = title;
  listWaiting[index].text = text;
  listWaiting[index].date = date;
}

List<List<Note>> listDivider(List<Note> list) {
  List<List<Note>> arrList = [];
  List<Note> temp = [];
  if (list.isNotEmpty) {
    for (var i = 0; i < list.length - 1; i++) {
      temp.add(list[i]);
      if (list[i + 1].date.toUtc() != list[i].date.toUtc()) {
        arrList.add(temp);
        temp.clear();
      }
    }
    temp.add(list[list.length - 1]);
    arrList.add(temp);
  }
  return arrList;
}
