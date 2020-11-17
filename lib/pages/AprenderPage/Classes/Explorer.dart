import 'dart:convert';
import 'package:http/http.dart' as http;


class Explorer {
  
  static Future<Tree> getRepository(String username, String repositoryName, String branch) async {
    Map data = jsonDecode(await http.read('https://api.github.com/repos/$username/$repositoryName/git/trees/$branch'));
    Tree repository = Tree();


    repository.sha = data['sha'];
    repository.url = data['url'];

    data['tree'].forEach((item){
      repository.tree.add(TreeItem(
        mode: item['mode'],
        path: item['path'],
        sha: item['sha'],
        size: item['size'],
        type: item['type'],
        url: item['url']
      ));
    });

    return repository;
  }

  static Future<Tree> getTreeFromUrl(String url) async {
    Map data = jsonDecode(await http.read(url));
    Tree tree = Tree();

    tree.sha = data['sha'];
    tree.url = data['url'];

    data['tree'].forEach((item){
      tree.tree.add(TreeItem(
        mode: item['mode'],
        path: item['path'],
        sha: item['sha'],
        size: item['size'],
        type: item['type'],
        url: item['url']
      ));
    });

    return tree;
  }

  static Future<Blob> getBlobFromUrl(String url) async {
    Map data = jsonDecode(await http.read(url));
    Blob blob = Blob();

    blob.sha = data['sha'];
    blob.nodeId = data['node_id'];
    blob.size = data['size'];
    blob.url = data['url'];
    blob.content = data['content'];

    return blob;
  }

}

class Blob{
  String sha;
  String nodeId;
  int size;
  String url;
  String content;
  String encoding;

  Blob();

  String toString(){
    return 'sha: ${this.sha}\nnode_id: ${this.nodeId}\nsize: ${this.size}\nurl: ${this.url}\ncontent: ${this.content}\nencoding: ${this.encoding}';
  }
}

class Tree {
  String sha;
  String url;
  List tree = [];

  Tree();
  
  String toString(){
    return 'sha: ${this.sha}\nurl: ${this.url}\n\n${this.tree.join('\n\n')}';
  }

  TreeItem getTreeItemFromPath(String path){
    TreeItem item;

    // Searching for specific item
    tree.forEach((element) {
      if(element.path == path){
        item = element;
      }
    });

    return item;
  }
}

class TreeItem {
  String path;
  String mode;
  String type;
  String sha;
  int size;
  String url;

  TreeItem({this.path, this.mode, this.type, this.sha, this.size, this.url});
  
  String toString(){
    return 'path: ${this.path}\nmode: ${this.mode}\ntype: ${this.type}\nsha: ${this.sha}\n${this.size == null ? '' : "size: ${this.size}\n"}url: ${this.url}';
  }
}