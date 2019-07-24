import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Startup Name Generator',
        home: new RandomWords(),
      );
  }
}

// 这个类存储RandomWords的状态,以泛型的方式继承了RandomWords的状态
class RandomWordsState extends State<RandomWords> {
  // 以_开头的变量,是部件私有的
  final _suggestions = <WordPair> [];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    // ListView类提供一个builder属性,itemBuilder值是一个匿名回调函数，接收两个参数-BuildContext和行迭代器i,迭代器从0开始
    // 没调用依次，i自增1
    return new ListView.builder(
      padding: const EdgeInsets.all(18.0),
      itemBuilder: (context, i) {
        // 如果是奇数行,就添加一个分割线，来分隔相邻的词对
        // 0是偶数
        if(i.isOdd) return new Divider();
        final index = i ~/ 2;
        // 当_suggestions已经是最后一个了，就在添加10个
        if(index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    // 定义每个listItem的组成和样式
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState () => new RandomWordsState();
}