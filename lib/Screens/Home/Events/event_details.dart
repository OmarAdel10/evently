import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Models/category_model.dart';
import 'package:eventlyy/Models/event_model.dart';
import 'package:eventlyy/Providers/event_provider.dart';
import 'package:eventlyy/Providers/settings_provider.dart';
import 'package:eventlyy/Providers/user_provider.dart';
import 'package:eventlyy/Screens/Home/Tabs/homeTab/tabBar_item.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/Widgets/default_text_field.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';

class EventDetails extends StatefulWidget {
  static const String routeName = '/event-details';
  final EventModel event;

  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool isEdit = false;
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  int _currentIndex = 0;
  CategoryModel selectedCategory = CategoryModel.categories.first;
  late bool isLoading;
  late String userName;

  @override
  void initState() {
    super.initState();
    getUserNAME();
    isLoadingShimmer();
  }

  Future<void> getUserNAME() async {
    userName = await FirebaseServices.getUserName();
  }

  Future<void> isLoadingShimmer() async {
    isLoading = true;
    await Future.delayed(Duration(milliseconds: 200), () {
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    bool isCreator = eventProvider.isCreatorOfThisEvent(
      widget.event.userId,
      Provider.of<UserProvider>(context, listen: false).currentUser!.id,
    );
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? localizations.edit_event_screen_edit_event
              : localizations.event_details,
        ),
        actions:
            isCreator
                ? [
                  IconButton(
                    onPressed: () {
                      isEdit = !isEdit;
                      if (isEdit) {
                        selectedCategory = widget.event.category;
                        _currentIndex = CategoryModel.categories.indexWhere(
                          (category) => category.id == widget.event.category.id,
                        );
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      isEdit
                          ? CupertinoIcons.pencil_slash
                          : CupertinoIcons.pencil,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      FirebaseServices.deleteEvent(widget.event.id).then((_) {
                        Provider.of<EventProvider>(context, listen: false).getEvents();
                        Navigator.of(context).pop();
                        DelightToastBar(
                          position: DelightSnackbarPosition.top,
                          autoDismiss: true,
                          snackbarDuration: Duration(seconds: 2),
                          builder: (context) {
                            return ToastCard(
                              color: Colors.green,
                              leading: SizedBox(
                                width: 30,
                                height: 30,
                                child: Transform.scale(
                                  scale: 4,
                                  child: Lottie.asset(
                                    'assets/lottie/successfully2.json',
                                  ),
                                ),
                              ),
                              title: Text(
                                AppLocalizations.of(
                                  context,
                                )!.event_removed_successfully,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Apptheme.white,
                                ),
                              ),
                            );
                          },
                        ).show(context);
                      });
                    },
                    icon: Icon(CupertinoIcons.delete, color: Apptheme.red),
                  ),
                ]
                : null,
      ),
      body: SingleChildScrollView(
        child:
            isEdit
                ? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Apptheme.primary,
                        border: Border.all(color: Apptheme.primary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadiusGeometry.circular(16),
                        child: Image.asset(
                          'assets/images/${selectedCategory.imageName}.png',
                          height: MediaQuery.sizeOf(context).height * 0.23,
                        ).redacted(context: context, redact: isLoading),
                      ),
                    ).redacted(context: context, redact: isLoading),
                    DefaultTabController(
                      length: CategoryModel.categories.length,
                      child: TabBar(
                        padding: EdgeInsets.only(left: 16),
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        labelPadding: EdgeInsets.only(right: 10),
                        tabAlignment: TabAlignment.start,
                        onTap: (index) {
                          if (_currentIndex == index) return;
                          _currentIndex = index;
                          selectedCategory =
                              CategoryModel.categories[_currentIndex];
                          isLoadingShimmer();
                          setState(() {});
                        },
                        tabs: [
                          ...CategoryModel.categories.map(
                            (category) => TabbarItem(
                              icon: category.icon,
                              label: category.name,
                              isSelected:
                                  _currentIndex ==
                                  CategoryModel.categories.indexOf(category),
                              selectedBackgroundColor: Apptheme.primary,
                              selectedForegroundColor:
                                  settingsProvider.isDark
                                      ? Apptheme.darkModeBackGround
                                      : Apptheme.white,
                              unselectedForegroundColor: Apptheme.primary,
                              borderColor: Apptheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizations.title,
                              style: textTheme.titleMedium!.copyWith(
                                color:
                                    settingsProvider.isDark
                                        ? Apptheme.white
                                        : Apptheme.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DefaultTextField(
                              text: widget.event.title,
                              hasPrefix: true,
                              icon: CupertinoIcons.square_pencil,
                              controller: _eventController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return localizations.field_can_not_be_empty;
                                }
                                if (value.length < 3) {
                                  return localizations
                                      .title_can_not_be_less_than_3_characters;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              localizations.description,
                              style: textTheme.titleMedium!.copyWith(
                                color:
                                    settingsProvider.isDark
                                        ? Apptheme.white
                                        : Apptheme.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DefaultTextField(
                              text: widget.event.description,
                              controller: _descriptionController,
                              maxLines: 4,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return localizations.field_can_not_be_empty;
                                }
                                if (value.length <= 10) {
                                  return localizations
                                      .description_can_not_be_less_than_10_characters;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.calendar,
                                  size: 24,
                                  color:
                                      settingsProvider.isDark
                                          ? Apptheme.white
                                          : Apptheme.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  localizations.event_date,
                                  style: textTheme.titleMedium!.copyWith(
                                    color:
                                        settingsProvider.isDark
                                            ? Apptheme.white
                                            : Apptheme.black,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? date = await showDatePicker(
                                      barrierDismissible: true,
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (date == null) {
                                      DelightToastBar(
                                        position: DelightSnackbarPosition.top,
                                        autoDismiss: true,
                                        snackbarDuration: Duration(seconds: 2),
                                        builder: (context) {
                                          return ToastCard(
                                            color: Apptheme.red,
                                            leading: SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Transform.scale(
                                                scale: 3,
                                                child: Lottie.asset(
                                                  'assets/lottie/Failed.json',
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              localizations
                                                  .please_provide_a_date,
                                              style: textTheme.titleMedium!
                                                  .copyWith(
                                                    color: Apptheme.white,
                                                  ),
                                            ),
                                          );
                                        },
                                      ).show(context);
                                    }
                                    if (date != null) {
                                      setState(() {
                                        selectedDate = date;
                                      });
                                    }
                                  },
                                  child: Text(
                                    selectedDate == null
                                        ? DateFormat(
                                          'dd/MM/yyyy',
                                          settingsProvider.languageCode,
                                        ).format(widget.event.dateTime)
                                        : dateFormat.format(selectedDate!),
                                    style: textTheme.titleMedium!.copyWith(
                                      color: Apptheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.time,
                                  size: 24,
                                  color:
                                      settingsProvider.isDark
                                          ? Apptheme.white
                                          : Apptheme.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  localizations.event_time,
                                  style: textTheme.titleMedium!.copyWith(
                                    color:
                                        settingsProvider.isDark
                                            ? Apptheme.white
                                            : Apptheme.black,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    TimeOfDay? time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      barrierDismissible: true,
                                    );
                                    if (time == null) {
                                      DelightToastBar(
                                        position: DelightSnackbarPosition.top,
                                        autoDismiss: true,
                                        snackbarDuration: Duration(seconds: 2),
                                        builder: (context) {
                                          return ToastCard(
                                            color: Apptheme.red,
                                            leading: SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Transform.scale(
                                                scale: 3,
                                                child: Lottie.asset(
                                                  'assets/lottie/Failed.json',
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              localizations
                                                  .please_provide_a_time,
                                              style: textTheme.titleMedium!
                                                  .copyWith(
                                                    color: Apptheme.white,
                                                  ),
                                            ),
                                          );
                                        },
                                      ).show(context);
                                    }
                                    if (time != null) {
                                      setState(() {
                                        selectedTime = time;
                                      });
                                    }
                                  },
                                  child: Text(
                                    selectedTime == null
                                        ? DateFormat(
                                          'hh : mm a',
                                          settingsProvider.languageCode,
                                        ).format(widget.event.dateTime)
                                        : selectedTime!.format(context),
                                    style: textTheme.titleMedium!.copyWith(
                                      color: Apptheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              localizations.location,
                              style: textTheme.titleMedium!.copyWith(
                                color:
                                    settingsProvider.isDark
                                        ? Apptheme.white
                                        : Apptheme.black,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(8),
                                backgroundColor:
                                    settingsProvider.isDark
                                        ? Apptheme.darkModeBackGround
                                        : Apptheme.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    16,
                                  ),
                                  side: BorderSide(color: Apptheme.primary),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 46,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      color: Apptheme.primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.scope,
                                      color: Apptheme.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    localizations.choose_event_location,
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
                            const SizedBox(height: 8),
                            Center(
                              child: Text(
                                '<<<! Not Working Right Now !>>>',
                                style: textTheme.titleMedium!.copyWith(
                                  color: Apptheme.grey.withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: DefaultElevatedButton(
                                text:
                                    localizations
                                        .edit_event_screen_update_event,
                                onPressed: updateEvent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                : Padding(
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
                      Text(widget.event.title, style: textTheme.headlineMedium),
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
                                  DateFormat(
                                    'dd MMMM yyyy',
                                    settingsProvider.languageCode,
                                  ).format(widget.event.dateTime),
                                  style: textTheme.titleMedium!.copyWith(
                                    color: Apptheme.primary,
                                  ),
                                ),
                                Text(
                                  DateFormat(
                                    'hh : mm a',
                                    settingsProvider.languageCode,
                                  ).format(widget.event.dateTime),
                                  style: textTheme.titleMedium!.copyWith(
                                    color:
                                        settingsProvider.isDark
                                            ? Apptheme.white
                                            : Apptheme.black,
                                  ),
                                ),
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
                              child: Icon(
                                CupertinoIcons.scope,
                                color: Apptheme.white,
                              ),
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
                        style: textTheme.titleMedium!.copyWith(
                          color:
                              settingsProvider.isDark
                                  ? Apptheme.white
                                  : Apptheme.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        widget.event.description,
                        style: textTheme.titleMedium!.copyWith(
                          color:
                              settingsProvider.isDark
                                  ? Apptheme.white
                                  : Apptheme.black,
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  void updateEvent() {
    if (_formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      EventModel event = EventModel(
        id: widget.event.id,
        userId: FirebaseAuth.instance.currentUser!.uid,
        userCreatedThisEventName: userName,
        title: _eventController.text,
        description: _descriptionController.text,
        category: selectedCategory,
        dateTime: dateTime,
      );
      FirebaseServices.updateEventDetails(event.id, event).then((_) {
        Navigator.of(context).pop();
        Provider.of<EventProvider>(context, listen: false).getEvents();
        DelightToastBar(
          position: DelightSnackbarPosition.top,
          autoDismiss: true,
          snackbarDuration: Duration(seconds: 2),
          builder: (context) {
            return ToastCard(
              color: Colors.green,
              leading: SizedBox(
                width: 30,
                height: 30,
                child: Transform.scale(
                  scale: 4,
                  child: Lottie.asset('assets/lottie/successfully2.json'),
                ),
              ),
              title: Text(
                AppLocalizations.of(context)!.event_added_successfully,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Apptheme.white,
                ),
              ),
            );
          },
        ).show(context);
      });
    }
  }
}
