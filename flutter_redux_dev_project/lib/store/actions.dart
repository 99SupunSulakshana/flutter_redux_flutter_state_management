import 'package:flutter_redux_dev_project/store/reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

class UpdateQuoteAction {
  String _quote;
  String get quote => this._quote;
  UpdateQuoteAction(this._quote);
}

ThunkAction<AppState> getRandomQuote = (Store<AppState> store) async {
  store.dispatch(UpdateQuoteAction("Updated Quote"));
};
