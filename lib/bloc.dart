import 'dart:async';

import 'package:flutter_bloc_tutorial/model.dart';

import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final API api;

  Stream<List<Movie>> _results = Stream.empty();
  Stream<String> _log = Stream.empty();

  // Cold subjuct: emitt all the items regardless of when we subscribes to it,,, readMore abt Cold/Hot subjuct
  ReplaySubject<String> _query = ReplaySubject<String>(); // Subjects are the StreamController of Rx

  Stream<String> get log => _log;
  Stream<List<Movie>> get results => _results;

  // user Input
  // A Sink is destination for data, Multiple data values can be put into a sink, and when no more data is available, the sink should be closed.
  // Instead of exposing the whole subjuct's functionalities, we'll just expose the sink. 
  // We cann add values to the Subject/StreamController by using _query.sink.add, which is equivalent to _query.add 
  Sink<String> get query => _query;

  MovieBloc(this.api) {
    _results = _query
        .distinct() // see distinctUntilChanged in Angular ListOfHero projuct
        .asyncMap(api.get) // The same as List.map((e)=> ..) But this is for a stream and it's async
        .asBroadcastStream(); //If several listeners want to listen to a single subscription stream, use [asBroadcastStream] to create a broadcast stream on top of the non-broadcast stream.



    _log = Observable(results)
    .zipWith(_query.stream,  (_, query) => 'Results for $query') // http://rxmarbles.com/#zip
        // .withLatestFrom(_query.stream, (_, query) =>query.isEmpty ? '' :'Results for $query') // http://rxmarbles.com/#withLatestFrom
        .asBroadcastStream();
  }

  void dispose() {
    // we just need to dispose/close _query stream, becuase the _query stream will emitt events from UI, 
    // but the other two streams will just emit values if _query emits something. So by closing _query the other 2 streams will not emit.   
    _query.close();
  }

}