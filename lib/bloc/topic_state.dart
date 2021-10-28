part of 'topic_bloc.dart';

class TopicState extends Equatable {

  const TopicState();

  @override
  List<Object?> get props => [];
}

class InitialTopicState extends TopicState {}

class LoadingTopicState extends TopicState {}

class LoadingSearchTopicState extends TopicState {}

class SuccessTopicState extends TopicState {
  final List<Topic> topicList;

  SuccessTopicState({required this.topicList});

  @override
  List<Object?> get props => [topicList];
}

class FailureTopicState extends TopicState {
  final String message;

  FailureTopicState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SuccessSearchTopicState extends TopicState {
  final List<Topic> topicList;

  SuccessSearchTopicState({required this.topicList});

  @override
  List<Object?> get props => [topicList];
}

class FailureSearchTopicState extends TopicState {
  final String message;

  FailureSearchTopicState({required this.message});

  @override
  List<Object?> get props => [message];
}