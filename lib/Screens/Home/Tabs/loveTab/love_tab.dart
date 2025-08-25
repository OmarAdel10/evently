import 'package:eventlyy/Providers/event_provider.dart';
import 'package:eventlyy/Providers/settings_provider.dart';
import 'package:eventlyy/Providers/user_provider.dart';
import 'package:eventlyy/Screens/Home/Events/event_item.dart';
import 'package:eventlyy/Widgets/default_text_field.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoveTab extends StatefulWidget {
  const LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  late EventProvider eventProvider;
  final TextEditingController _searchController = TextEditingController();
  bool isFound = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      List<String> favouriteEventsIds =
          Provider.of<UserProvider>(
            context,
            listen: false,
          ).currentUser!.favouriteEventsIds;
      eventProvider.filterFavouriteEvents(favouriteEventsIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);
    AppLocalizations localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DefaultTextField(
              text: localizations.love_tab_search_for_event_by_title_or_description,
              controller: _searchController,
              hasPrefix: true,
              icon: CupertinoIcons.search,
              onChanged: (query) {
                eventProvider.searchResult(query);
                if (eventProvider.displayedFavouriteEvents.isEmpty) {
                  isFound = false;
                  setState(() {});
                }
                if (query.isEmpty) {
                  isFound = true;
                  setState(() {});
                }
              },
            ),

            const SizedBox(height: 16),
            Expanded(
              child:
                  eventProvider.displayedFavouriteEvents.isEmpty
                      ? isFound
                          ? Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.3,
                              ),
                              Lottie.asset('assets/lottie/EmptyBox.json'),
                              const SizedBox(height: 16),
                              Text(
                                localizations.no_favourite_events_found,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium!.copyWith(
                                  color:
                                      Provider.of<SettingsProvider>(
                                            context,
                                            listen: false,
                                          ).isDark
                                          ? Apptheme.white
                                          : Apptheme.black,
                                ),
                              ),
                            ],
                          )
                          : Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.15,
                              ),
                              Lottie.asset('assets/lottie/NodataFound.json'),
                            ],
                          )
                      : ListView.separated(
                        itemBuilder:
                            (context, index) => EventItem(
                              event:
                                  eventProvider.displayedFavouriteEvents[index],
                            ),
                        separatorBuilder: (_, __) => SizedBox(height: 16),
                        itemCount:
                            eventProvider.displayedFavouriteEvents.length,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
