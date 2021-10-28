import 'package:tech_test/data/dummy/dummy.dart';
import 'package:tech_test/data/model/topic.dart';

abstract class TopicRepository {
  Future<List<Topic>> fetchTopic();
  Future<List<Topic>> fetchSearchTopic(String? query);
}

class FakeTopicRepository implements TopicRepository {
  @override
  Future<List<Topic>> fetchTopic() {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        // Return "fetched" Topic
        return listTopic;
      },
    );
  }

  @override
  Future<List<Topic>> fetchSearchTopic(String? query) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        // Return "fetched" Topic
        return query != null
            ? listTopic
                .where((element) =>
                    element.name.toLowerCase().contains(query.toLowerCase()))
                .toList()
            : listTopic;
      },
    );
  }
}
