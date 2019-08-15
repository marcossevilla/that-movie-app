import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:that_movie_app/src/models/actors_model.dart';
import 'package:that_movie_app/src/providers/actor_provider.dart';

class ActorDetail extends StatefulWidget {
  @override
  _ActorDetailState createState() => _ActorDetailState();
}

class _ActorDetailState extends State<ActorDetail> {

  Actor actorForDetail;

  @override
  Widget build(BuildContext context) {

    final Actor actor = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(actor.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildPhoto(context, actor),
            _buildTheRest(context, actor),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoto(BuildContext context, Actor actor) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: FadeInImage(
        placeholder: AssetImage('assets/no-image.jpg'),
        image: NetworkImage(actor.getPicture()),
        height: 300,
        width: double.infinity,
      ),
    );
  }

  Widget _buildTheRest(BuildContext context, Actor actor) {

    final actorProvider = new ActorProvider();

    return FutureBuilder(
      future: actorProvider.getActorInfo(actor.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
        if (snapshot.hasData) {
          return _buildInfo(context, snapshot.data);
        } else {
          return Center(
            child: Platform.isAndroid
              ? CircularProgressIndicator()
              : CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  _buildInfo(BuildContext context, Actor actor) {

    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Popularity', 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 15.0,
                )
              ),
              SizedBox(width: 40.0),
              Icon(Icons.stars, size: 15.0),
              SizedBox(width: 5.0),
              Text(
                '${actor.popularity}', 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 15.0,
                )
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            'Bio', 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 20.0,
            )
          ),
          SizedBox(height: 20.0),
          Text('${actor.biography}'),
          SizedBox(height: 20.0),
          (actor.knownForDepartment == null) ? Text('') : Text('He is known for being an ${actor.knownForDepartment}'),
        ],
      ),
    );
  }
}