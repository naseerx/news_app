import 'package:flutter/material.dart';

import 'international_channels.dart';
import 'national_channels.dart';

class ChannelsScreen extends StatefulWidget {
  const ChannelsScreen({Key? key}) : super(key: key);

  @override
  State<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('TabBar'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Text('National'),
              ),
              Tab(
                icon: Text('International'),
              ),
            ],
          ),
        ),
        body:  const TabBarView(
          children: [
            NationalChannels(),
            InternationalChannels(),
          ],
        ),
      ),
    );
  }
}
