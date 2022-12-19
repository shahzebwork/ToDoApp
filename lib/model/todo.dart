class ToDo {
  int id;
  String todoText;
  bool isDone;
  bool isArchieve;

  //static var todoList;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
    this.isArchieve = false,
  });

  toJson() {
    return {
      "id": id,
      "todoText": todoText,
      "isDone": isDone,
      "isArchieve": isArchieve
    };
  }

  fromJson(jasonData) {
    return ToDo(
      id: jasonData["id"] ?? 0,
      todoText: jasonData["todoText"] ?? '',
      isDone: jasonData["isDone"] ?? false,
      isArchieve: jasonData["isArchieve"] ?? false,
    );
  }
/*
  static List<ToDo> todoList = <ToDo>[
    ToDo(id: 0, todoText: 'Getting ready for office'),
     ToDo(id: 1, todoText: 'Morning Walk', isDone: true),
    ToDo(id: 2, todoText: 'Breakfast', isDone: true),
  ];

 

  static List<ToDo> todoList() {
    return [
      ToDo(id: 1, todoText: 'Morning Walk', isDone: true),
      ToDo(id: 2, todoText: 'Breakfast', isDone: true),
      ToDo(id: 3, todoText: 'Getting ready for office'),
      ToDo(id: 4, todoText: 'Reached Office '),
      ToDo(id: 5, todoText: 'Morning Walk', isDone: false),
    ];
  }
   */
}
