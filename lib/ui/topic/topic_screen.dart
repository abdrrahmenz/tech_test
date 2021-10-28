import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_test/bloc/topic_bloc.dart';
import 'package:tech_test/data/model/topic.dart';
import 'package:tech_test/data/repository/repository.dart';
import 'package:tech_test/ui/widgets/custom_widget.dart';
import 'package:tech_test/utils/app_colors.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  TopicBloc _topicbloc = TopicBloc(FakeTopicRepository());
  final TextEditingController _searchTextEditing = TextEditingController();
  List<Topic> _listCategories = [];
  List<Topic> _listSearchCategories = [];
  int? currentSelectedIndex;
  List<int> _listSelected = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _topicbloc = BlocProvider.of<TopicBloc>(context);
    _topicbloc.add(TopicFetchData());

    _searchTextEditing.addListener(() {
      Future.delayed(Duration(seconds: 1), () {
        if (_searchTextEditing.text.isNotEmpty &&
            _searchTextEditing.text.length > 0)
          BlocProvider.of<TopicBloc>(context)
              .add(SearchTopicData(query: _searchTextEditing.text));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: AppBar(
        title: Text(
          'Follow Topic',
          style: GoogleFonts.merriweather(),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: colorSecondary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: TextFormField(
                controller: _searchTextEditing,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 15, top: 15, right: 15),
                  hintText: "Search topics..",
                  hintStyle: GoogleFonts.roboto(color: Colors.grey),
                  fillColor: colorSecondary,
                  focusColor: colorSecondary,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                style: TextStyle(color: Colors.grey),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: colorGrey1,
                boxShadow: [
                  BoxShadow(color: colorGrey1, spreadRadius: 3),
                ],
              ),
              width: double.infinity,
            ),
          ),
          BlocListener<TopicBloc, TopicState>(
              listener: (context, state) {
                if (state is FailureTopicState) {
                  setState(() {
                    _isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                } else if (state is LoadingTopicState) {
                  setState(() {
                    _isLoading = true;
                  });
                } else if (state is SuccessTopicState) {
                  setState(() {
                    _isLoading = false;
                  });
                  if (_listCategories.isNotEmpty) _listCategories.clear();
                  _listCategories.addAll(state.topicList);
                } else if (state is LoadingSearchTopicState) {
                  setState(() {
                    _isLoading = true;
                  });
                } else if (state is SuccessSearchTopicState) {
                  setState(() {
                    _isLoading = false;
                  });
                  if (_listSearchCategories.isNotEmpty)
                    _listSearchCategories.clear();
                  _listSearchCategories.addAll(state.topicList);
                }
              },
              child: _isLoading
                  ? buildLoading()
                  : _listCategories.isEmpty
                      ? Center(
                          child: Text('Topic empty'),
                        )
                      : _searchTextEditing.text.isEmpty
                          ? buildTopicData(_listCategories)
                          : buildTopicData(_listSearchCategories)),
          _isLoading
              ? SizedBox.shrink()
              : Container(
                  height: 60,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, 0),
                        blurRadius: 20,
                        spreadRadius: 3)
                  ]),
                  child: Center(
                    child: Text(
                      'Select at least ${3 - _listSelected.length} categories to continue',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildTopicData(List<Topic> listTopic) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 274) / 2;
    final double itemWidth = size.width / 1;
    return Expanded(
      child: GridView.count(
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: 2,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(
            listTopic.length,
            (index) {
              return CustomWidget(
                topic: listTopic[index],
                index: index,
                isSelected: selected(index),
                onSelect: () {
                  setState(() {
                    currentSelectedIndex = index;
                    final isSelected = _listSelected.contains(index);
                    if (_listSelected.length < 3) {
                      if (isSelected)
                        _listSelected.remove(index);
                      else
                        _listSelected.add(index);
                    } else {
                      _listSelected.remove(index);
                    }
                  });
                },
              );
            },
          )),
    );
  }

  bool selected(int index) {
    bool _select = false;
    _listSelected.forEach((element) {
      if (element == index) _select = true;
    });
    return _select;
  }
}
