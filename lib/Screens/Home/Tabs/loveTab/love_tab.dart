import 'package:eventlyy/Providers/event_provider.dart';
import 'package:eventlyy/Providers/user_provider.dart';
import 'package:eventlyy/Screens/Home/Events/event_item.dart';
import 'package:eventlyy/Widgets/default_text_field.dart';
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
    TextEditingController searchController = TextEditingController();
        AppLocalizations localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DefaultTextField(text: localizations.love_tab_search_for_event, controller: searchController, hasPrefix: true, icon: CupertinoIcons.search,),
            const SizedBox(height: 16),
            Expanded(
              child:
                  eventProvider.favouriteEvents.isEmpty
                      ? Lottie.asset('assets/lottie/EmptyBox.json')
                      : ListView.separated(
                        itemBuilder:
                            (context, index) => EventItem(
                              event: eventProvider.favouriteEvents[index],
                            ),
                        separatorBuilder: (_, __) => SizedBox(height: 16),
                        itemCount: eventProvider.favouriteEvents.length,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
