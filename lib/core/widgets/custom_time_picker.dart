import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeChanged;

  const CustomTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int _selectedHour;
  late int _selectedMinute;
  late bool _isAM;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.initialTime.hour % 12 == 0 ? 12 : widget.initialTime.hour % 12;
    _selectedMinute = widget.initialTime.minute;
    _isAM = widget.initialTime.hour < 12;
  }

  void _updateTime() {
    if (!mounted) return;
    
    int hour = _selectedHour;
    if (!_isAM && hour != 12) {
      hour += 12;
    } else if (_isAM && hour == 12) {
      hour = 0;
    }
    widget.onTimeChanged(TimeOfDay(hour: hour, minute: _selectedMinute));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Time',
                style: AppTheme.subheadingStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
                icon: Icon(
                  Icons.close,
                  color: AppTheme.textSecondaryColor,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Time display
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hour
                _buildTimeSegment(
                  value: _selectedHour.toString().padLeft(2, '0'),
                  onIncrement: () {
                    setState(() {
                      _selectedHour = (_selectedHour % 12) + 1;
                      _updateTime();
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      _selectedHour = _selectedHour == 1 ? 12 : _selectedHour - 1;
                      _updateTime();
                    });
                  },
                ),
                
                // Separator
                Text(
                  ':',
                  style: AppTheme.headingStyle.copyWith(
                    fontSize: 32,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                
                // Minute
                _buildTimeSegment(
                  value: _selectedMinute.toString().padLeft(2, '0'),
                  onIncrement: () {
                    setState(() {
                      _selectedMinute = (_selectedMinute + 15) % 60;
                      _updateTime();
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      _selectedMinute = _selectedMinute == 0 ? 45 : _selectedMinute - 15;
                      _updateTime();
                    });
                  },
                ),
                
                const SizedBox(width: 20),
                
                // AM/PM selector
                _buildAMPMSelector(),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Quick time buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickTimeButton('Now', () {
                if (!mounted) return;
                final now = TimeOfDay.now();
                setState(() {
                  _selectedHour = now.hour % 12 == 0 ? 12 : now.hour % 12;
                  _selectedMinute = now.minute;
                  _isAM = now.hour < 12;
                });
                _updateTime();
              }),
              _buildQuickTimeButton('9:00 AM', () {
                if (!mounted) return;
                setState(() {
                  _selectedHour = 9;
                  _selectedMinute = 0;
                  _isAM = true;
                });
                _updateTime();
              }),
              _buildQuickTimeButton('12:00 PM', () {
                if (!mounted) return;
                setState(() {
                  _selectedHour = 12;
                  _selectedMinute = 0;
                  _isAM = false;
                });
                _updateTime();
              }),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Confirm button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                if (!mounted) return;
                
                final selectedTime = TimeOfDay(
                  hour: _isAM ? (_selectedHour == 12 ? 0 : _selectedHour) : (_selectedHour == 12 ? 12 : _selectedHour + 12),
                  minute: _selectedMinute,
                );
                Navigator.of(context).pop(selectedTime);
              },
              style: AppTheme.primaryButtonStyle.copyWith(
                backgroundColor: WidgetStateProperty.all(AppTheme.primaryColor),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              child: Text(
                'Confirm',
                style: AppTheme.bodyStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSegment({
    required String value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Column(
      children: [
        // Increment button
        Container(
          width: 40,
          height: 32,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onIncrement,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
              child: Icon(
                Icons.keyboard_arrow_up,
                color: AppTheme.primaryColor,
                size: 20,
              ),
            ),
          ),
        ),
        
        // Value display
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            border: Border.symmetric(
              horizontal: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
            ),
          ),
          child: Center(
            child: Text(
              value,
              style: AppTheme.headingStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
          ),
        ),
        
        // Decrement button
        Container(
          width: 40,
          height: 32,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(6)),
            border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onDecrement,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(6)),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppTheme.primaryColor,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAMPMSelector() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          // AM button
          GestureDetector(
            onTap: () {
              setState(() {
                _isAM = true;
                _updateTime();
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _isAM ? AppTheme.primaryColor : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Text(
                'AM',
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _isAM ? Colors.white : AppTheme.textSecondaryColor,
                ),
              ),
            ),
          ),
          
          // PM button
          GestureDetector(
            onTap: () {
              setState(() {
                _isAM = false;
                _updateTime();
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: !_isAM ? AppTheme.primaryColor : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Text(
                'PM',
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: !_isAM ? Colors.white : AppTheme.textSecondaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickTimeButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Text(
          label,
          style: AppTheme.captionStyle.copyWith(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// Helper function to show custom time picker
Future<TimeOfDay?> showCustomTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) {
  return showDialog<TimeOfDay>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) => Dialog(
      backgroundColor: Colors.transparent,
      child: CustomTimePicker(
        initialTime: initialTime,
        onTimeChanged: (time) {
          Navigator.of(dialogContext).pop(time);
        },
      ),
    ),
  );
}
