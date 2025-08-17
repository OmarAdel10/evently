import 'package:eventlyy/Models/event_model.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatefulWidget {
  static const String routeName = '/event-details';
  final EventModel event;

  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.event_details),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.pencil)),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.delete, color: Apptheme.red),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.asset(
                  'assets/images/${widget.event.category.imageName}.png',
                  height: MediaQuery.sizeOf(context).height * 0.25,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.event.title,
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Apptheme.primary),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Apptheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        CupertinoIcons.calendar,
                        color: Apptheme.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd MMMM yyyy').format(widget.event.dateTime),
                          style: textTheme.titleMedium!.copyWith(
                            color: Apptheme.primary,
                          ),
                        ),
                        Text(DateFormat('hh : mm a').format(widget.event.dateTime), style: textTheme.titleMedium),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Apptheme.primary),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Apptheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(CupertinoIcons.scope, color: Apptheme.white),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Cairo , Egypt',
                      style: textTheme.titleMedium!.copyWith(
                        color: Apptheme.primary,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      CupertinoIcons.forward,
                      size: 24,
                      color: Apptheme.primary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: size.height * 0.36,
                decoration: BoxDecoration(
                  border: Border.all(color: Apptheme.primary),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: Text('Map')),
              ),
              const SizedBox(height: 16),
              Text(
                localizations.description,
                style: textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              Text(
                widget.event.description,
                style: textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
