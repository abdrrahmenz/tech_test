part of 'topic_bloc.dart';

abstract class TopicEvent extends Equatable {
  const TopicEvent();

  @override
  List<Object?> get props => [];
}

class TopicFetchData extends TopicEvent {}

class SearchTopicData extends TopicEvent {
  final String? query;

  SearchTopicData({this.query});

  @override
  List<Object?> get props => [query];
}