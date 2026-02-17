import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';

class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
    required super.createdAt,
    super.dueDate,
    required super.priority,
  });

  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isCompleted: todo.isCompleted,
      createdAt: todo.createdAt,
      dueDate: todo.dueDate,
      priority: todo.priority,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled',
      description: json['description']?.toString() ?? '',
      isCompleted: json['isCompleted'] == true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : DateTime.now(),
      dueDate: json['dueDate'] != null
          ? DateTime.tryParse(json['dueDate'])
          : null,
      priority: _stringToPriority(json['priority']),
    );
  }

  factory TodoModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoModel(
      id: doc.id,
      title: data['title']?.toString() ?? 'Untitled',
      description: data['description']?.toString() ?? '',
      isCompleted: data['isCompleted'] == true,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(),
      priority: _stringToPriority(data['priority']),
    );
  }


  factory TodoModel.fromFirestoreQuery(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoModel(
      id: doc.id,
      title: data['title']?.toString() ?? 'Untitled',
      description: data['description']?.toString() ?? '',
      isCompleted: data['isCompleted'] == true,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(),
      priority: _stringToPriority(data['priority']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'priority': _priorityToString(priority),
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'priority': _priorityToString(priority),
    };
  }
  
  static String _priorityToString(Priority priority) {
    switch (priority) {
      case Priority.low:
        return 'low';
      case Priority.medium:
        return 'medium';
      case Priority.high:
        return 'high';
    }
  }

  /// Helper method to convert string to Priority enum
  static Priority _stringToPriority(dynamic value) {
    if (value == null) return Priority.medium;

    final priorityStr = value.toString().toLowerCase();
    switch (priorityStr) {
      case 'low':
        return Priority.low;
      case 'high':
        return Priority.high;
      case 'medium':
      default:
        return Priority.medium;
    }
  }
}