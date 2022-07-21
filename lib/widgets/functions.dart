import 'list_notes.dart';
import 'note.dart';

addNote(String title, String text, DateTime date, Priority priority) {
  listWaiting.add(Note(
      title: title,
      text: text,
      completed: false,
      id: count + 1,
      date: date,
      priority: priority));
  count++;
}

deleteNote(int id) {
  if (listWaiting.where((element) => element.id == id).isNotEmpty) {
    listWaiting.removeWhere((element) => element.id == id);
  } else {
    listReady.removeWhere((element) => element.id == id);
  }
}

editNote(int id, String title, String text, DateTime date, Priority priority) {
  var index = listWaiting.indexWhere((element) => element.id == id);
  listWaiting[index].title = title;
  listWaiting[index].text = text;
  listWaiting[index].date = date;
  listWaiting[index].priority = priority;
}

List<List<Note>> listDivider(List<Note> list) {
  List<List<Note>> arrList = [];
  List<Note> temp = [];
  if (list.isNotEmpty) {
    for (var i = 0; i < list.length - 1; i++) {
      temp.add(list[i]);
      if (!list[i].date.isAtSameMomentAs(list[i + 1].date)) {
        arrList.add(temp);
        temp = [];
      }
    }
    temp.add(list[list.length - 1]);
    arrList.add(temp);
  }
  return arrList;
}
