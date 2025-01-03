import 'dart:async';
import 'dart:convert';

import 'package:clinikk/features/home/static/endpoints/endpoints.dart';
import 'package:clinikk/features/home/static/models/post_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class PostRepos {
  static FutureOr<List<Post>?> getPosts() async {
    try {
      final res = await get(Uri.parse(PostEndpoints.posts));

      if (res.statusCode != 200) {
        throw Exception(
          'Something went wrong',
        );
      } else {
        final decodedJson = json.decode(res.body) as List;
        print(decodedJson);
        return decodedJson.map(Post.fromJson).toList();
      }
    } catch (e) {
      rethrow;
    }
  }

  static FutureOr<List<Post>?> findPost({required int id}) async {
    try {
      final res = await get(Uri.parse('${PostEndpoints.posts}?userId=$id'));
      if (res.statusCode != 200) {
        throw Exception(
          'Something went wrong',
        );
      } else {
        final decodedJson = json.decode(res.body) as List;
        return decodedJson.map(Post.fromJson).toList();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> editPost(
    int? id,
    String title,
    String subtitle,
  ) async {
    try {
      final body = json.encode({
        'id': id,
        'title': title,
        'subtitle': subtitle,
      });

      final res = await put(
        Uri.parse('${PostEndpoints.posts}/$id'),
        body: body,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode != 200 ) {
        throw Exception('Something went wrong');
      } else {
        await Fluttertoast.showToast(msg: 'Post edited successfully');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deletePost(int id) async {
    try {
      final res = await delete(Uri.parse('${PostEndpoints.posts}/$id'));

      if (res.statusCode != 200 ) {
        throw Exception('Something went wrong');
      } else {
        await Fluttertoast.showToast(msg: 'Post deleted successfully');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addPost(String title, String subtitle) async {
    try {
      final body = json.encode({
        'title': title,
        'body': subtitle,
        'userId' : '1',
      });

      final res = await post(
        Uri.parse(PostEndpoints.posts),
        body: body,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode != 200) {
        throw Exception('Something went wrong');
      } else {
        await Fluttertoast.showToast(msg: 'Post added successfully');
      }
    } catch (e) {
      rethrow;
    }
  }
}
