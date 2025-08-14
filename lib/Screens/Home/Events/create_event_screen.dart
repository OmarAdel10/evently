import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Models/category_model.dart';
import 'package:eventlyy/Models/event_model.dart';
import 'package:eventlyy/Providers/event_provider.dart';
import 'package:eventlyy/Screens/Home/Tabs/homeTab/tabBar_item.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/Widgets/default_text_field.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = '/create-event';

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
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
  late EventProvider eventProvider;

  @override
  void initState() {
    super.initState();
    getUserNAME();
    isLoadingShimmer();
    // WidgetsBinding.instance.addPostFrameCallback((_) {});
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
    TextTheme textTheme = Theme.of(context).textTheme;
    eventProvider = Provider.of<EventProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            SizedBox(width: 16),
            Hero(
              tag: 'create-event',
              child: GestureDetector(
                child: Icon(Icons.arrow_back_ios, size: 24),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
        title: Text('Create Event'),
      ),

      body: SingleChildScrollView(
        child: Column(
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
                  selectedCategory = CategoryModel.categories[_currentIndex];
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
                      selectedForegroundColor: Apptheme.white,
                      unselectedForegroundColor: Apptheme.primary,
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
                    Text('Title', style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    DefaultTextField(
                      text: 'Event Title',
                      hasPrefix: true,
                      icon: CupertinoIcons.square_pencil,
                      controller: _eventController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field Can Not Be Empty';
                        }
                        if (value.length < 3) {
                          return 'Title Must Be Atleast 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Text('Description', style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    DefaultTextField(
                      text: 'Event Description',
                      controller: _descriptionController,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field Can Not Be Empty';
                        }
                        if (value.length <= 10) {
                          return 'Description Must Be Atleast 10 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(CupertinoIcons.calendar, size: 24),
                        const SizedBox(width: 10),
                        Text('Event Date', style: textTheme.titleMedium),
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
                                      'Please Provide A Date !',
                                      style: textTheme.titleMedium!.copyWith(
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
                                ? 'Choose Date'
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
                        Icon(CupertinoIcons.time, size: 24),
                        const SizedBox(width: 10),
                        Text('Event Time', style: textTheme.titleMedium),
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
                                      'Please Provide A Time !',
                                      style: textTheme.titleMedium!.copyWith(
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
                                ? 'Choose Time'
                                : selectedTime!.format(context),
                            style: textTheme.titleMedium!.copyWith(
                              color: Apptheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Location', style: textTheme.titleMedium),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(8),
                        backgroundColor: Apptheme.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(16),
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
                            'Choose Event Location',
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
                        text: 'Add Event',
                        onPressed: createEvent,
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

  void createEvent() {
    if (_formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null &&
        userName != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      EventModel event = EventModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        userCreatedThisEventName: userName,
        title: _eventController.text,
        description: _descriptionController.text,
        category: selectedCategory,
        dateTime: dateTime,
      );
      FirebaseServices.createEvent(event).then((_) {
        Navigator.of(context).pop();
        eventProvider.getEvents();
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
                'Event Added Successfully !',
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
