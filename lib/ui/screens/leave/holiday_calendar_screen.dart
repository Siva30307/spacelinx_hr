import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/leave_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';

class HolidayCalendarScreen extends StatefulWidget {
  const HolidayCalendarScreen({super.key});

  @override
  State<HolidayCalendarScreen> createState() => _HolidayCalendarScreenState();
}

class _HolidayCalendarScreenState extends State<HolidayCalendarScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaveProvider>(context, listen: false).fetchHolidayCalendars();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Holiday Calendars', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
      ),
      body: Consumer<LeaveProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.holidayCalendars.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.holidayCalendars.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_month_outlined, size: 64, color: Colors.white.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'No holiday calendars found',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: provider.holidayCalendars.length,
            itemBuilder: (context, index) {
              final calendar = provider.holidayCalendars[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  calendar.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Year: ${calendar.year}',
                                  style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.6)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green.withValues(alpha: 0.5)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.calendar_today, size: 14, color: Colors.green),
                                const SizedBox(width: 4),
                                Text(
                                  '${calendar.year}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (calendar.location != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 14, color: Colors.white.withValues(alpha: 0.5)),
                            const SizedBox(width: 4),
                            Text(
                              calendar.location!.name,
                              style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.5)),
                            ),
                          ],
                        ),
                      ],
                      const Divider(height: 24, color: Colors.white12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              _showHolidaysDialog(context, calendar.id, calendar.name);
                            },
                            icon: const Icon(Icons.visibility_outlined, size: 16),
                            label: const Text('View Holidays'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showHolidaysDialog(BuildContext context, String calendarId, String calendarName) {
    final provider = Provider.of<LeaveProvider>(context, listen: false);
    provider.fetchHolidaysByCalendar(calendarId);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Consumer<LeaveProvider>(
              builder: (context, provider, _) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        calendarName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    if (provider.isLoading)
                      const Expanded(child: Center(child: CircularProgressIndicator()))
                    else if (provider.holidays.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text(
                            'No holidays in this calendar',
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: provider.holidays.length,
                          itemBuilder: (context, index) {
                            final holiday = provider.holidays[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: _getHolidayColor(holiday.type).withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        _getHolidayIcon(holiday.type),
                                        color: _getHolidayColor(holiday.type),
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          holiday.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          holiday.holidayDate,
                                          style: TextStyle(
                                            color: Colors.white.withValues(alpha: 0.5),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: _getHolidayColor(holiday.type).withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          holiday.type,
                                          style: TextStyle(
                                            color: _getHolidayColor(holiday.type),
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      if (holiday.isOptional) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          'Optional',
                                          style: TextStyle(
                                            color: Colors.white.withValues(alpha: 0.4),
                                            fontSize: 10,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Color _getHolidayColor(String type) {
    switch (type.toLowerCase()) {
      case 'national':
        return Colors.orange;
      case 'regional':
        return Colors.blue;
      case 'restricted':
        return Colors.purple;
      default:
        return Colors.teal;
    }
  }

  IconData _getHolidayIcon(String type) {
    switch (type.toLowerCase()) {
      case 'national':
        return Icons.flag;
      case 'regional':
        return Icons.location_city;
      case 'restricted':
        return Icons.lock_clock;
      default:
        return Icons.celebration;
    }
  }
}
