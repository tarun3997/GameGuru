import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameguru/services/imageServices.dart';

class UpcomingMatchScoreCard extends StatelessWidget {
  final String matchStadium;
  final String team1;
  final String team2;
  final String startTime;
  final String team1ImageId;
  final String team2ImageId;


  const UpcomingMatchScoreCard({
    Key? key,
    required this.matchStadium,
    required this.team1,
    required this.team2,
    required this.startTime, required this.team1ImageId, required this.team2ImageId,
  });

  @override
  Widget build(BuildContext context) {
    final image1 = ImageDisplay(imageId: team1ImageId,);
    final image2 = ImageDisplay(imageId: team2ImageId,);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.168,
          decoration: BoxDecoration(
            color: const Color(0xff141d24),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Text(
                      matchStadium,
                      style: const TextStyle(
                          color: Color(0xffc9c2c2),
                          fontSize: 11,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Icon(
                      Icons.notifications_none_outlined,
                      size: 20,
                      color: Color(0xffc9c2c2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 18,
                              backgroundImage: CachedNetworkImageProvider('$image1'),
                              // child: team1ImageId.isNotEmpty
                              //     ? ImageDisplay(imageId: team1ImageId)
                              //     : const Icon(Icons.error),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              team1,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 18,
                              backgroundImage: CachedNetworkImageProvider('$image1'),
                              // child: team2ImageId.isNotEmpty
                              //     ? ImageDisplay(imageId: team2ImageId)
                              //     : const Icon(Icons.error),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              team2,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.1,
                    height: MediaQuery.of(context).size.height * 0.09,
                    color: Colors.white,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        const Text(
                          "Start at:",
                          style: TextStyle(color: Color(0xffc9c2c2)),
                        ),
                        Text(
                          startTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
