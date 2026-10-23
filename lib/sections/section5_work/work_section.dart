import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/utils/constants.dart';
import 'package:jatinchaudhary/utils/links.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
   bool isMobile = MediaQuery.of(context).size.width < 600;
   
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: isMobile ? 3500 : 1800,

      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 800,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Work", style: AppTextStyles.sectionHeadingStyle),
            SizedBox(height: 70),

            isMobile ? 

            Column(
              children: [
                appsSection(isMobile: true),
                SizedBox(height: 20,),
                pubSection(isMobile: true)
              ],
            ) : 

            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              appsSection(),
           
              SizedBox(width: 10,),

              pubSection()

              ],
            )




          ],
        ),
      ),
    );
  }




  Widget appsSection({bool isMobile = false}) {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WorkBox(
                      title: "Junglee Rummy",
                      description: "Real-money rummy platform: deposit stack with custom UPI & CVV-less payments.",
                      height: 400,
                      width: 350,
                      color: const Color.fromARGB(202, 119, 72, 63),
                      tags: ["Flutter", "UPI Payments", "Shorebird"],
                      assetPath: Constants.jungleeRummy,
                      isLeftColumn: true,
                    ),

                    SizedBox(height: isMobile ? 20 : 10,),

                    WorkBox(
                      title: "MB Daily",
                      description: "Quick-commerce platform serving 5K+ users and ~1K orders/day.",
                      height: 400,
                      width: 350,
                      color: const Color.fromARGB(226, 168, 131, 69),
                      tags: ["Spring Boot", "Kafka", "Flutter"],
                      assetPath: Constants.mbDaily,
                      isLeftColumn: true,
                    ),


                    SizedBox(height: isMobile ? 20 : 10,),

                    WorkBox(
                      title: "GPS Orbit",
                      description: "A live tracking of vehicle.",
                      height: 400,
                      width: 350,
                      color: const Color.fromARGB(225, 132, 180, 173),
                      tags: ["Flutter", "Dart", "ios", "Android"],
                      assetPath: Constants.gpsOrbit,
                      isLeftColumn: true,
                    ),


                    SizedBox(height: isMobile ? 20 : 10,),

                    WorkBox(
                      title: "NorthLadder",
                      description: "Olx for dubai",
                      height: 400,
                      width: 350,
                      color: const Color.fromARGB(155, 135, 121, 160),
                      tags: ["Flutter", "Dart", "ios", "Android"],
                      assetPath: Constants.northLadder,
                      isLeftColumn: true,
                    ),
                  ],
                );
   
  }

  Widget pubSection({bool isMobile = false}) {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WorkBox(
                      title: "LocusPlay",
                      description: "Game-agnostic AI player profiling: matchmaking, adaptive difficulty and wellbeing detection with zero inference on the request path.",
                      height: 310,
                      width: 400,
                      color: const Color.fromARGB(220, 46, 86, 160),
                      tags: ["LLM", "Vector KNN", "Prompt Caching"],
                      url: Links.locusPlay,
                      highlight: "~40x",
                      highlightLabel: "lower model spend, 1-7 ms real-time reads",
                    ),
                    SizedBox(height: isMobile ? 20 : 10,),

                    WorkBox(
                      title: "AstroRegal",
                      description: "AI astro-psychology companion with a dual-agent orchestrator on a KP/Vedic chart engine built from scratch.",
                      height: 310,
                      width: 400,
                      color: const Color.fromARGB(215, 98, 62, 150),
                      tags: ["Multi-agent", "Redis", "Swiss Ephemeris"],
                      url: Links.astroRegal,
                      highlight: "~10x",
                      highlightLabel: "lower projected inference spend via intent-based model routing",
                    ),

                    SizedBox(height: isMobile ? 20 : 10,),

                    WorkBox(
                      title: "UK Raffle Platform",
                      description: "Backend for a UK-market raffle platform with an Instant Win engine for real-time, concurrency-safe prize resolution.",
                      height: 310,
                      width: 400,
                      color: const Color.fromARGB(215, 24, 120, 104),
                      tags: ["Backend", "Concurrency", "System Design"],
                      highlight: "120K+",
                      highlightLabel: "active users, shipped in 97 days",
                    ),


                    SizedBox(height: isMobile ? 20 : 10,),

                    WorkBox(
                      title: "LLM PR Reviewer",
                      description: "Automated review of diffs for architecture violations, performance regressions and convention drift.",
                      height: 310,
                      width: 400,
                      color: const Color.fromARGB(210, 150, 60, 60),
                      tags: ["LLM", "Code Review", "Dev Tooling"],
                      highlight: "Team-wide",
                      highlightLabel: "adoption at Junglee Games",
                    ),

                     SizedBox(height: isMobile ? 20 : 10,),

                    WorkBox(
                      title: "Feature ToolTip",
                      description: "A tooltip that provides information about a feature.",
                      height: 350,
                      width: 400,
                      color: const Color.fromARGB(227, 2, 89, 161),
                      tags: ["Flutter", "Dart"],
                      assetPath: Constants.featureToolTip,
                    )
                  ],
                );

  }

}



class WorkBox extends StatefulWidget {

  final double height;
  final double width;
  final Color color;
  final String title;
  final String description;
  final List<String> tags;
  final String? assetPath;
  final bool isLeftColumn;
  final String? highlight;
  final String? highlightLabel;
  final String? url;
  

  const WorkBox({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.title,
    required this.description,
    required this.tags,
    this.assetPath,
    this.isLeftColumn = false,
    this.highlight,
    this.highlightLabel,
    this.url,
  });

  @override
  State<WorkBox> createState() => _WorkBoxState();
}

class _WorkBoxState extends State<WorkBox> {
  @override
  Widget build(BuildContext context) {
    final box = _buildBox();
    if (widget.url == null) return box;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Links.open(widget.url!),
        child: box,
      ),
    );
  }

  Widget _buildBox() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
         // borderRadius: BorderRadius.circular(10),
        
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.color,
              widget.color.withAlpha(150),
            ])
        ),
      
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
      
      
            if (widget.assetPath != null)
            widget.isLeftColumn ?
      
            Positioned(
              top: 120,
              left:80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                widget.assetPath!,
                width: 300,
                height: 600,
                fit: BoxFit.cover,
                ),
              ),
            ) :
      
            Positioned(
              top: 100,
              left: 30,
              child: Image.asset(
                widget.assetPath!,
                 
                width: 700,
                 height: 400,
                 ),
            ),
      
      
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                blendMode: BlendMode.srcATop,
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(22, 0, 0, 0).withOpacity(0.3),
                        const Color.fromARGB(255, 0, 0, 0),
                      ]),
                  ),
              ),
              ),
            ),
      
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.title, style: AppTextStyles.workTitleStyle),
                      if (widget.url != null) ...[
                        SizedBox(width: 6),
                        Icon(Icons.north_east, size: 16, color: const Color.fromARGB(180, 225, 225, 225)),
                      ],
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(widget.description, style: AppTextStyles.sectionContentStyle.copyWith(height: 1.5)),
                  if (widget.highlight != null) ...[
                    SizedBox(height: 30),
                    Text(widget.highlight!, style: AppTextStyles.sectionHeadingStyle.copyWith(fontSize: 40)),
                    if (widget.highlightLabel != null) ...[
                      SizedBox(height: 8),
                      Text(widget.highlightLabel!, style: AppTextStyles.sectionContentStyle.copyWith(height: 1.4)),
                    ],
                  ],
                  Spacer(),
                
                  SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < widget.tags.length; i++) ...[
                        Text(widget.tags[i], style: AppTextStyles.sectionContentStyle),

                        SizedBox(width: 10,),

                        Container(
                            width: 1 ,
                            height: 10,
                            color: 
                            i == widget.tags.length - 1 ? Colors.transparent : 
                            const Color.fromARGB(61, 218, 218, 218),
                          ),

                        SizedBox(width: 10,),
                      ],
                    ],
                  ),
                )
              
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}