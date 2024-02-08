import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_project/store/actions.dart';
import 'package:flutter_redux_dev_project/store/reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

enum Types { Click, Increment, AddQuote }

final store = Store<AppState>(reducers,
    initialState: AppState(count: 0, clickCount: 0, quote: "Default Quote"),
    middleware: [thunkMiddleware]);

void main() {
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          theme: ThemeData.light(),
          title: '',
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('Redux Sample Application'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StoreConnector<AppState, int>(
                      builder: (_, count) {
                        return Text("$count");
                      },
                      converter: (store) => store.state.count),
                  StoreConnector<AppState, String>(
                      builder: (_, quote) {
                        return Text(
                          quote,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18.0),
                        );
                      },
                      converter: (store) => store.state.quote),
                  StoreConnector<AppState, GenerateQuote>(
                      builder: (_, generateQuoteCallback) {
                        return TextButton(
                            onPressed: generateQuoteCallback,
                            child: const Text("Change Quote"));
                      },
                      converter: (store) =>
                          () => store.dispatch(getRandomQuote)),
                ],
              ),
            ),
            floatingActionButton: StoreConnector<AppState, IncrementCounter>(
              converter: (store) => () => store.dispatch(Types.Increment),
              builder: (_, incrementCallback) {
                return FloatingActionButton(
                  onPressed: incrementCallback,
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                );
              },
            ),
          ),
        ));
  }
}

typedef void IncrementCounter();
typedef void GenerateQuote();
