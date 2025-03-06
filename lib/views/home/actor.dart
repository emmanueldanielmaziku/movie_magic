import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ActorProfile extends StatefulWidget {
  final int actorId; // Actor ID passed from the Film Screen
  const ActorProfile({super.key, required this.actorId});

  @override
  State<ActorProfile> createState() => _ActorProfileState();
}

class _ActorProfileState extends State<ActorProfile> {
  late Future<Map<String, dynamic>> _actorFuture;

  @override
  void initState() {
    super.initState();

    _actorFuture = _fetchActorData(widget.actorId);
  }

  Future<Map<String, dynamic>> _fetchActorData(int actorId) async {
    await Future.delayed(const Duration(seconds: 2));

    // Dummy data for demonstration
    final dummyActors = [
      {
        'id': 1,
        'name': 'Zoe Saldana',
        'image':
            'https://via.placeholder.com/400x600/123456/FFFFFF?text=Zoe+Saldana',
        'rank': 'Top 107 IMDb',
        'roles': 'Actress • Producer • Writer',
        'birthDate': 'June 19, 1978',
        'bio':
            'Zoe Saldana was born on June 19, 1978 in Passaic, New Jersey, to Asalia Nazario and Aridio Saldana. Her father was Dominican and her mother is Puerto Rican. She was raised in Queens, New York. When she was 10 years old, she and her family moved to the Dominican Republic, where they would live for the next seven years...',
        'filmography': [
          {
            'title': 'Guardians of the Galaxy Vol. 3',
            'role': 'Gamora',
            'image':
                'https://via.placeholder.com/200x300/234567/FFFFFF?text=GOTG+Vol+3',
          },
          {
            'title': 'Guardians of the Galaxy Vol. 1',
            'role': 'Gamora',
            'image':
                'https://via.placeholder.com/200x300/345678/FFFFFF?text=GOTG+Vol+1',
          },
          {
            'title': 'Avatar',
            'role': 'Neytiri',
            'image':
                'https://via.placeholder.com/200x300/456789/FFFFFF?text=Avatar',
          },
        ],
        'quickFacts': {
          'birthCity': 'Passaic',
          'birthCountry': 'United States',
        },
        'photos': [
          'https://occ-0-8407-116.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABSnpnCU2Bb-QjJmTVcTU6gG57sYTE-q2UOx2GsLEjFX83tNvgxB5yFtpqyJQGAAB21o_O9VYKdOKPfxe7joIcWaMPhrF3YRfNNBP.jpg?r=afe',
          'https://occ-0-8407-116.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABSnpnCU2Bb-QjJmTVcTU6gG57sYTE-q2UOx2GsLEjFX83tNvgxB5yFtpqyJQGAAB21o_O9VYKdOKPfxe7joIcWaMPhrF3YRfNNBP.jpg?r=afe',
          'https://occ-0-8407-116.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABSnpnCU2Bb-QjJmTVcTU6gG57sYTE-q2UOx2GsLEjFX83tNvgxB5yFtpqyJQGAAB21o_O9VYKdOKPfxe7joIcWaMPhrF3YRfNNBP.jpg?r=afe',
        ],
      },
      // Add more actors as needed
    ];

    // Find the actor with the matching ID
    final actor = dummyActors.firstWhere(
      (actor) => actor['id'] == actorId,
      orElse: () => throw 'Actor not found with ID: $actorId',
    );

    return actor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1218),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _actorFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data found'));
            }

            final actor = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo Carousel
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 400,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: true,
                        ),
                        items: actor['photos'].map<Widget>((photo) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(photo),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      // Back button
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Profile Info
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Roles and Birth Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              actor['roles'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              actor['birthDate'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Name
                        Text(
                          actor['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Bio
                        Text(
                          actor['bio'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        // More Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text(
                                    'More',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Filmography
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Filmography',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 16),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Filmography Grid
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: actor['filmography'].length,
                            itemBuilder: (context, index) {
                              final film = actor['filmography'][index];
                              return Container(
                                width: 180,
                                margin: const EdgeInsets.only(right: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Film Image
                                    Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(film['image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Role
                                    Text(
                                      'Role - ${film['role']}',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 12,
                                      ),
                                    ),
                                    // Film Title
                                    Text(
                                      film['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Quick Facts
                        const Text(
                          'Quick Facts',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Birth City
                        Row(
                          children: [
                            const Text(
                              'Birth City:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              actor['quickFacts']['birthCity'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Birth Country
                        Row(
                          children: [
                            const Text(
                              'Birth Country:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              actor['quickFacts']['birthCountry'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
