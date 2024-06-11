import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/post.dart';
import '../widgets/audio_widget.dart';
import '../widgets/video_widget.dart';


class PostsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Card(
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data['mediaUrl'] != null && data['mediaType'] == 'image')
                    Image.network(data['mediaUrl'], height: 200, width: double.infinity, fit: BoxFit.cover),
                  if (data['mediaUrl'] != null && data['mediaType'] == 'video')
                    VideoWidget(url: data['mediaUrl']),
                  if (data['mediaUrl'] != null && data['mediaType'] == 'audio')
                    AudioPlayerWidget(url: data['mediaUrl']),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['content'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 10),
                        Text('Publicado por: ${data['username']}', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                        if (data['timestamp'] != null)
                          Text('Publicado: ${data['timestamp'].toDate()}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
