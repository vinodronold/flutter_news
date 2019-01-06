import 'package:flutter/material.dart';
import './screens/new_list.dart';
import './screens/news_details.dart';
import './blocs/stories/stories_provider.dart';
import './blocs/comments/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: CommentsProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route<dynamic> routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          final int itemId = int.parse(settings.name.replaceFirst('/', ''));
          commentsBloc.fetchItemsWithComments(itemId);
          return NewsDetails(
            itemId: itemId,
          );
        },
      );
    }
  }
}
