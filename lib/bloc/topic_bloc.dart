
import 'package:bloc/bloc.dart';
import 'package:tech_test/data/model/topic.dart';
import 'package:tech_test/data/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'topic_event.dart';
part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final TopicRepository _topicRepository;
  TopicBloc(this._topicRepository) : super(InitialTopicState());

  @override
  Stream<TopicState> mapEventToState(
    TopicEvent event,
  ) async* {
    if (event is TopicFetchData) {
      yield* _mapTopicToState(event);
    } else if (event is SearchTopicData) {
      yield* _mapTopicSearchToState(event);
    }
  }

  Stream<TopicState> _mapTopicToState(TopicFetchData event) async* {
    yield LoadingTopicState();
    try {
      final List<Topic>? response = await _topicRepository.fetchTopic();
      print(response);
      if (response != null) {
        yield SuccessTopicState(topicList: response);
      } else {
        yield FailureTopicState(message: 'error null');
      }
    } catch (error) {
      yield FailureTopicState(message: error.toString());
    }
  }

  Stream<TopicState> _mapTopicSearchToState(
      SearchTopicData event) async* {
    yield LoadingSearchTopicState();
    try {
      final List<Topic>? response = await _topicRepository.fetchSearchTopic(event.query);
      print(response);
      if (response != null) {
        yield SuccessSearchTopicState(topicList: response);
      } else {
         yield FailureSearchTopicState(message: 'error null');
      }
    } catch (error) {
      yield FailureSearchTopicState(message: error.toString());
    }
  }
}
