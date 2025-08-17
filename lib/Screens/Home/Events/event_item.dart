import 'package:eventlyy/Models/event_model.dart';
import 'package:eventlyy/Providers/event_provider.dart';
import 'package:eventlyy/Providers/settings_provider.dart';
import 'package:eventlyy/Providers/user_provider.dart';
import 'package:eventlyy/Screens/Home/Events/event_details.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  final EventModel event;
  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    bool isFavourite = userProvider.checkIsEventFavourite(event.id);
    AppLocalizations localizations = AppLocalizations.of(context)!;
    bool isarabic = Localizations.localeOf(context).languageCode == 'ar';
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(EventDetails.routeName, arguments: event);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Apptheme.primary),
          color: Apptheme.primary,
          borderRadius: BorderRadius.circular(17),
        ),
        child: Stack(
          children: [
            ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.asset(
                'assets/images/${event.category.imageName}.png',
                height: MediaQuery.sizeOf(context).height * 0.24,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    settingsProvider.isDark
                        ? Apptheme.darkModeBackGround
                        : Apptheme.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Apptheme.primary),
              ),
              child: Column(
                children: [
                  Text(
                    '${event.dateTime.day}',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 16),
                  ),
                  Text(
                    DateFormat('MMM').format(event.dateTime),
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: isarabic ? null : 8,
              left: isarabic ? 8 : null,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      settingsProvider.isDark
                          ? Apptheme.darkModeBackGround
                          : Apptheme.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Apptheme.primary),
                ),
                child: Text(
                  '${localizations.created_by} ${event.userCreatedThisEventName}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontSize: 12),
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.sizeOf(context).width - 32,
              bottom: 8,
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color:
                      settingsProvider.isDark
                          ? Apptheme.darkModeBackGround
                          : Apptheme.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Apptheme.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color:
                              settingsProvider.isDark
                                  ? Apptheme.white
                                  : Apptheme.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        if (isFavourite) {
                          userProvider.removeEventFromFavourites(event.id);
                          Provider.of<EventProvider>(
                            context,
                            listen: false,
                          ).filterFavouriteEvents(
                            userProvider.currentUser!.favouriteEventsIds,
                          );
                        } else {
                          userProvider.addEventToFavourites(event.id);
                        }
                      },
                      child: Icon(
                        isFavourite
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: Apptheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
