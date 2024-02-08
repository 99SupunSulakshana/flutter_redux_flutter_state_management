import 'package:flutter_redux_dev_project/store/actions.dart';
import 'package:redux/redux.dart';
import '../main.dart';

class AppState {
  final int count;
  final int clickCount;
  final String quote;

  AppState(
      {required this.count, required this.clickCount, required this.quote});

  AppState copyWith({count, clickCount, quote}) {
    return AppState(
        count: count ?? this.count,
        clickCount: clickCount ?? this.clickCount,
        quote: quote ?? this.quote);
  }
}

AppState counterReducer(AppState state, dynamic action) {
  switch (action) {
    case Types.Increment:
      return state.copyWith(count: state.count + 1);
  }
  return state;
}

AppState updateQuoteReducer(AppState state, dynamic action) {
  if (action is UpdateQuoteAction) {
    return state.copyWith(quote: "New quote");
  }
  return state;
}

final reducers = combineReducers<AppState>([counterReducer, updateQuoteReducer]);
